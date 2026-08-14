import { randomUUID } from "node:crypto"
import { mkdirSync, renameSync, unlinkSync, writeFileSync } from "node:fs"
import { basename, dirname, join } from "node:path"

function message(error: unknown): string {
  return error instanceof Error ? error.message : String(error)
}

export function saveJsonAtomically(path: string, value: unknown): void {
  const directory = dirname(path)
  const temporaryPath = join(directory, `.${basename(path)}.${process.pid}.${randomUUID()}.tmp`)
  try {
    mkdirSync(directory, { recursive: true })
    writeFileSync(temporaryPath, `${JSON.stringify(value, null, 2)}\n`, { encoding: "utf8", flag: "wx" })
    renameSync(temporaryPath, path)
  } catch (error) {
    try {
      unlinkSync(temporaryPath)
    } catch (cleanupError) {
      if ((cleanupError as NodeJS.ErrnoException).code !== "ENOENT") {
        throw new Error(
          `could not save ${path}: ${message(error)}; could not remove temporary file: ${message(cleanupError)}`,
          { cause: error },
        )
      }
    }
    throw new Error(`could not save ${path}: ${message(error)}`, { cause: error })
  }
}
