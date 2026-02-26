#!/usr/bin/env bash
# Bruce Self-Resurrection Bootstrap
# Usage: curl -sSf https://raw.githubusercontent.com/brucejohnson82/resurrection/main/bootstrap.sh | OP_TOKEN="ops_..." bash
set -euo pipefail

OP_TOKEN="${OP_TOKEN:?'Set OP_TOKEN to your 1Password service account token'}"

# Install 1Password CLI if missing
if ! command -v op &>/dev/null; then
  echo "📦 Installing 1Password CLI..."
  mkdir -p ~/.local/bin
  curl -sSfLo /tmp/op.zip "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.3/op_linux_amd64_v2.30.3.zip"
  unzip -o /tmp/op.zip op -d ~/.local/bin && chmod +x ~/.local/bin/op
  rm -f /tmp/op.zip
fi
export PATH="$HOME/.local/bin:$PATH"

# Fetch GitHub PAT and clone brain repo
echo "🔑 Fetching GitHub PAT from 1Password..."
GH_PAT=$(OP_SERVICE_ACCOUNT_TOKEN="$OP_TOKEN" op item get "GitHub" --vault 5ghxc65txwteglxpaf6tc7khme --fields token --reveal)

BRAIN="$HOME/.openclaw/workspace"
if [ -d "$BRAIN/.git" ]; then
  echo "🧠 Brain repo already exists at $BRAIN"
else
  echo "🧠 Cloning brain repo..."
  mkdir -p "$(dirname "$BRAIN")"
  git clone "https://brucejohnson82:${GH_PAT}@github.com/brucejohnson82/brain.git" "$BRAIN"
fi

echo ""
echo "✅ Brain repo ready at $BRAIN"
echo ""
echo "Next steps:"
echo "  1. Install Ansible:  pip install --user ansible-core"
echo "  2. Resurrect:        cd $BRAIN/ansible && ansible-playbook resurrect.yml -e op_token=\$OP_TOKEN"
