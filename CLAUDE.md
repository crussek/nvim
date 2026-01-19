# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim. The configuration is primarily a single-file setup (`init.lua`) with modular plugin additions in `lua/`.

## Commands

### Lua Formatting
```bash
stylua --check .     # Check formatting
stylua .             # Format all Lua files
```

Stylua config in `.stylua.toml`: 160 column width, 2-space indentation, Unix line endings, single quotes preferred.

### Python Environment (for Molten/Jupyter support)
```bash
uv sync              # Install Python dependencies from pyproject.toml
```

Python virtual environment in `.venv/` is managed by uv. Used for Molten plugin (Jupyter integration).

## Architecture

### File Structure
- `init.lua` - Main configuration file containing core settings, keymaps, and plugin setup via lazy.nvim
- `lua/kickstart/plugins/` - Modular plugins from kickstart (debug, lint, autopairs, neo-tree, gitsigns)
- `lua/custom/plugins/` - User custom plugins (molten, copilot-chat, diffview, image, jupytext)
- `local.lua` (optional, gitignored) - Machine-specific overrides loaded at startup

### Plugin Management
Uses lazy.nvim. Plugins are loaded from:
1. Direct specifications in `init.lua`
2. `require 'kickstart.plugins.*'` for kickstart modules
3. `{ import = 'custom.plugins' }` for custom plugins

### Key Conventions
- Leader key: `<Space>`
- Local leader: `<Space>` (same as leader)
- Nerd Font enabled: `vim.g.have_nerd_font = true`

### LSP Configuration
Mason manages LSP installations. Configured servers in `init.lua`:
- `lua_ls` - Lua
- `ts_ls` - TypeScript
- `pylsp` - Python (with black, mypy, pycodestyle, pyflakes)
- `bashls` - Bash

### Formatting
Conform.nvim handles formatting:
- Lua: stylua
- Python: isort + black (format-on-save disabled)
- TypeScript/TSX: prettier

### Key Keymaps
- `\` - Toggle NeoTree file explorer
- `|` - NeoTree document symbols
- `<leader>sf` - Search files (Telescope)
- `<leader>sg` - Live grep (Telescope)
- `<leader>b` - Toggle breakpoint (DAP)
- `<F5>` - Start/continue debugging
- `<localleader>mm` - Initialize Molten (Jupyter)
- `<localleader>ml` - Evaluate line in Molten
