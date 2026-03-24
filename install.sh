#!/bin/bash

# Development Workflow Skill Installer
# This script copies the bundled subskills into the agent's skills directory.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
TARGET_SKILLS_DIR="$PARENT_DIR/skills"

if [ ! -d "$TARGET_SKILLS_DIR" ]; then
    echo "❌ Error: Cannot find skills directory at: $TARGET_SKILLS_DIR"
    echo "   Make sure you are running this from within the skills/ tree."
    exit 1
fi

echo "📦 Installing development workflow subskills..."
echo "Target skills directory: $TARGET_SKILLS_DIR"
echo ""

SUBSKILLS="planner coder tester reviewer"
for sub in $SUBSKILLS; do
    SRC="$SCRIPT_DIR/subskills/$sub"
    if [ -d "$SRC" ]; then
        cp -r "$SRC" "$TARGET_SKILLS_DIR/"
        echo "  ✅ Installed: $sub"
    else
        echo "  ⚠️  Missing: $sub (not found in subskills/)"
    fi
done

echo ""
echo "✨ Installation complete!"
echo "Next steps:"
echo "  1. Ensure your agent loads the 'development-workflow' skill (or let autoload pick it up)."
echo "  2. Optionally configure your agent to use this workflow for development requests."
echo "  3. Restart your agent if it's already running."
echo ""
echo "For usage details, see README.md and docs/integration.md"
