#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for restsharp/RestSharp
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.
# Expects to be run from the docs/ directory of the checked-out source tree.

# --- Node version ---
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    nvm install 20
    nvm use 20
fi

node --version

# --- Package manager: pnpm 10 ---
if ! command -v pnpm &>/dev/null || ! pnpm --version | grep -q "^10"; then
    npm install -g pnpm@10
fi
pnpm --version

# --- Dependencies ---
pnpm install --no-frozen-lockfile

# --- Build ---
pnpm run build

echo "[DONE] Build complete."
