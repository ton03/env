# Ton's Environment

Personal dotfiles, shell config, keyboard layouts, and AI agent configuration.

## What's Here

```
env/
├── .agents/              # AI agent config (symlinked to ~/.agents)
│   ├── AGENTS.md         # coding preferences & conventions
│   ├── PROFILE.md        # personal profile (tool-agnostic)
│   ├── README.md         # per-tool bridge setup
│   └── kage/             # shadow — learns and maintains the profile
│       ├── SKILL.md      # full profile + hygiene instructions
│       └── LOG.md        # session observation log
├── aliases.sh            # shell aliases (git, navigation, etc.)
├── functions.sh          # shell functions (parse_git_branch, resize_image)
├── zshrc.sh              # zsh entrypoint — sources aliases + functions
├── bashrc.sh             # bash entrypoint — sources aliases + functions
├── zshrc_theme.sh        # powerlevel9k theme config (legacy)
├── .p10k.zsh             # powerlevel10k config
├── keeb/                 # keyboard layouts (QMK/VIA)
│   ├── dox.json          # ErgoDox
│   ├── nk65.json         # NK65
│   └── nk65_v2.json      # NK65 v2
└── vscode/               # VS Code settings
    ├── settings_mac.json # personal mac
    └── settings_iress.json # work (legacy)
```

## New Laptop Setup

```bash
git clone git@github.com:ton03/env.git ~/Hack/env
cd ~/Hack/env && ./setup.sh
```

See `setup.sh` for what gets installed and symlinked.
