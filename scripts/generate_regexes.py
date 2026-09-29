#!/usr/bin/env python3
import yaml
import re
script_dir = Path(__file__).resolve().parent
repo_dir = script_dir.parent
yaml_file = (repo_dir / 'template' / 'helperfiles' / 'glossary.yaml') if (repo_dir / 'template' / 'helperfiles' / 'glossary.yaml').exists() else (repo_dir / 'helperfiles' / 'glossary.yaml')
output_file = script_dir / 'regexesthatshouldntexis.txt'

# --- HARDWIRED IGNORE LIST (ALLOWED IN TEXT) ---
# Add any terms here (in lowercase) that you want the script to completely ignore.
IGNORE_LIST = {
    'availability',
}

# --- HARDWIRED FORBIDDEN LIST (NEVER ALLOWED IN TEXT) ---
# Add any explicit strings here that you want to forcefully flag if found in raw text.
# Useful for terms not in the glossary, or old habits you want to scrub.
FORBIDDEN_LIST = {
    'MTBF',
    'MTBR',
    'security',
    'privacy',
    # 'old_term_i_used_to_use',
}

def generate_regexes():
    with open(yaml_file, 'r', encoding='utf-8') as f:
        data = yaml.safe_load(f)

    regexes = set()
    
    # 1. Process terms dynamically from the YAML glossary
    for key, value in data.items():
        if not isinstance(value, dict):
            continue
            
        group = value.get('group', '')
        
        # Skip symbols to prevent math notation false positives
        if group == 'Symbol':
            continue
            
        # Collect all valid text forms for this entry
        for field in ['short', 'long', 'plural', 'longplural']:
            if field in value and isinstance(value[field], str):
                term = value[field].strip()
                
                # Check against the ignore list
                if term.lower() in IGNORE_LIST:
                    continue

                escaped_term = re.escape(term)
                
                # Case-sensitive for short acronyms
                if group == 'Acronym' and field in ['short', 'plural']:
                    pattern = rf'(?<![@#])\b{escaped_term}\b'
                else:
                    # Case-insensitive for Glossary items and long Acronym descriptions
                    pattern = rf'(?i)(?<![@#])\b{escaped_term}\b'
                    
                regexes.add(pattern)

    # 2. Process terms from the hardwired FORBIDDEN_LIST
    for term in FORBIDDEN_LIST:
        escaped_term = re.escape(term)
        # We make these case-sensitive exact matches by default.
        # If you want them to be case-insensitive, change it to: rf'(?i)(?<![@#])\b{escaped_term}\b'
        pattern = rf'(?<![@#])\b{escaped_term}\b'
        regexes.add(pattern)

    # 3. Write all generated patterns to the output file
    Path(output_file).parent.mkdir(parents=True, exist_ok=True)
    with open(output_file, 'w', encoding='utf-8') as f:
        for r in sorted(regexes):
            f.write(r + '\n')
            
    print(f"Generated {len(regexes)} regex patterns and saved to {output_file}")

if __name__ == "__main__":
    generate_regexes()
