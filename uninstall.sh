#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${HOME}/.config/opencode"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "opencode-rules uninstaller"
echo "=========================="
echo ""

if [ ! -d "${CONFIG_DIR}" ]; then
    echo "Config directory not found: ${CONFIG_DIR}"
    echo "Nothing to uninstall."
    exit 0
fi

# --- Remove installed reinforcement files ---

echo "Removing installed reinforcement files..."
for rule_dir in "${SCRIPT_DIR}"/rules/*/; do
    rule_name="$(basename "${rule_dir}")"
    target="${CONFIG_DIR}/${rule_name}.md"
    if [ -f "${target}" ]; then
        rm "${target}"
        echo "  Removed: ${rule_name}.md"
    fi
done
echo ""

# --- Restore backups ---

echo "Restoring backups..."

restore_backup() {
    local file="$1"
    local latest_backup
    latest_backup="$(ls -t "${file}".backup.* 2>/dev/null | head -1 || true)"
    if [ -n "${latest_backup}" ]; then
        mv "${latest_backup}" "${file}"
        echo "  Restored: $(basename "${file}") from $(basename "${latest_backup}")"
    else
        if [ -f "${file}" ]; then
            echo "  No backup found for $(basename "${file}") — leaving current version"
        fi
    fi
}

restore_backup "${CONFIG_DIR}/AGENTS.md"
restore_backup "${CONFIG_DIR}/opencode.json"

echo ""
echo "Uninstall complete."
echo ""
echo "Note: If you had no previous AGENTS.md or opencode.json before installing,"
echo "those files remain in place. Remove them manually if desired:"
echo "  rm ${CONFIG_DIR}/AGENTS.md"
echo "  rm ${CONFIG_DIR}/opencode.json"
