#!/usr/bin/env python3

import glob
import os
import re
import sys
from difflib import unified_diff
from pathlib import Path

import yaml


def load_yaml_file(file_path):
    if not os.path.exists(file_path):
        print(f"Error: File not found: {file_path}")
        return None, None

    try:
        with open(file_path, "r", encoding="utf-8") as f:
            raw_content = f.read()
            yaml_content = yaml.safe_load(raw_content)
            return yaml_content, raw_content
    except Exception as e:
        print(f"Error loading {file_path}: {e}")
        return None, None


def compare_yaml_files(file1, file2):
    result1 = load_yaml_file(file1)
    result2 = load_yaml_file(file2)

    if result1[0] is None or result2[0] is None:
        return False

    content1, raw1 = result1
    content2, raw2 = result2

    if content1 != content2:
        print("❌ Files are not in sync!")
        print(f"Source file: {file1}")
        print(f"Target file: {file2}")
        print("-" * 80)

        # Generate and print git-style diff
        diff = unified_diff(
            raw1.splitlines(keepends=True),
            raw2.splitlines(keepends=True),
            fromfile="Source",
            tofile="Target",
            lineterm="",
        )
        print("".join(list(diff)))
        return False
    return True


def validate_production_files():
    success = True

    # Check values files sync
    chart_values = glob.glob("charts/**/values/production*.yaml", recursive=True)
    for chart_value_file in chart_values:
        service_name = Path(chart_value_file).parts[-3]
        production_file = Path(chart_value_file).parts[-1]  # e.g. "production-0.yaml"

        # Construct the corresponding example file path
        example_file = f"examples/values/{service_name}-{production_file}"

        if os.path.exists(example_file):
            if not compare_yaml_files(chart_value_file, example_file):
                success = False
        else:
            print(f"❌ Missing example values file: {example_file}")
            success = False

    return success


def validate_example_makefile():
    makefile_path = "examples/Makefile.example"
    if not os.path.exists(makefile_path):
        return True

    with open(makefile_path, "r") as f:
        # Replace line continuations (\newline) with spaces
        makefile_content = re.sub(r"\\\n\s*", " ", f.read())

    # Extract version patterns from helm upgrade commands
    version_patterns = re.findall(
        r"helm upgrade -i ([a-zA-Z0-9-]+)\s+oci://[^\s]+\s+.*?--version=(\d+\.\d+\.\d+)",
        makefile_content,
    )

    success = True
    for service, version in version_patterns:
        # Handle special cases like l2-sequencer-0 -> l2-sequencer
        base_service = re.sub(r"-\d+$", "", service)

        # Find corresponding Chart.yaml
        chart_file = f"charts/{base_service}/Chart.yaml"
        if not os.path.exists(chart_file):
            print(f"❌ Chart file not found for service: {base_service}")
            success = False
            continue

        chart_data = load_yaml_file(chart_file)
        if not chart_data[0]:
            continue

        chart_version = chart_data[0].get("version")
        if version != chart_version:
            print(f"❌ Version mismatch in Makefile.example for {base_service}")
            print(f"  Makefile version: {version}")
            print(f"  Chart version: {chart_version}")
            success = False

    return success


def main():
    success = True

    # Check production files sync
    if not validate_production_files():
        success = False

    # Check example Makefile versions
    if not validate_example_makefile():
        success = False

    if not success:
        sys.exit(1)

    print("✅ All checks passed!")


if __name__ == "__main__":
    main()
