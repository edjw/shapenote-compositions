#!/usr/bin/env python3
"""
Sacred Harp Chord Analyzer
Analyzes MIDI files from LilyPond compilation for Sacred Harp harmonic compliance
Based on chord rules documented in CLAUDE.md

Requirements: pip install music21
"""

import music21
import sys
import os
from datetime import datetime
from pathlib import Path
from collections import Counter

# Sacred Harp chord rules extracted from CLAUDE.md
SACRED_HARP_RULES = {
    'major': {
        'common': ['I', 'vi', 'V'],
        'quite_common': ['ii', 'IV'],
        'rare': ['iii'],
        'forbidden': ['vii°']
    },
    'minor': {
        'common': ['i', 'VII', 'III'],
        'quite_common': ['v', 'iv'],
        'rare': [],
        'forbidden': ['ii°', 'VI']
    }
}

# Common Sacred Harp progressions
GOOD_PROGRESSIONS = [
    ['I', 'vi', 'V', 'I'],
    ['I', 'IV', 'V', 'I'],
    ['I', 'vi', 'ii', 'V', 'I'],
    ['i', 'VII', 'III', 'i'],
    ['i', 'iv', 'v', 'i'],
    ['i', 'VII', 'iv', 'i']
]

# Sacred Harp vocal ranges (MIDI note numbers)
# Based on analysis of actual Sacred Harp MusicXML files (12 songs, 3074 notes)
# Includes Sacred Harp, Christian Harmony, and Southern Harmony repertoire
SACRED_HARP_RANGES = {
    'treble': {
        'absolute_low': 63,      # D#4 - absolute minimum found in repertoire
        'absolute_high': 79,     # G5 - absolute maximum found in repertoire
        'percentile_10': 68,     # G#4 - 10th percentile (avoid below this)
        'percentile_90': 76,     # E5 - 90th percentile (avoid above this)
        'sweet_spot_low': 70,    # A#4 - 25th percentile (comfortable low)
        'sweet_spot_high': 74,   # D5 - 75th percentile (comfortable high)
        'average': 72            # C5 - statistical average pitch
    },
    'alto': {
        'absolute_low': 58,      # A#3 - absolute minimum found in repertoire
        'absolute_high': 79,     # G5 - absolute maximum found in repertoire (21 semitone span!)
        'percentile_10': 63,     # D#4 - 10th percentile (avoid below this)
        'percentile_90': 71,     # B4 - 90th percentile (avoid above this)
        'sweet_spot_low': 65,    # F4 - 25th percentile (comfortable low)
        'sweet_spot_high': 69,   # A4 - 75th percentile (comfortable high)
        'average': 67            # G4 - statistical average pitch
    },
    'tenor': {
        'absolute_low': 62,      # D4 - absolute minimum found in repertoire
        'absolute_high': 81,     # A5 - absolute maximum found in repertoire
        'percentile_10': 66,     # F#4 - 10th percentile (avoid below this)
        'percentile_90': 76,     # E5 - 90th percentile (avoid above this)
        'sweet_spot_low': 68,    # G#4 - 25th percentile (comfortable low)
        'sweet_spot_high': 74,   # D5 - 75th percentile (comfortable high)
        'average': 71            # B4 - statistical average pitch
    },
    'bass': {
        'absolute_low': 43,      # G2 - absolute minimum found in repertoire
        'absolute_high': 60,     # C4 - absolute maximum found in repertoire
        'critical_low': 43,      # G2 - NEVER go below this (too low to sing)
        'percentile_10': 47,     # B2 - 10th percentile (avoid below this)
        'percentile_90': 57,     # A3 - 90th percentile (avoid above this)
        'sweet_spot_low': 50,    # D3 - 25th percentile (comfortable low)
        'sweet_spot_high': 55,   # G3 - 75th percentile (comfortable high)
        'average': 52            # E3 - statistical average pitch
    }
}

# Major scale degrees (C major for analysis)
MAJOR_SCALE_DEGREES = {
    0: 1,   # C (do)
    2: 2,   # D (re)
    4: 3,   # E (mi)
    5: 4,   # F (fa)
    7: 5,   # G (sol)
    9: 6,   # A (la)
    11: 7   # B (si)
}

# Solmization note name to semitone mapping (for transpose parsing)
SOLMIZATION_SEMITONES = {
    'do': 0, 'dos': 1, 'dob': 11,
    're': 2, 'res': 3, 'reb': 1,
    'mi': 4, 'mis': 5, 'mib': 3,
    'fa': 5, 'fas': 6, 'fab': 4,
    'sol': 7, 'sols': 8, 'solb': 6,
    'la': 9, 'las': 10, 'lab': 8,
    'si': 11, 'sis': 0, 'sib': 10
}

# Roman numeral mappings for major key
MAJOR_ROMAN_NUMERALS = {
    1: 'I', 2: 'ii', 3: 'iii', 4: 'IV', 5: 'V', 6: 'vi', 7: 'vii°'
}

# Minor key roman numerals (natural minor)
MINOR_ROMAN_NUMERALS = {
    1: 'i', 2: 'ii°', 3: 'III', 4: 'iv', 5: 'v', 6: 'VI', 7: 'VII'
}

class SacredHarpAnalyzer:
    def __init__(self, midi_file, log_file='harmony.log', lilypond_file=None):
        self.midi_file = midi_file
        self.log_file = log_file
        self.lilypond_file = lilypond_file
        self.score = None
        self.key = None
        self.mode = None
        self.key_signature = None
        self.time_signature = None
        self.beats_per_measure = 4
        self.beat_duration = 1.0
        
        # LilyPond source mapping
        self.lilypond_content = None
        self.voice_sections = {}  # Maps voice names to their content and line numbers
        self.section_timings = {'A': 0, 'B': 0}  # Approximate timing of A/B sections
        
        # Transposition tracking
        self.written_key_mode = 'major'  # Mode of written music (major/minor)
        self.transpose_semitones = 0  # Semitones to add to MIDI pitches for analysis
        
        # Load LilyPond source if provided
        if self.lilypond_file:
            self.load_lilypond_source()
        
    def load_lilypond_source(self):
        """Parse LilyPond source file to extract voice sections and locations"""
        if not self.lilypond_file or not os.path.exists(self.lilypond_file):
            return
            
        try:
            with open(self.lilypond_file, 'r', encoding='utf-8') as f:
                self.lilypond_content = f.readlines()
            
            # Parse voice sections: bassA, bassB, trebleA, etc.
            import re
            voice_pattern = r'^(treble|alto|tenor|bass)([AB])\s*=\s*\\relative'
            
            for line_num, line in enumerate(self.lilypond_content, 1):
                match = re.match(voice_pattern, line.strip())
                if match:
                    voice_name = match.group(1).lower()
                    section = match.group(2)
                    
                    # Find the end of this voice section
                    section_content = []
                    brace_count = 0
                    found_opening_brace = False
                    
                    for i in range(line_num - 1, len(self.lilypond_content)):
                        content_line = self.lilypond_content[i]
                        section_content.append(content_line.rstrip())
                        
                        # Count braces to find section end
                        for char in content_line:
                            if char == '{':
                                brace_count += 1
                                found_opening_brace = True
                            elif char == '}':
                                brace_count -= 1
                                if found_opening_brace and brace_count == 0:
                                    # Found end of section
                                    section_key = f"{voice_name}{section}"
                                    self.voice_sections[section_key] = {
                                        'start_line': line_num,
                                        'end_line': i + 1,
                                        'content': section_content,
                                        'voice': voice_name,
                                        'section': section
                                    }
                                    break
                        
                        if found_opening_brace and brace_count == 0:
                            break
            
            # Parse key and transposition directives
            self.parse_key_and_transposition()
            
            # Estimate section timings based on content
            self.estimate_section_timings()
            
        except Exception as e:
            self.log_message(f"WARNING: Could not parse LilyPond file {self.lilypond_file}: {e}")
    
    def parse_key_and_transposition(self):
        """Parse \\key and \\transpose directives from LilyPond source"""
        if not self.lilypond_content:
            return
        
        import re
        
        # Parse key signature: \key NOTE \MODE
        key_pattern = r'\\key\s+([a-z]+[bs]?)\s+\\(major|minor)'
        
        # Parse transposition: \transpose FROM TO {
        transpose_pattern = r'\\transpose\s+([a-z]+[bs]?)\s+([a-z]+[bs]?)\s*\{'
        
        for line in self.lilypond_content:
            # Check for key signature
            key_match = re.search(key_pattern, line)
            if key_match:
                written_key = key_match.group(1)
                self.written_key_mode = key_match.group(2)
                continue
            
            # Check for transposition
            transpose_match = re.search(transpose_pattern, line)
            if transpose_match:
                from_note = transpose_match.group(1)
                to_note = transpose_match.group(2)
                
                # Calculate semitone offset for reverse transposition
                from_semitones = SOLMIZATION_SEMITONES.get(from_note, 0)
                to_semitones = SOLMIZATION_SEMITONES.get(to_note, 0)
                
                # LilyPond transposes FROM → TO
                # \transpose do la: from C (0) to A (9) = +9 = -3 (down 3 semitones)
                lilypond_transpose_raw = to_semitones - from_semitones
                if lilypond_transpose_raw > 6:  # If more than tritone, it's actually down
                    lilypond_transpose = lilypond_transpose_raw - 12
                elif lilypond_transpose_raw < -6:  # If less than -tritone, it's actually up
                    lilypond_transpose = lilypond_transpose_raw + 12
                else:
                    lilypond_transpose = lilypond_transpose_raw
                
                # For analysis, we reverse the transposition
                self.transpose_semitones = -lilypond_transpose
                
                self.log_message(f"Detected transposition: \\transpose {from_note} {to_note} (LilyPond: {lilypond_transpose:+d} semitones, Analysis: {self.transpose_semitones:+d} semitones)")
                break
    
    def estimate_section_timings(self):
        """Estimate when A and B sections occur in the MIDI"""
        # Simple heuristic: A section starts at 0, B section starts after A
        # This could be improved by analyzing the actual music content
        if not self.score:
            return
            
        total_length = self.score.flat.highestTime
        # Assume A section is roughly first half, B section is second half
        self.section_timings['A'] = 0
        self.section_timings['B'] = total_length / 2
    
    def get_lilypond_location(self, voice, offset, measure, beat):
        """Map MIDI timing to LilyPond source location"""
        if not self.voice_sections:
            return None
            
        # Determine section (A or B) based on timing
        section = 'A' if offset < self.section_timings['B'] else 'B'
        section_key = f"{voice}{section}"
        
        if section_key not in self.voice_sections:
            return None
            
        voice_info = self.voice_sections[section_key]
        
        # Estimate line within the section based on measure/beat
        # This is approximate - we don't have precise measure-to-line mapping
        section_progress = 0.0
        if section == 'A':
            section_progress = offset / self.section_timings['B'] if self.section_timings['B'] > 0 else 0
        else:
            section_duration = max(1, self.score.flat.highestTime - self.section_timings['B'])
            section_progress = (offset - self.section_timings['B']) / section_duration
            
        # Estimate line number within the voice section
        content_lines = len(voice_info['content'])
        estimated_line_offset = int(section_progress * max(1, content_lines - 2))  # -2 to avoid last brace
        estimated_line = voice_info['start_line'] + estimated_line_offset + 1  # +1 for content start
        
        return {
            'section_key': section_key,
            'voice': voice,
            'section': section,
            'start_line': voice_info['start_line'],
            'end_line': voice_info['end_line'],
            'estimated_line': min(estimated_line, voice_info['end_line'] - 1),
            'measure': measure,
            'beat': beat,
            'section_progress': section_progress
        }
    
    def get_context_from_lilypond(self, location_info, context_lines=3):
        """Extract context around the problematic location"""
        if not location_info or not self.lilypond_content:
            return None
            
        estimated_line = location_info['estimated_line']
        start_line = max(0, estimated_line - context_lines - 1)  # -1 for 0-based indexing
        end_line = min(len(self.lilypond_content), estimated_line + context_lines)
        
        context = []
        for i in range(start_line, end_line):
            line_content = self.lilypond_content[i].rstrip()
            marker = "→ " if i + 1 == estimated_line else "  "
            context.append(f"{marker}Line {i+1}: {line_content}")
            
        return context
        
    def load_midi(self):
        """Load and parse MIDI file"""
        try:
            self.score = music21.converter.parse(self.midi_file)
            
            # Get key signature - assume C major if not found (LilyPond default with \key do \major)
            try:
                key_sig = self.score.analyze('key')
                self.key = key_sig.tonic.name
                self.mode = key_sig.mode
            except:
                # Default to C major (Sacred Harp solmization system)
                self.key = 'C'
                self.mode = 'major'
                
            self.key_signature = music21.key.Key(self.key, self.mode)
            
            # Get time signature
            try:
                time_sigs = self.score.flat.getElementsByClass(music21.meter.TimeSignature)
                if time_sigs:
                    self.time_signature = time_sigs[0]
                    self.beats_per_measure = self.time_signature.numerator
                    
                    # Handle different time signatures
                    if self.time_signature.denominator == 4:
                        self.beat_duration = 1.0  # Quarter note beat
                    elif self.time_signature.denominator == 2:
                        self.beat_duration = 2.0  # Half note beat
                    elif self.time_signature.denominator == 8:
                        # Compound time - group by dotted quarter
                        if self.beats_per_measure in [6, 9, 12]:
                            self.beats_per_measure = self.beats_per_measure // 3
                            self.beat_duration = 1.5  # Dotted quarter beat
                        else:
                            self.beat_duration = 0.5  # Eighth note beat
                    else:
                        self.beat_duration = 4.0 / self.time_signature.denominator
                else:
                    # Default to 4/4
                    self.time_signature = music21.meter.TimeSignature('4/4')
                    self.beats_per_measure = 4
                    self.beat_duration = 1.0
            except:
                # Default to 4/4 if time signature detection fails
                self.time_signature = music21.meter.TimeSignature('4/4')
                self.beats_per_measure = 4
                self.beat_duration = 1.0
            
            # Update section timings now that we have the score
            if self.voice_sections:
                self.estimate_section_timings()
            
            return True
        except Exception as e:
            self.log_message(f"ERROR: Could not load MIDI file: {e}")
            return False
    
    def get_chord_at_offset(self, offset):
        """Extract all simultaneous pitches at given offset and identify chord"""
        notes_at_time = []
        
        # Get all parts (voices)
        parts = self.score.parts if self.score.parts else [self.score]
        
        for part in parts:
            # Find notes/chords at this exact offset
            elements = part.flat.getElementsByOffset(offset, offset + 0.5, 
                                                   includeElementsThatEndAtStart=False,
                                                   mustFinishInSpan=False,
                                                   mustBeginInSpan=False)
            
            for element in elements:
                if hasattr(element, 'pitch'):  # Single note
                    notes_at_time.append(element.pitch)
                elif hasattr(element, 'pitches'):  # Chord
                    notes_at_time.extend(element.pitches)
        
        if not notes_at_time:
            return None, []
            
        return self.identify_sacred_harp_chord(notes_at_time)
    
    def identify_sacred_harp_chord(self, pitches):
        """Identify chord from list of pitches, handling Sacred Harp conventions"""
        if not pitches:
            return None, []
        
        # Convert to pitch classes (remove octave information)
        pitch_classes = [p.pitchClass for p in pitches]
        unique_pitch_classes = sorted(list(set(pitch_classes)))
        
        # Handle octave doubling (common in Sacred Harp bass)
        pitch_class_counts = Counter(pitch_classes)
        
        # Get scale degrees for analysis
        scale_degrees = []
        for pc in unique_pitch_classes:
            # Transpose to C major for analysis (Sacred Harp solmization system)
            transposed_pc = (pc - self.key_signature.tonic.pitchClass) % 12
            if transposed_pc in MAJOR_SCALE_DEGREES:
                scale_degrees.append(MAJOR_SCALE_DEGREES[transposed_pc])
        
        scale_degrees = sorted(list(set(scale_degrees)))
        
        if not scale_degrees:
            return "Unknown", unique_pitch_classes
        
        # Identify chord based on scale degrees
        chord_root, roman_numeral = self.determine_chord_root_and_roman(scale_degrees)
        
        return roman_numeral, scale_degrees
    
    def determine_chord_root_and_roman(self, scale_degrees):
        """Determine chord root and Roman numeral from scale degrees"""
        if not scale_degrees:
            return None, "Unknown"
        
        # Check for common Sacred Harp chord patterns
        scale_set = set(scale_degrees)
        
        # Perfect matches first
        if scale_set == {1, 3, 5}:  # do mi sol
            return 1, 'I'
        elif scale_set == {6, 1, 3}:  # la do mi  
            return 6, 'vi'
        elif scale_set == {5, 7, 2}:  # sol si re
            return 5, 'V'
        elif scale_set == {4, 6, 1}:  # fa la do
            return 4, 'IV'
        elif scale_set == {2, 4, 6}:  # re fa la
            return 2, 'ii'
        elif scale_set == {3, 5, 7}:  # mi sol si
            return 3, 'iii'
        elif scale_set == {7, 2, 4}:  # si re fa
            return 7, 'vii°'
        
        # Handle incomplete chords (dyads - common in Sacred Harp)
        elif scale_set == {1, 5}:  # do sol (I chord without third)
            return 1, 'I'
        elif scale_set == {1, 3}:  # do mi (I chord without fifth)  
            return 1, 'I'
        elif scale_set == {6, 3}:  # la mi (vi chord incomplete)
            return 6, 'vi'
        elif scale_set == {5, 7}:  # sol si (V chord without third)
            return 5, 'V'
        elif scale_set == {5, 2}:  # sol re (V chord without third)
            return 5, 'V'
        
        # Single notes - assume root of chord
        elif len(scale_degrees) == 1:
            degree = scale_degrees[0]
            if self.mode == 'major':
                return degree, MAJOR_ROMAN_NUMERALS.get(degree, f"?{degree}")
            else:
                return degree, MINOR_ROMAN_NUMERALS.get(degree, f"?{degree}")
        
        # Complex chords - try to find root by lowest note
        else:
            root_degree = min(scale_degrees)
            if self.mode == 'major':
                return root_degree, MAJOR_ROMAN_NUMERALS.get(root_degree, f"?{root_degree}")
            else:
                return root_degree, MINOR_ROMAN_NUMERALS.get(root_degree, f"?{root_degree}")
    
    def analyze_chords(self):
        """Analyze chord progressions throughout the piece"""
        if not self.score:
            return []
        
        chord_analysis = []
        
        # Get total length of piece
        total_length = self.score.flat.highestTime
        
        # Analyze every beat based on detected time signature
        current_offset = 0.0
        measure_num = 1
        beat_num = 1
        
        while current_offset < total_length:
            roman_numeral, scale_degrees = self.get_chord_at_offset(current_offset)
            
            if roman_numeral:
                assessment = self.assess_chord(roman_numeral)
                
                chord_analysis.append({
                    'offset': current_offset,
                    'measure': measure_num,
                    'beat': beat_num,
                    'roman': roman_numeral,
                    'scale_degrees': scale_degrees,
                    'assessment': assessment
                })
            
            # Advance to next beat using detected beat duration
            current_offset += self.beat_duration
            beat_num += 1
            
            # New measure based on detected beats per measure
            if beat_num > self.beats_per_measure:
                beat_num = 1
                measure_num += 1
        
        return chord_analysis
    
    def assess_chord(self, roman_numeral):
        """Assess chord against Sacred Harp rules"""
        rules = SACRED_HARP_RULES.get(self.mode, SACRED_HARP_RULES['major'])
        
        if roman_numeral in rules['forbidden']:
            return {'status': 'FORBIDDEN', 'message': f'{roman_numeral} chord FORBIDDEN in Sacred Harp style'}
        elif roman_numeral in rules['common']:
            return {'status': 'GOOD', 'message': f'{roman_numeral} chord - excellent choice for Sacred Harp'}
        elif roman_numeral in rules['quite_common']:
            return {'status': 'OK', 'message': f'{roman_numeral} chord - good Sacred Harp choice'}
        elif roman_numeral in rules['rare']:
            return {'status': 'WARNING', 'message': f'{roman_numeral} chord - use sparingly in Sacred Harp'}
        else:
            return {'status': 'UNKNOWN', 'message': f'{roman_numeral} chord - check Sacred Harp style guide'}
    
    def get_voice_pitches_at_offset(self, offset):
        """Extract pitches by voice at given offset"""
        voice_pitches = {'treble': None, 'alto': None, 'tenor': None, 'bass': None}
        
        parts = self.score.parts if self.score.parts else [self.score]
        
        for i, part in enumerate(parts):
            elements = part.flat.getElementsByOffset(offset, offset + 0.5, 
                                                   includeElementsThatEndAtStart=False,
                                                   mustFinishInSpan=False,
                                                   mustBeginInSpan=False)
            
            for element in elements:
                if hasattr(element, 'pitch'):  # Single note
                    pitch = element.pitch
                elif hasattr(element, 'pitches') and element.pitches:  # Chord
                    pitch = element.pitches[0]  # Take first pitch
                else:
                    continue
                    
                # Map part index to voice name (assuming SATB order)
                if i == 0:
                    voice_pitches['treble'] = pitch
                elif i == 1:
                    voice_pitches['alto'] = pitch
                elif i == 2:
                    voice_pitches['tenor'] = pitch
                elif i == 3:
                    voice_pitches['bass'] = pitch
        
        return voice_pitches
    
    def check_voice_leading_issues(self, chord_analysis):
        """Check for specific Sacred Harp voice leading issues"""
        warnings = []
        
        for i, analysis in enumerate(chord_analysis):
            measure = analysis['measure']
            beat = analysis['beat']
            offset = analysis['offset']
            scale_degrees = set(analysis['scale_degrees'])
            
            # Check for adjacent scale degrees (dissonance)
            if {1, 2}.issubset(scale_degrees):  # do-re
                warning = f"Bar {measure}, Beat {beat}: Adjacent scale degrees do-re create dissonance"
                warning += f"\n→ Fix suggestion: Brief passing dissonance is acceptable, but avoid sustaining both notes"
                warnings.append(warning)
            if {3, 4}.issubset(scale_degrees):  # mi-fa  
                warning = f"Bar {measure}, Beat {beat}: Adjacent scale degrees mi-fa create dissonance"
                warning += f"\n→ Fix suggestion: Common at cadences, but avoid prolonged mi-fa combinations"
                warnings.append(warning)
            if {7, 1}.issubset(scale_degrees):  # si-do
                warning = f"Bar {measure}, Beat {beat}: Adjacent scale degrees si-do create dissonance"
                warning += f"\n→ Fix suggestion: Natural at cadences (si resolves to do), acceptable when brief"
                warnings.append(warning)
            
            # Check voice crossings
            voice_pitches = self.get_voice_pitches_at_offset(offset)
            
            if voice_pitches['bass'] and voice_pitches['tenor']:
                if voice_pitches['bass'].midi > voice_pitches['tenor'].midi:
                    warnings.append(f"Bar {measure}, Beat {beat}: Bass crosses above tenor (acceptable when tenor is low)")
            
            # Don't log good voice crossings
            # if voice_pitches['treble'] and voice_pitches['tenor']:
            #     if voice_pitches['treble'].midi < voice_pitches['tenor'].midi:
            #         warnings.append(f"Bar {measure}, Beat {beat}: Treble crosses below tenor (good contrary motion)")
            
        
        # Check for critical and extreme range violations (immediate warnings)
        critical_warnings = self.check_critical_ranges(chord_analysis)
        warnings.extend(critical_warnings)
        
        # Check for vocal fatigue from sustained extreme range singing
        fatigue_warnings = self.check_vocal_fatigue(chord_analysis)
        warnings.extend(fatigue_warnings)
        
        # Check treble-tenor contrary motion over time
        contrary_motion_warnings = self.check_contrary_motion(chord_analysis)
        warnings.extend(contrary_motion_warnings)
        
        return warnings
    
    def check_critical_ranges(self, chord_analysis):
        """Check for critical and extreme range violations (immediate warnings)"""
        warnings = []
        
        for analysis in chord_analysis:
            measure = analysis['measure']
            beat = analysis['beat']
            offset = analysis['offset']
            voice_pitches = self.get_voice_pitches_at_offset(offset)
            
            for voice, pitch in voice_pitches.items():
                if not pitch or voice not in SACRED_HARP_RANGES:
                    continue
                    
                ranges = SACRED_HARP_RANGES[voice]
                midi_note = pitch.midi
                
                # Apply reverse transposition for analysis (convert sounding pitch to written pitch)
                analysis_midi = midi_note + self.transpose_semitones
                
                # Get LilyPond location if available
                location_info = self.get_lilypond_location(voice, offset, measure, beat)
                
                # Critical range violations (NEVER do this) - only for bass
                if voice == 'bass' and analysis_midi <= ranges['critical_low']:
                    warning = f"Bar {measure}, Beat {beat}: CRITICAL: {voice.title()} note {pitch.name}{pitch.octave} (MIDI {midi_note}, Analysis: {analysis_midi}) is too low to sing! Never go below G2."
                    
                    if location_info:
                        warning += f"\n→ Location: {location_info['section_key']} section, approximately line {location_info['estimated_line']} in {self.lilypond_file}"
                        context = self.get_context_from_lilypond(location_info)
                        if context:
                            warning += f"\n→ Context:\n" + "\n".join(context)
                        warning += f"\n→ Fix suggestion: Change note to higher octave or transpose passage up"
                    
                    warnings.append(warning)
                    continue
                
                # Outside absolute range found in repertoire (very rare)
                if analysis_midi < ranges['absolute_low']:
                    warning = f"Bar {measure}, Beat {beat}: EXTREME: {voice.title()} note {pitch.name}{pitch.octave} (MIDI {midi_note}, Analysis: {analysis_midi}) is below any note found in Sacred Harp repertoire."
                    
                    if location_info:
                        warning += f"\n→ Location: {location_info['section_key']} section, approximately line {location_info['estimated_line']} in {self.lilypond_file}"
                        context = self.get_context_from_lilypond(location_info)
                        if context:
                            warning += f"\n→ Context:\n" + "\n".join(context)
                        warning += f"\n→ Fix suggestion: Raise note by octave or reconsider voice assignment"
                    
                    warnings.append(warning)
                elif analysis_midi > ranges['absolute_high']:
                    warning = f"Bar {measure}, Beat {beat}: EXTREME: {voice.title()} note {pitch.name}{pitch.octave} (MIDI {midi_note}, Analysis: {analysis_midi}) is above any note found in Sacred Harp repertoire."
                    
                    if location_info:
                        warning += f"\n→ Location: {location_info['section_key']} section, approximately line {location_info['estimated_line']} in {self.lilypond_file}"
                        context = self.get_context_from_lilypond(location_info)
                        if context:
                            warning += f"\n→ Context:\n" + "\n".join(context)
                        warning += f"\n→ Fix suggestion: Lower note by octave or transpose passage down"
                    
                    warnings.append(warning)
        
        return warnings
    
    def check_vocal_fatigue(self, chord_analysis):
        """Check for vocal fatigue from sustained extreme range singing"""
        warnings = []
        
        if len(chord_analysis) < 3:  # Need at least 3 beats to check fatigue
            return warnings
        
        # Track pitch history for each voice
        voice_history = {'treble': [], 'alto': [], 'tenor': [], 'bass': []}
        
        # Build pitch history for each voice
        for analysis in chord_analysis:
            offset = analysis['offset']
            measure = analysis['measure']
            beat = analysis['beat']
            voice_pitches = self.get_voice_pitches_at_offset(offset)
            
            for voice in voice_history.keys():
                if voice_pitches[voice]:
                    midi_note = voice_pitches[voice].midi
                    analysis_midi = midi_note + self.transpose_semitones
                    voice_history[voice].append({
                        'midi': midi_note,
                        'analysis_midi': analysis_midi,
                        'measure': measure,
                        'beat': beat,
                        'pitch': voice_pitches[voice]
                    })
                else:
                    voice_history[voice].append(None)
        
        # Check for fatigue in each voice using sliding window
        window_size = 8  # 8 beats (2 measures in 4/4)
        
        for voice, history in voice_history.items():
            if voice not in SACRED_HARP_RANGES:
                continue
                
            ranges = SACRED_HARP_RANGES[voice]
            reported_ranges = set()  # Track reported ranges to avoid duplicates
            
            # Sliding window analysis
            for i in range(len(history) - window_size + 1):
                window = history[i:i + window_size]
                
                # Count extreme notes in this window
                extreme_high = 0
                extreme_low = 0
                consecutive_high = 0
                consecutive_low = 0
                max_consecutive_high = 0
                max_consecutive_low = 0
                
                for note_data in window:
                    if note_data is None:
                        consecutive_high = 0
                        consecutive_low = 0
                        continue
                        
                    analysis_midi = note_data['analysis_midi']
                    
                    # Count extreme notes using transposed pitch for analysis
                    if analysis_midi > ranges['percentile_90']:
                        extreme_high += 1
                        consecutive_high += 1
                        consecutive_low = 0
                        max_consecutive_high = max(max_consecutive_high, consecutive_high)
                    elif analysis_midi < ranges['percentile_10']:
                        extreme_low += 1
                        consecutive_low += 1
                        consecutive_high = 0
                        max_consecutive_low = max(max_consecutive_low, consecutive_low)
                    else:
                        consecutive_high = 0
                        consecutive_low = 0
                
                # Generate fatigue warnings (only if not already reported for this range)
                start_measure = window[0]['measure'] if window[0] else i // self.beats_per_measure + 1
                end_measure = window[-1]['measure'] if window[-1] else (i + window_size - 1) // self.beats_per_measure + 1
                range_key = (voice, start_measure, end_measure)
                
                # Only report the most severe warning for each range
                if range_key not in reported_ranges:
                    # Warn about sustained high singing
                    if extreme_high >= 6:  # 6+ high notes is most severe
                        warnings.append(f"SUSTAINED FATIGUE: {voice.title()} spends {extreme_high} of {window_size} beats in top 10% range (bars {start_measure}-{end_measure}) - may tire singers")
                        reported_ranges.add(range_key)
                    elif extreme_high >= 5:  # 5 high notes is moderate
                        warnings.append(f"SUSTAINED FATIGUE: {voice.title()} spends {extreme_high} of {window_size} beats in top 10% range (bars {start_measure}-{end_measure}) - may tire singers")
                        reported_ranges.add(range_key)
                    elif max_consecutive_high >= 4:  # 4+ consecutive high notes
                        warnings.append(f"FATIGUE WARNING: {voice.title()} has {max_consecutive_high} consecutive high notes (bars {start_measure}-{end_measure}) - may strain singers")
                        reported_ranges.add(range_key)
                    
                    # Warn about sustained low singing (only if no high warning)
                    elif extreme_low >= 6:  # 6+ low notes is most severe
                        warnings.append(f"SUSTAINED FATIGUE: {voice.title()} spends {extreme_low} of {window_size} beats in bottom 10% range (bars {start_measure}-{end_measure}) - may tire singers")
                        reported_ranges.add(range_key)
                    elif extreme_low >= 5:  # 5 low notes is moderate
                        warnings.append(f"SUSTAINED FATIGUE: {voice.title()} spends {extreme_low} of {window_size} beats in bottom 10% range (bars {start_measure}-{end_measure}) - may tire singers")
                        reported_ranges.add(range_key)
                    elif max_consecutive_low >= 4:  # 4+ consecutive low notes
                        warnings.append(f"FATIGUE WARNING: {voice.title()} has {max_consecutive_low} consecutive low notes (bars {start_measure}-{end_measure}) - may strain singers")
                        reported_ranges.add(range_key)
        
        return warnings
    
    def check_contrary_motion(self, chord_analysis):
        """Check for proper contrary motion between treble and tenor"""
        warnings = []
        
        if len(chord_analysis) < 2:
            return warnings
        
        parallel_motion_count = 0
        total_motion_count = 0
        
        for i in range(1, len(chord_analysis)):
            current = chord_analysis[i]
            previous = chord_analysis[i-1]
            
            current_voices = self.get_voice_pitches_at_offset(current['offset'])
            previous_voices = self.get_voice_pitches_at_offset(previous['offset'])
            
            if (current_voices['treble'] and current_voices['tenor'] and 
                previous_voices['treble'] and previous_voices['tenor']):
                
                treble_motion = current_voices['treble'].midi - previous_voices['treble'].midi
                tenor_motion = current_voices['tenor'].midi - previous_voices['tenor'].midi
                
                if abs(treble_motion) > 0 and abs(tenor_motion) > 0:  # Both voices moved
                    total_motion_count += 1
                    
                    # Check if motion is in same direction (parallel)
                    if (treble_motion > 0 and tenor_motion > 0) or (treble_motion < 0 and tenor_motion < 0):
                        parallel_motion_count += 1
        
        # Warn if too much parallel motion
        if total_motion_count > 0:
            parallel_ratio = parallel_motion_count / total_motion_count
            if parallel_ratio > 0.6:  # More than 60% parallel motion
                warnings.append(f"WARNING: Treble and tenor move in parallel motion {parallel_ratio:.1%} of the time. Sacred Harp prefers contrary motion.")
        
        return warnings
    
    def log_message(self, message):
        """Write message to log file with timestamp"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(self.log_file, 'a') as f:
            f.write(f"{timestamp}: {message}\n")
    
    def run_analysis(self):
        """Run complete harmonic analysis"""
        self.log_message("=== SACRED HARP HARMONIC ANALYSIS START ===")
        
        if not self.load_midi():
            return False
        
        time_sig_str = f"{self.time_signature.numerator}/{self.time_signature.denominator}" if self.time_signature else "4/4"
        self.log_message(f"Analyzing {self.midi_file} in {self.key} {self.mode}, {time_sig_str} time")
        
        chord_analysis = self.analyze_chords()
        
        if not chord_analysis:
            self.log_message("No chords detected in analysis")
            return False
        
        # Log chord-by-chord analysis (only problems)
        for analysis in chord_analysis:
            measure = analysis['measure']
            beat = analysis['beat']
            offset = analysis['offset']
            roman = analysis['roman']
            degrees = analysis['scale_degrees']
            assessment = analysis['assessment']
            
            status = assessment['status']
            message = assessment['message']
            
            # Only log problematic chords
            if status in ['FORBIDDEN', 'WARNING', 'UNKNOWN']:
                degrees_str = '-'.join(map(str, degrees))
                log_entry = f"Bar {measure}, Beat {beat}: {roman} ({degrees_str}) - {status}: {message}"
                
                # Add fix suggestions for forbidden chords
                if status == 'FORBIDDEN':
                    if roman == 'vii°':
                        log_entry += f"\n→ Fix suggestion: Replace with V chord (sol-si-re) or vi chord (la-do-mi)"
                    elif roman == 'ii°':
                        log_entry += f"\n→ Fix suggestion: Replace with iv chord (fa-la-do) or ii chord (re-fa-la)"
                    elif roman == 'VI' and self.mode == 'minor':
                        log_entry += f"\n→ Fix suggestion: Use III chord (do-mi-sol) or iv chord (fa-la-do) instead"
                
                self.log_message(log_entry)
        
        # Check for voice leading issues
        voice_warnings = self.check_voice_leading_issues(chord_analysis)
        for warning in voice_warnings:
            self.log_message(f"VOICE LEADING WARNING: {warning}")
        
        # Analyze chord progression
        progression = [a['roman'] for a in chord_analysis if a['roman'] != 'Unknown']
        if len(progression) > 1:
            self.analyze_progression(progression)
        
        self.log_message("=== SACRED HARP HARMONIC ANALYSIS END ===")
        return True
    
    def analyze_progression(self, progression):
        """Analyze the overall chord progression"""
        self.log_message(f"PROGRESSION: {' - '.join(progression)}")
        
        # Check against known good progressions
        prog_str = ' - '.join(progression)
        for good_prog in GOOD_PROGRESSIONS:
            if ' - '.join(good_prog) in prog_str:
                self.log_message(f"GOOD: Contains standard Sacred Harp progression: {' - '.join(good_prog)}")
        
        # Check for forbidden chord sequences
        for i, chord in enumerate(progression[:-1]):
            next_chord = progression[i + 1]
            if chord == 'vii°':
                self.log_message(f"ERROR: Forbidden vii° chord found in progression")
            if chord == 'ii°' and self.mode == 'minor':
                self.log_message(f"ERROR: Forbidden ii° chord found in minor key")

def watch_midi_file(midi_file, log_file='harmony.log', lilypond_file=None):
    """Watch MIDI file for changes and analyze"""
    import time
    
    last_modified = 0
    analyzer = SacredHarpAnalyzer(midi_file, log_file, lilypond_file)
    
    print(f"Watching {midi_file} for changes...")
    print(f"Harmony feedback will be logged to {log_file}")
    if lilypond_file:
        print(f"LilyPond source locations from {lilypond_file}")
    
    while True:
        try:
            if os.path.exists(midi_file):
                modified = os.path.getmtime(midi_file)
                if modified > last_modified:
                    print(f"MIDI file updated, analyzing...")
                    analyzer.run_analysis()
                    last_modified = modified
            time.sleep(2)  # Check every 2 seconds
        except KeyboardInterrupt:
            print("Stopping watcher...")
            break

def main():
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python sacred_harp_analyzer.py file.midi [output.log] [lilypond_file.ly]")
        print("  python sacred_harp_analyzer.py --watch file.midi [output.log] [lilypond_file.ly]")
        print("\nOptional LilyPond file enables precise source location reporting.")
        sys.exit(1)
    
    if sys.argv[1] == '--watch':
        midi_file = sys.argv[2] if len(sys.argv) > 2 else 'christian_harmony_song.midi'
        log_file = sys.argv[3] if len(sys.argv) > 3 else 'harmony.log'
        lilypond_file = sys.argv[4] if len(sys.argv) > 4 else None
        watch_midi_file(midi_file, log_file, lilypond_file)
    else:
        midi_file = sys.argv[1]
        log_file = sys.argv[2] if len(sys.argv) > 2 else 'harmony.log'
        lilypond_file = sys.argv[3] if len(sys.argv) > 3 else None
        
        analyzer = SacredHarpAnalyzer(midi_file, log_file, lilypond_file)
        if analyzer.run_analysis():
            print(f"Analysis complete. Check {log_file} for results.")
            if lilypond_file:
                print(f"Source locations from {lilypond_file} included in analysis.")
        else:
            print("Analysis failed.")

if __name__ == "__main__":
    main()