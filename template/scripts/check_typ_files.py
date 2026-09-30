#!/usr/bin/env python3
import re
import argparse
from pathlib import Path

script_dir = Path(__file__).resolve().parent
project_dir = script_dir.parent
content_dir = (project_dir / 'content') if (project_dir / 'content').exists() else (project_dir / 'template' / 'content')
regex_file = script_dir / 'regexesthatshouldntexis.txt'

def check_typ_files(custom_pattern=None):
    compiled_regexes = []
    report_title = ""
    output_log_file = None

    # --- MODE SELECTION ---
    if custom_pattern:
        # Mode 1: Single custom regex search
        try:
            compiled_regexes.append((custom_pattern, re.compile(custom_pattern)))
        except re.error as e:
            print(f"Error compiling regex '{custom_pattern}': {e}")
            return
        
        report_title = f"--- TYPST CUSTOM SEARCH REPORT ---\nSearched Regex: {custom_pattern}\n"
        output_log_file = script_dir / 'custom_search_report.txt'
        print(f"Running custom search for: {custom_pattern}...")
    
    else:
        # Mode 2: Bulk glossary check
        if not regex_file.exists():
            print(f"Error: Default regex file not found at {regex_file}")
            print("Tip: Run generate_regexes.py first to generate regex patterns from glossary.yaml.")
            return
            
        with open(regex_file, 'r', encoding='utf-8') as f:
            patterns = [line.strip() for line in f if line.strip()]
            
        compiled_regexes = [(p, re.compile(p)) for p in patterns]
        report_title = "--- TYPST GLOSSARY/ACRONYM BULK CHECK REPORT ---\n"
        output_log_file = script_dir / 'unreferenced_terms_report.txt'
        print(f"Running bulk check against {len(compiled_regexes)} glossary patterns in {content_dir}...")

    # --- REGEX SETUP FOR TYPST FILTERING ---
    # 1. Strips refs with brackets, allowing multiple modifiers: @label:mod1:mod2[text]
    typst_ref_pattern = re.compile(r'[@#][a-zA-Z0-9_-]+(?::[a-zA-Z0-9_-]+)*(?:\([^)]*\))?\[.*?\]')
    
    # 2. Strips standalone functions with parentheses: #cite("...", chapter:1)
    typst_func_pattern = re.compile(r'#[a-zA-Z0-9_-]+\([^)]*\)')
    
    # 3. Strips inline math blocks: $ "PDF" = x $ (ignores escaped \$)
    typst_math_pattern = re.compile(r'(?<!\\)\$.*?(?<!\\)\$')
    
    # 4. Strips Typst labels: <my_custom_label>
    typst_label_pattern = re.compile(r'<[^>]+>')

    # --- FILE PARSING ---
    typ_files = sorted(content_dir.rglob('*.typ'))
    match_count = 0

    with open(output_log_file, 'w', encoding='utf-8') as out_f:
        out_f.write(report_title + "\n")
        
        for file_path in typ_files:
            rel_path = file_path.relative_to(project_dir) if file_path.is_relative_to(project_dir) else file_path
            with open(file_path, 'r', encoding='utf-8') as f:
                for line_num, line in enumerate(f, 1):
                    
                    stripped_line = line.strip()
                    
                    # 1. Ignore commented lines
                    if stripped_line.startswith('//'):
                        continue
                        
                    # 2. Ignore Typst headings (=, ==, ===, etc.)
                    if re.match(r'^=+\s+', stripped_line):
                        continue
                    
                    # Preprocess the line: remove references, citations, math blocks, and labels
                    clean_line = typst_ref_pattern.sub('', line)
                    clean_line = typst_func_pattern.sub('', clean_line)
                    clean_line = typst_math_pattern.sub('', clean_line)
                    clean_line = typst_label_pattern.sub('', clean_line)
                    
                    # Check the cleaned line against loaded regex(es)
                    for pattern_str, regex in compiled_regexes:
                        if regex.search(clean_line):
                            print(f"File  : {rel_path}:{line_num}", file=out_f)
                            print(f"Regex : {pattern_str}", file=out_f)
                            print(f"Line  : {line.strip()}", file=out_f)
                            print("-" * 60, file=out_f)
                            match_count += 1

        # Write the final summary to the file
        if match_count == 0:
            if custom_pattern:
                print(f"\nAll clear! No matches found for: {custom_pattern}", file=out_f)
            else:
                print("\nAll clear! No unreferenced glossary/acronym terms found.", file=out_f)
        else:
            print(f"\nTotal matches found: {match_count}", file=out_f)

    # --- TERMINAL OUTPUT ---
    if match_count == 0:
        print(f"All clear! 0 unreferenced occurrences found. Report saved to: {output_log_file.name}")
    else:
        print(f"Found {match_count} unreferenced matches. Read the full report here: {output_log_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Search Typst files while ignoring references, citations, math blocks, and labels.")
    parser.add_argument("regex", nargs='?', help="Optional: A specific regular expression to search for. If omitted, checks all terms in regexesthatshouldntexis.txt.")
    
    args = parser.parse_args()
    check_typ_files(args.regex)
