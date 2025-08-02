#!/usr/bin/env python3
"""
Analyze Sacred Harp MusicXML files to extract actual vocal ranges
"""

import xml.etree.ElementTree as ET
from collections import defaultdict
import sys

def note_to_midi(step, octave, alter=0):
    """Convert step, octave, alter to MIDI note number"""
    note_values = {'C': 0, 'D': 2, 'E': 4, 'F': 5, 'G': 7, 'A': 9, 'B': 11}
    return (octave + 1) * 12 + note_values[step] + alter

def midi_to_note_name(midi):
    """Convert MIDI number to note name with octave"""
    notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    octave = (midi // 12) - 1
    note = notes[midi % 12]
    return f"{note}{octave}"

def analyze_musicxml_ranges(xml_file):
    """Analyze vocal ranges from MusicXML file"""
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        # Extract title
        title_elem = root.find('.//work-title')
        title = title_elem.text if title_elem is not None else "Unknown"
        
        # Get part names and their pitch ranges
        voice_ranges = defaultdict(list)
        
        # Find all parts
        parts = root.findall('.//score-part')
        part_names = {}
        for part in parts:
            part_id = part.get('id')
            name_elem = part.find('part-name')
            if name_elem is not None:
                part_names[part_id] = name_elem.text.lower()
        
        # Analyze pitches in each part
        for part in root.findall('.//part'):
            part_id = part.get('id')
            voice_name = part_names.get(part_id, f"part_{part_id}")
            
            # Find all pitches in this part
            for pitch_elem in part.findall('.//pitch'):
                step_elem = pitch_elem.find('step')
                octave_elem = pitch_elem.find('octave')
                alter_elem = pitch_elem.find('alter')
                
                if step_elem is not None and octave_elem is not None:
                    step = step_elem.text
                    octave = int(octave_elem.text)
                    alter = int(alter_elem.text) if alter_elem is not None else 0
                    
                    midi_note = note_to_midi(step, octave, alter)
                    voice_ranges[voice_name].append(midi_note)
        
        return title, voice_ranges
        
    except Exception as e:
        print(f"Error analyzing {xml_file}: {e}")
        return None, {}

def download_and_analyze_files(urls):
    """Download and analyze multiple MusicXML files"""
    import urllib.request
    import zipfile
    import os
    
    all_ranges = defaultdict(list)
    song_data = []
    
    for i, url in enumerate(urls):
        try:
            # Download file
            filename = f"song_{i+1}.mxl"
            urllib.request.urlretrieve(url, filename)
            
            # Extract if it's a zip
            if zipfile.is_zipfile(filename):
                with zipfile.ZipFile(filename, 'r') as zip_ref:
                    # Find the main XML file
                    xml_files = [f for f in zip_ref.namelist() if f.endswith('.xml') and not f.startswith('META-INF')]
                    if xml_files:
                        zip_ref.extract(xml_files[0])
                        xml_filename = xml_files[0]
                    else:
                        continue
            else:
                xml_filename = filename
            
            # Analyze the XML file
            title, voice_ranges = analyze_musicxml_ranges(xml_filename)
            
            if voice_ranges:
                song_info = {'title': title, 'ranges': {}}
                
                for voice, pitches in voice_ranges.items():
                    if pitches:
                        min_pitch = min(pitches)
                        max_pitch = max(pitches)
                        all_ranges[voice].extend(pitches)
                        
                        song_info['ranges'][voice] = {
                            'min_midi': min_pitch,
                            'max_midi': max_pitch,
                            'min_note': midi_to_note_name(min_pitch),
                            'max_note': midi_to_note_name(max_pitch),
                            'range_semitones': max_pitch - min_pitch
                        }
                
                song_data.append(song_info)
                print(f"✓ Analyzed: {title}")
            
            # Cleanup
            if os.path.exists(xml_filename):
                os.remove(xml_filename)
            if os.path.exists(filename):
                os.remove(filename)
                
        except Exception as e:
            print(f"Error with {url}: {e}")
            continue
    
    return all_ranges, song_data

if __name__ == "__main__":
    # Sacred Harp URLs from user
    urls = [
        "https://shapenote.net/musicxml/33b.mxl",
        "https://shapenote.net/musicxml/45t.mxl", 
        "https://shapenote.net/musicxml/99.mxl",
        "https://shapenote.net/musicxml/197d.mxl",
        "https://shapenote.net/musicxml/229.mxl",
        "https://shapenote.net/musicxml/528.mxl",
        "https://shapenote.net/musicxml/CHN-121t.mxl",
        "https://shapenote.net/musicxml/CHA-172.mxl",
        "https://shapenote.net/musicxml/309.mxl",
        "https://shapenote.net/musicxml/C-196d.mxl",
        "https://shapenote.net/musicxml/SH-254.mxl",
        "https://shapenote.net/musicxml/CHA-110.mxl"
    ]
    
    print("Analyzing Sacred Harp vocal ranges from MusicXML files...")
    all_ranges, song_data = download_and_analyze_files(urls)
    
    # Print individual song analysis
    print("\n" + "="*60)
    print("INDIVIDUAL SONG ANALYSIS")
    print("="*60)
    
    for song in song_data:
        print(f"\n{song['title']}")
        print("-" * len(song['title']))
        for voice, data in song['ranges'].items():
            print(f"{voice.upper():>8}: {data['min_note']:>4} to {data['max_note']:<4} (MIDI {data['min_midi']:>2}-{data['max_midi']:<2}, range: {data['range_semitones']} semitones)")
    
    # Print overall statistics
    print("\n" + "="*60)
    print("OVERALL SACRED HARP VOCAL RANGES")
    print("="*60)
    
    for voice, pitches in all_ranges.items():
        if pitches:
            min_pitch = min(pitches)
            max_pitch = max(pitches)
            avg_pitch = sum(pitches) / len(pitches)
            
            print(f"\n{voice.upper()} ({len(pitches)} notes analyzed):")
            print(f"  Absolute range: {midi_to_note_name(min_pitch)} to {midi_to_note_name(max_pitch)} (MIDI {min_pitch}-{max_pitch})")
            print(f"  Range span: {max_pitch - min_pitch} semitones")
            print(f"  Average pitch: {midi_to_note_name(round(avg_pitch))} (MIDI {avg_pitch:.1f})")
            
            # Calculate percentiles for comfort zones
            sorted_pitches = sorted(pitches)
            p10 = sorted_pitches[int(0.1 * len(sorted_pitches))]
            p90 = sorted_pitches[int(0.9 * len(sorted_pitches))]
            p25 = sorted_pitches[int(0.25 * len(sorted_pitches))]
            p75 = sorted_pitches[int(0.75 * len(sorted_pitches))]
            
            print(f"  10th-90th percentile: {midi_to_note_name(p10)} to {midi_to_note_name(p90)} (MIDI {p10}-{p90})")
            print(f"  25th-75th percentile: {midi_to_note_name(p25)} to {midi_to_note_name(p75)} (MIDI {p25}-{p75})")