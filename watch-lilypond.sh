#!/bin/bash

# LilyPond File Watcher
# Watches for changes to .ly files and automatically compiles them to PDF
# Usage: ./watch-lilypond.sh filename.ly
#        ./watch-lilypond.sh --all|-a  (watch all .ly files)

# Parse arguments
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 filename.ly"
    echo "       $0 --all|-a  (watch all .ly files)"
    exit 1
fi

WATCH_ALL=false
TARGET_FILE=""

if [[ "$1" == "--all" || "$1" == "-a" ]]; then
    WATCH_ALL=true
elif [[ "$1" == *.ly ]]; then
    TARGET_FILE="$1"
    if [[ ! -f "$TARGET_FILE" ]]; then
        echo "Error: File '$TARGET_FILE' does not exist"
        exit 1
    fi
else
    echo "Error: Please specify a .ly file or use --all/-a"
    exit 1
fi

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "Error: fswatch is not installed"
    echo "Install with: brew install fswatch"
    exit 1
fi

# Check if lilypond is installed
if ! command -v lilypond &> /dev/null; then
    echo "Error: lilypond is not installed"
    echo "Install with: brew install lilypond"
    exit 1
fi

# Function to position Preview window on right half of screen
position_preview() {
    osascript -e "
        tell application \"Finder\"
            set screen_bounds to bounds of window of desktop
            set screen_width to item 3 of screen_bounds
            set screen_height to item 4 of screen_bounds
            set half_width to screen_width / 2
        end tell
        tell application \"System Events\"
            tell process \"Preview\"
                set frontmost to true
                tell window 1
                    set position to {half_width, 0}
                    set size to {half_width, screen_height}
                end tell
            end tell
        end tell
    " 2>/dev/null
}

# Function to compile a LilyPond file
compile_ly() {
    local file="$1"
    local pdf_file="${file%.ly}.pdf"
    
    # Run lilypond
    if lilypond "$file"; then
        # Open/reload PDF in Preview
        if [[ -f "$pdf_file" ]]; then
            local full_pdf_path="$(pwd)/$pdf_file"
            osascript -e "
                tell application \"Preview\"
                    set target_path to \"$full_pdf_path\"
                    set doc_found to false
                    set old_doc to missing value
                    if (count of documents) > 0 then
                        repeat with doc in documents
                            try
                                set doc_path to path of doc
                                if doc_path is not missing value then
                                    if doc_path is equal to target_path then
                                        set old_doc to doc
                                        set doc_found to true
                                        exit repeat
                                    end if
                                end if
                            on error
                                -- Skip documents that can't provide a path
                            end try
                        end repeat
                    end if
                    if doc_found then
                        close old_doc
                    end if
                    open POSIX file target_path
                    activate
                end tell
            " 2>/dev/null
            position_preview
        fi
    fi
}

# Function to check and open existing PDFs in Preview
check_existing_pdfs() {
    if [[ "$WATCH_ALL" == true ]]; then
        for ly_file in *.ly; do
            if [[ -f "$ly_file" ]]; then
                local pdf_file="${ly_file%.ly}.pdf"
                if [[ -f "$pdf_file" ]]; then
                    local full_pdf_path="$(pwd)/$pdf_file"
                    osascript -e "
                        tell application \"Preview\"
                            set target_path to \"$full_pdf_path\"
                            set doc_found to false
                            if (count of documents) > 0 then
                                repeat with doc in documents
                                    try
                                        set doc_path to path of doc
                                        if doc_path is not missing value then
                                            if doc_path is equal to target_path then
                                                set doc_found to true
                                                exit repeat
                                            end if
                                        end if
                                    on error
                                        -- Skip documents that can't provide a path
                                    end try
                                end repeat
                            end if
                            if not doc_found then
                                open POSIX file target_path
                                activate
                            end if
                        end tell
                    " 2>/dev/null
                    position_preview
                fi
            fi
        done
    else
        local pdf_file="${TARGET_FILE%.ly}.pdf"
        if [[ -f "$pdf_file" ]]; then
            local full_pdf_path="$(pwd)/$pdf_file"
            osascript -e "
                tell application \"Preview\"
                    set target_path to \"$full_pdf_path\"
                    set doc_found to false
                    if (count of documents) > 0 then
                        repeat with doc in documents
                            try
                                set doc_path to path of doc
                                if doc_path is not missing value then
                                    if doc_path is equal to target_path then
                                        set doc_found to true
                                        exit repeat
                                    end if
                                end if
                            on error
                                -- Skip documents that can't provide a path
                            end try
                        end repeat
                    end if
                    if not doc_found then
                        open POSIX file target_path
                        activate
                    end if
                end tell
            " 2>/dev/null
            position_preview
        fi
    fi
}

# Initial compilation and PDF opening
initial_setup() {
    if [[ "$WATCH_ALL" == true ]]; then
        for ly_file in *.ly; do
            if [[ -f "$ly_file" ]]; then
                local pdf_file="${ly_file%.ly}.pdf"
                if [[ ! -f "$pdf_file" ]]; then
                    echo "Compiling $ly_file for the first time..."
                    compile_ly "$ly_file"
                fi
            fi
        done
    else
        local pdf_file="${TARGET_FILE%.ly}.pdf"
        if [[ ! -f "$pdf_file" ]]; then
            echo "Compiling $TARGET_FILE for the first time..."
            compile_ly "$TARGET_FILE"
        fi
    fi
}

# Run initial setup and check existing PDFs
initial_setup
check_existing_pdfs

# Set up file watching
if [[ "$WATCH_ALL" == true ]]; then
    echo "Watching all .ly files in: $(pwd)"
    fswatch -e ".*" -i "\.ly$" . | while read file; do
        # Only process if file still exists (handles temporary files)
        if [[ -f "$file" ]]; then
            compile_ly "$file"
        fi
    done
else
    echo "Watching: $TARGET_FILE"
    fswatch "$TARGET_FILE" | while read file; do
        compile_ly "$TARGET_FILE"
    done
fi