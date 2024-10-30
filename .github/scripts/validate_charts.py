#!/usr/bin/env python3

import glob
import os
import re
import sys
from pathlib import Path

import yaml


def load_yaml_file(file_path):
    try:
        with open(file_path, "r") as f:
            return yaml.safe_load(f)
    except Exception as e:
        print(f"Error loading {file_path}: {e}")
        return None


def compare_yaml_files(file1, file2):
    content1 = load_yaml_file(file1)
    content2 = load_yaml_file(file2)

    if content1 != content2:
        print("❌ Files are not in sync:")
        print(f"  - {file1}")
        print(f"  - {file2}")
        return False
    return True


def validate_example_makefile():
    makefile_path = "examples/Makefile.example"
    if not os.path.exists(makefile_path):
        return True

    with open(makefile_path, "r") as f:
        makefile_content = f.read()

    # Extract version patterns like '--version=X.X.X'
    version_patterns = re.findall(
        r"helm upgrade -i ([^\s]+) .+?--version=(\d+\.\d+\.\d+)", makefile_content
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
        if not chart_data:
            continue

        chart_version = chart_data.get("version")
        if version != chart_version:
            print(f"❌ Version mismatch in Makefile.example for {base_service}")
            print(f"  Makefile version: {version}")
            print(f"  Chart version: {chart_version}")
            success = False

    return success


def main():
    success = True

    # Check values files sync
    chart_values = glob.glob("charts/**/values/production.yaml", recursive=True)
    for chart_value_file in chart_values:
        # Determine the service name from the path
        service_name = Path(chart_value_file).parts[-3]
        example_file = f"examples/values/{service_name}-production.yaml"

        if os.path.exists(example_file):
            if not compare_yaml_files(chart_value_file, example_file):
                success = False
        else:
            print(f"❌ Missing example values file: {example_file}")
            success = False

    # Check example Makefile versions
    if not validate_example_makefile():
        success = False

    if not success:
        sys.exit(1)

    print("✅ All checks passed!")


if __name__ == "__main__":
    main()
