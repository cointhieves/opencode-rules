#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${HOME}/.config/opencode"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

# --- Rule definitions (order matters for display) ---
RULE_DIRS=(
    "rule-authoring-standards"
    "no-ai-attribution"
    "data-deletion-protection"
    "research-before-assuming"
    "vendor-docs-first"
    "security-best-practices"
    "code-quality-standards"
    "plan-persistence"
    "performance-concurrency"
    "verification-requirements"
    "debugging-logs-first"
)

RULE_DESCRIPTIONS=(
    "How to write rules that actually get followed"
    "Never attribute output to AI in code or commits"
    "Never delete data without separate confirmation step"
    "Look it up before stating it as fact"
    "Check official docs before answering vendor questions"
    "Never hardcode credentials or secrets"
    "Prefer vendor patterns, keep it simple, document it"
    "Save plans to files before executing"
    "Parallelize network-bound work, always add timeouts"
    "Verify independently before claiming success"
    "Check logs before guessing at root causes"
)

echo "opencode-rules installer"
echo "========================"
echo ""

# --- Rule selection menu ---

echo "Available rules:"
echo ""
for i in "${!RULE_DIRS[@]}"; do
    printf "  %2d) %-32s %s\n" "$((i+1))" "${RULE_DIRS[$i]}" "${RULE_DESCRIPTIONS[$i]}"
done
echo ""

read -rp "Install which rules? (enter numbers separated by spaces, or 'all') [all]: " selection
selection="${selection:-all}"

SELECTED=()
if [[ "${selection}" == "all" ]]; then
    SELECTED=("${RULE_DIRS[@]}")
else
    for num in ${selection}; do
        idx=$((num - 1))
        if [[ ${idx} -ge 0 && ${idx} -lt ${#RULE_DIRS[@]} ]]; then
            SELECTED+=("${RULE_DIRS[$idx]}")
        else
            echo "WARNING: Skipping invalid selection: ${num}"
        fi
    done
fi

if [[ ${#SELECTED[@]} -eq 0 ]]; then
    echo "No rules selected. Exiting."
    exit 0
fi

echo ""
echo "Installing ${#SELECTED[@]} rule(s)..."
echo ""

# --- Create config directory ---

mkdir -p "${CONFIG_DIR}"

# --- Backup existing files ---

backup_file() {
    local file="$1"
    if [ -f "${file}" ]; then
        local backup="${file}.backup.${TIMESTAMP}"
        cp "${file}" "${backup}"
        echo "  Backed up: $(basename "${file}") -> $(basename "${backup}")"
    fi
}

backup_file "${CONFIG_DIR}/AGENTS.md"
backup_file "${CONFIG_DIR}/opencode.json"

# --- Assemble AGENTS.md from selected rules ---

echo "Building AGENTS.md from selected rules..."

AGENTS_FILE="${CONFIG_DIR}/AGENTS.md"
echo "# Global Standards" > "${AGENTS_FILE}"
echo "" >> "${AGENTS_FILE}"

for rule in "${SELECTED[@]}"; do
    full_file="${SCRIPT_DIR}/rules/${rule}/full.md"
    if [ -f "${full_file}" ]; then
        cat "${full_file}" >> "${AGENTS_FILE}"
        echo "" >> "${AGENTS_FILE}"
        echo "---" >> "${AGENTS_FILE}"
        echo "" >> "${AGENTS_FILE}"
        echo "  Added: ${rule}"
    else
        echo "  WARNING: ${full_file} not found, skipping"
    fi
done
echo ""

# --- Install reinforcement files ---

echo "Installing reinforcement files..."
for rule in "${SELECTED[@]}"; do
    reinforcement_file="${SCRIPT_DIR}/rules/${rule}/reinforcement.md"
    if [ -f "${reinforcement_file}" ]; then
        cp "${reinforcement_file}" "${CONFIG_DIR}/${rule}.md"
        echo "  Installed: ${rule}.md"
    else
        echo "  WARNING: ${reinforcement_file} not found, skipping"
    fi
done
echo ""

# --- Update opencode.json ---

echo "Updating opencode.json..."

OPENCODE_JSON="${CONFIG_DIR}/opencode.json"

# Build the list of instruction paths for selected rules
INSTRUCTION_PATHS=()
for rule in "${SELECTED[@]}"; do
    INSTRUCTION_PATHS+=("~/.config/opencode/${rule}.md")
done

if command -v python3 &>/dev/null; then
    python3 - "${OPENCODE_JSON}" "${INSTRUCTION_PATHS[@]}" <<'PYEOF'
import json
import sys
import os

json_path = sys.argv[1]
new_instructions = sys.argv[2:]

if os.path.exists(json_path):
    with open(json_path, "r") as f:
        config = json.load(f)
else:
    config = {}

existing = set(config.get("instructions", []))
for instruction in new_instructions:
    existing.add(instruction)

config["instructions"] = sorted(existing)

with open(json_path, "w") as f:
    json.dump(config, f, indent=2)
    f.write("\n")

print(f"  Updated: opencode.json ({len(new_instructions)} instruction paths)")
PYEOF
elif command -v jq &>/dev/null; then
    # Build JSON array of new instructions
    json_array="["
    for i in "${!INSTRUCTION_PATHS[@]}"; do
        [[ $i -gt 0 ]] && json_array+=","
        json_array+="\"${INSTRUCTION_PATHS[$i]}\""
    done
    json_array+="]"

    if [ -f "${OPENCODE_JSON}" ]; then
        jq --argjson new "${json_array}" '.instructions = (.instructions + $new | unique | sort)' \
            "${OPENCODE_JSON}" > "${OPENCODE_JSON}.tmp"
        mv "${OPENCODE_JSON}.tmp" "${OPENCODE_JSON}"
    else
        echo "${json_array}" | jq '{instructions: (. | sort)}' > "${OPENCODE_JSON}"
    fi
    echo "  Updated: opencode.json (${#INSTRUCTION_PATHS[@]} instruction paths)"
else
    echo "  WARNING: Neither python3 nor jq found. Cannot update opencode.json."
    echo "  Please manually add these paths to the 'instructions' array in ${OPENCODE_JSON}:"
    for path in "${INSTRUCTION_PATHS[@]}"; do
        echo "    ${path}"
    done
fi

echo ""
echo "Installation complete!"
echo ""
echo "Installed ${#SELECTED[@]} rule(s) to ${CONFIG_DIR}/"
echo ""
echo "To uninstall, run: ./uninstall.sh"
