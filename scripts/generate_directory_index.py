#!/usr/bin/env python3
import os
import math
from datetime import datetime

def format_size(size_bytes):
    if size_bytes == 0:
        return "0 B"
    size_name = ("B", "KB", "MB", "GB")
    i = int(math.floor(math.log(size_bytes, 1024)))
    p = math.pow(1024, i)
    s = round(size_bytes / p, 2)
    return f"{s} {size_name[i]}"

def generate_index(arch_dir, template_path):
    packages_dir = os.path.join(arch_dir, "packages")
    output_file = os.path.join(packages_dir, "index.html")

    if not os.path.exists(packages_dir):
        print(f"Directory {packages_dir} does not exist. Skipping.")
        return

    # Template einlesen
    with open(template_path, "r", encoding="utf-8") as f:
        template_content = f.read()

    files = []
    for f in sorted(os.listdir(packages_dir)):
        if f == "index.html":
            continue
        filepath = os.path.join(packages_dir, f)
        if os.path.isfile(filepath):
            stat = os.stat(filepath)
            size = format_size(stat.st_size)
            mtime = datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d %H:%M')
            files.append({"name": f, "size": size, "mtime": mtime})

    rows_html = ""
    for f in files:
        rows_html += f"""
        <tr>
          <td><a href="{f['name']}" class="file-link">📦 {f['name']}</a></td>
          <td class="file-size">{f['size']}</td>
          <td class="file-date">{f['mtime']}</td>
        </tr>"""

    if not files:
        rows_html = '<tr><td colspan="3" style="text-align:center; color: var(--text-muted);">No packages available in this directory.</td></tr>'

    arch_name = os.path.basename(arch_dir)
    rendered_html = template_content.replace("{{ARCH}}", arch_name).replace("{{PACKAGE_ROWS}}", rows_html)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(rendered_html)
    print(f"Successfully generated {output_file}")

if __name__ == "__main__":
    script_dir = os.path.dirname(os.path.realpath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, ".."))
    template = os.path.join(script_dir, "packages_template.html")

    architectures = ["x86_64"]
    for arch in architectures:
        arch_path = os.path.join(project_root, arch)
        generate_index(arch_path, template)
