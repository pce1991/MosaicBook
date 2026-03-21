import subprocess
import argparse
from pathlib import Path

def convert_md_to_typst(source_dir, dest_dir):
    source_path = Path(source_dir)
    dest_path = Path(dest_dir)

    # Validate source
    if not source_path.is_dir():
        print(f"Error: Source directory '{source_dir}' does not exist.")
        return

    # Create destination if it doesn't exist
    if not dest_path.exists():
        print(f"Creating destination directory: {dest_path}")
        dest_path.mkdir(parents=True, exist_ok=True)

    print(f"Converting files from: {source_path.resolve()}")
    print(f"Saving files to:       {dest_path.resolve()}\n")
    
    count = 0

    for md_file in source_path.glob("*.md"):
        # Construct output path: dest_dir + original_filename + .typ
        output_file = dest_path / md_file.with_suffix(".typ").name

        print(f"Processing: {md_file.name} -> {output_file.name}")

        try:
            subprocess.run(['pandoc', str(md_file), '-o', str(output_file)], check=True)
            count += 1
        except subprocess.CalledProcessError as e:
            print(f"  [!] Error converting {md_file.name}: {e}")
        except FileNotFoundError:
            print("  [!] Error: Pandoc not found in PATH.")
            return

    print(f"\nDone! Successfully converted {count} files.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert Markdown to Typst with custom source and destination.")
    parser.add_argument("source", help="Directory containing the .md files")
    parser.add_argument("destination", help="Directory where .typ files will be saved")
    
    args = parser.parse_args()
    convert_md_to_typst(args.source, args.destination)
