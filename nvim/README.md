# 🌟 Neovim Config by ryan

A clean, fast, and portable Neovim setup focused on:
- Note-taking (Markdown + Neorg)
- Productivity (Telescope, Oil)
- Coding (Python, Treesitter, LSP-ready)
- Terminal Integration
- Custom keymaps and tools

---

## 📁 Folder Structure

```
nvim/
├── init.lua
├── README.md
└── lua/
    └── user/
        ├── plugins.lua
        ├── options.lua
        ├── keymaps.lua
        ├── oil.lua
        ├── telescope.lua
        ├── paths.lua
        └── ...
```

---

## 🔧 Requirements

| Tool                  | Version / Notes                                        |
|-----------------------|--------------------------------------------------------|
| [Neovim](https://neovim.io/) | **v0.9+** (for Lua config support)                  |
| [Git](https://git-scm.com/) | For cloning plugins and syncing configs             |
| [Python 3](https://python.org) | Needed for running Python files                     |
| [Ripgrep](https://github.com/BurntSushi/ripgrep) | Required for Telescope `live_grep` |
| Optional: [Nerd Fonts](https://www.nerdfonts.com/) | For proper icon rendering (recommend `FiraCode Nerd Font`) |

---

## 🧩 Plugins Used

Key plugins included:
- `lazy.nvim` - plugin manager
- `telescope.nvim` - fuzzy finder
- `oil.nvim` - file explorer
- `alpha.nvim` - custom start screen
- `toggleterm.nvim` - terminal integration
- `nvim-treesitter` - syntax highlighting
- `headlines.nvim` - better Markdown/Neorg headlines
- `neorg` - powerful note-taking system
- `persistence.nvim` - auto-save sessions

---

## 📦 Setup Instructions

> ⚠️ Assumes you're using Windows and placing this repo in `C:\Users\yourname\AppData\Local\nvim`.

### 1. 📁 Clone the repo
```sh
git clone https://github.com/yourusername/nvim.git %LOCALAPPDATA%\nvim
```

### 2. 🛠 Install prerequisites

Install required tools:

```powershell
choco install neovim git ripgrep python
```

Or manually install:
- Neovim from [https://neovim.io](https://neovim.io)
- Python (add to PATH)
- Ripgrep from [GitHub Releases](https://github.com/BurntSushi/ripgrep/releases)

### 3. 🧱 Launch Neovim to install plugins

```sh
nvim
```

Then press:
```vim
:Lazy
```
and hit `Enter` to install all plugins.

---

## 🗂 Syncing Notes Folder

Your notes folder is expected at:
```
C:\Users\ryang\Documents\Notes
```

This should contain:
- `CustomKeymaps.md` (auto-generated keybinds)
- `QuickNotes/` (quick notes)
- `Daily/` (daily notes)
- Neorg files (`.norg`) and Markdown notes

Make sure this is cloned to the **same path** on any system, or edit `paths.lua`.

---

## 💻 Key Features

- 🔥 Fast startup with lazy-loading
- ✍️ Enhanced Markdown with `headlines.nvim`
- 📑 Note capture (Neorg + Markdown)
- 🔍 Telescope file search
- 🖼 Oil: File explorer as a buffer
- ⌨️ Custom keymaps and keymap generator
- 💾 Auto-session persistence

---

## ⌨️ Example Keymaps

| Shortcut    | Action                           |
|-------------|----------------------------------|
| `<leader>rp` | Run current Python file         |
| `<leader>rc` | Open Neovim config              |
| `<leader>t`  | Toggle floating terminal        |
| `<leader>ni` | Open Neorg index                |
| `<leader>nq` | Create quick note               |
| `<leader>nd` | Open today’s daily note         |
| `<leader>nf` | Find files in notes             |
| `<leader>ns` | Grep inside notes               |
| `<leader>kg` | Generate keymaps markdown       |
| `<leader>ko` | Open keymaps markdown file      |

Full list is in `Documents/Notes/CustomKeymaps.md`.

---

## 🔁 Portability Tips

- ✅ Use `paths.lua` to define root paths via `vim.fn.expand()` or `os.getenv()` to avoid hardcoding.
- ✅ Place your notes repo at the same location on each machine for consistency.
- ✅ Use Git to sync both your Neovim and Notes repos across systems.

---

## 📚 Notes Repo (Optional)

If you keep your notes as a second repo, e.g.:
```sh
C:\Users\ryang\Documents\Notes\
```

...then clone it from:
```sh
git clone https://github.com/yourusername/notes.git "C:/Users/ryang/Documents/Notes"
```

---

## 🧪 Optional Enhancements

You can also optionally install:
- `markdown-preview.nvim` for live Markdown previews
- LSP and linters using `mason.nvim` or `lsp-zero.nvim`
- Theme plugins (e.g. `catppuccin`, `tokyonight`)

---

## 🧠 Contributing

This config is personal and evolving, but feel free to fork or adapt it.

---
