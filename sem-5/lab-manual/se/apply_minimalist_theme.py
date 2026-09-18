import os
import re

color_map = {
    # Backgrounds and containers (Dark to Light)
    "#0f172a": "#ffffff",
    "#1e293b": "#f8fafc",
    "#162032": "#f1f5f9",
    "#334155": "#e2e8f0",
    "#475569": "#cbd5e1",
    "#64748b": "#94a3b8",
    "#94a3b8": "#475569",
    "#cbd5e1": "#334155",
    "#e2e8f0": "#1e293b",
    "#f1f5f9": "#0f172a",
    "#f8fafc": "#0f172a",
    "#ffffff": "#020617",
    "#000000": "#64748b", # Lighten shadows

    # Blues
    "#38bdf8": "#0284c7",
    "#7dd3fc": "#0369a1",
    "#0ea5e9": "#0284c7",
    "#0284c7": "#0369a1",
    
    # Indigos
    "#818cf8": "#4f46e5",
    "#a5b4fc": "#4338ca",
    
    # Emeralds
    "#10b981": "#059669",
    "#34d399": "#047857",
    "#a7f3d0": "#065f46",
    
    # Ambers
    "#fbbf24": "#d97706",
    "#fcd34d": "#b45309",
    "#f59e0b": "#ea580c",
    
    # Purples
    "#a855f7": "#9333ea",
    "#c084fc": "#7e22ce",
    
    # Reds
    "#450a0a": "#fee2e2",
    "#ef4444": "#dc2626",
    "#fca5a5": "#991b1b",
    
    # Pinks
    "#f472b6": "#db2777",
}

# Create a regex pattern that matches any of the keys
pattern = re.compile('|'.join(re.escape(k) for k in color_map.keys()), re.IGNORECASE)

def replace_colors(text):
    return pattern.sub(lambda m: color_map.get(m.group(0).lower(), m.group(0)), text)

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    new_content = replace_colors(content)
    
    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")

def main():
    base_dir = "/home/mrbot/.temp/typst-docs/sem-5/lab-manual/se"
    
    # Process typst files
    for root, _, files in os.walk(base_dir):
        for file in files:
            if file.endswith('.typ') or file.endswith('.svg'):
                process_file(os.path.join(root, file))

if __name__ == "__main__":
    main()
