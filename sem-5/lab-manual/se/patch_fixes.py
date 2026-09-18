import os
import re

fixes = [
    # se_lab_manual.typ fixes
    (r"ride submission from cart review", "ride request from fare review"),
    (r"placeRide\(cart, payMethod\)", "confirmRide(session, payMethod)"),
    (r"ORDER_ITEM", "RIDE_SEGMENT"),
    (r"ORDERS", "RIDES"),
    (r"PRODUCT", "VEHICLE"),
    (r"items in cart", "valid pickup/drop-off"),
    (r"booking cart", "booking screen"),
    
    # SVG fixes
    (r"shopnex\.local", "swiftride.local"),
    (r"SHOPNEX DOMAIN MODEL", "SWIFTRIDE DOMAIN MODEL"),
    (r"PRODUCT", "VEHICLE"),
    (r"SHOPNEX E-COMMERCE PLATFORM", "SWIFTRIDE RIDE-SHARING PLATFORM"),
]

def apply_fixes():
    base_dir = "/home/mrbot/.temp/typst-docs/sem-5/lab-manual/se"
    for root, _, files in os.walk(base_dir):
        for file in files:
            if file.endswith('.typ') or file.endswith('.svg'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                new_content = content
                for old, new in fixes:
                    new_content = re.sub(old, new, new_content)
                
                if new_content != content:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Patched {filepath}")

if __name__ == "__main__":
    apply_fixes()
