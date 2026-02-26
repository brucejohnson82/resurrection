# 🧟 Resurrect

Self-resurrection bootstrap for Bruce Johnson.

## One-Liner

```bash
curl -sSf https://raw.githubusercontent.com/brucejohnson82/resurrection/main/bootstrap.sh | OP_TOKEN="ops_..." bash
```

This will:
1. Install the 1Password CLI (if missing)
2. Fetch the GitHub PAT from 1Password
3. Clone the [brain](https://github.com/brucejohnson82/brain) repo

## Then What?

```bash
pip install --user ansible-core
cd ~/.openclaw/workspace/ansible
ansible-playbook resurrect.yml -e "op_token=$OP_TOKEN"
```

The Ansible playbook in the brain repo handles everything else — Node.js, OpenClaw, Chromium, secrets, config, gateway startup.

## Prerequisites

- A fresh Ubuntu/Debian machine
- Your 1Password service account token
- `curl`, `git`, `unzip` (usually pre-installed)
