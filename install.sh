#!/usr/bin/env bash
# Install quality-checks into the current project
# Usage: curl -sL https://raw.githubusercontent.com/el-musleh/ai-skill-quality-audit/main/install.sh | bash

set -euo pipefail

REPO="https://github.com/el-musleh/quality-checks.git"
TARGET="quality-checks"

if [ -d "$TARGET" ]; then
  echo "quality-checks/ already exists. Updating..."
  cd "$TARGET" && git pull && cd ..
else
  echo "Installing quality-checks..."
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git submodule add "$REPO" "$TARGET"
    echo "Added as git submodule."
  else
    git clone "$REPO" "$TARGET"
    echo "Cloned into $TARGET/."
  fi
fi

echo ""
echo "Done! Run audits with:"
echo "  ./quality-checks/run-all.sh"
echo "  ./quality-checks/run-all.sh ui-ux"
echo "  ./quality-checks/ui-ux/zindex/audit.sh"
