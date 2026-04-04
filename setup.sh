#!/bin/bash
# LLM Wiki — First-time setup
# Run this once after cloning or copying the scaffold

echo "🧠 LLM Wiki Setup"
echo "=================="

# Git config
read -p "Your name (for git): " GIT_NAME
read -p "Your email (for git): " GIT_EMAIL
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

# Domain customization reminder
echo ""
echo "✅ Git configured."
echo ""
echo "Next steps:"
echo "  1. Open CLAUDE.md and fill in the 'Domain Configuration' section"
echo "  2. Open this folder in Obsidian (or your preferred markdown editor)"
echo "  3. Run 'claude' from this directory to start Claude Code"
echo "  4. Drop a source file into raw/ and say 'ingest raw/your-file.md'"
echo ""
echo "Happy wiki-building!"
