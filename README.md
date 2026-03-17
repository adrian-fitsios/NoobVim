# NoobVim

A nvim config for absolute ~~noobs~~ beginners.

# 🎯 Aim
To provide easy transition from mainstream IDEs into NeoVim.

# 📜 Requirements
- macOS or Linux (*nix)
- [Neovim 0.10+](https://github.com/neovim/neovim/releases)
- [git](https://git-scm.com/)
- A [Nerd Font](https://www.nerdfonts.com/) installed in your terminal emulator

<details>
  <summary><b><u> Introduction to Vim/Nvim </u></b></summary>

# Glossary of Vim/Nvim Terms

If you've used Vim before, whether as a plugin inside another IDE, or standalone, feel free to skip this section.

When searching for documentation of some feature, you'll probably stumble upon two ways of doing things - either with VimScript, or with Lua. For a bit of context - Vim/Nvim used to be configured with a .vimrc file, which was written entirely in [VimScript](http://vimdoc.sourceforge.net/htmldoc/usr_41.html#script). Luckily for us, Nvim now supports configuration through [Lua](https://lua.org/).

## Modes

There are 7 modes that your editor can be in, however, the 3 most important ones are: NORMAL, INSERT and VISUAL.
[This article](https://irian.to/blogs/introduction-to-vim-modes/) gives a nice introduction to them.

## Buffers, Windows and Tabs

Coming into Vim/Nvim, we'll need to let go of the notion that every file is opened in its own tab/window. Windows != Tabs and Windows != Buffers (needless to say, Buffers != Tabs).

[This article](https://alpha2phi.medium.com/neovim-for-beginners-managing-buffers-91367668ce7) does a good job of summing up the differences, but a TL;DR version:

- A buffer == file loaded to memory for editing, the file is unchanged until you save it (`:w` in NORMAL mode or `Ctrl+s` in any other mode)
- A window == a way to see a buffer, there might be multiple windows looking at one buffer
- A tab == a collection of windows

## Special key notation
Special keys have a short notation in vim, as follows:

| Notation         | Key                                                           |
|------------------|---------------------------------------------------------------|
| `<BS>`           | Backspace                                                     |
| `<Tab>`          | Tab                                                           |
| `<C>`            | Control / Command                                             |
| `<A>`            | Alt / Option                                                  |
| `<leader>`       | Up to the user - NoobVim's default is `space`                 |
| `<CR>`           | Enter                                                         |
| `<Enter>`        | Enter                                                         |
| `<Return>`       | Enter                                                         |
| `<Esc>`          | Escape                                                        |
| `<Space>`        | Space                                                         |
| `<Up>`           | Up arrow                                                      |
| `<Down>`         | Down arrow                                                    |
| `<Left>`         | Left arrow                                                    |
| `<Right>`        | Right arrow                                                   |
| `<F1>` - `<F12>` | Function keys 1 to 12                                         |
| `<Insert>`       | Insert                                                        |
| `<Del>`          | Delete                                                        |
| `<Home>`         | Home                                                          |
| `<End>`          | End                                                           |
| `<PageUp>`       | Page-Up                                                       |
| `<PageDown>`     | Page-Down                                                     |
| `<bar>`          | the `\|` character, which otherwise needs to be escaped `\\|` |

## Keybindings (shortcuts)

Each mode has a list of bindings. The bindings are just combinations of keys that'll result in an action. E.g. out of the box, pressing `k` while in NORMAL mode (n) moves the cursor up one line.
There is nothing stopping you from binding the key `k` to do something else.
To see all your bindings currently set up, while in NORMAL mode, type `:map` and press enter. You'll see a lot of lines looking like this:

```text
n  gcc         * <Lua function 76>
                 Comment toggle current line
```
which can be read like this:
| mode prefix | key combination | action                                          |
|-------------|-----------------|-------------------------------------------------|
| n           | gcc             | * <Lua function 76> Comment toggle current line |

or in other words: pressing `gcc` while in NORMAL mode, will result in calling a function that'll invoke the toggle current line functionality of the Comment plugin

### Keybinding scopes

Keybindings have scopes. You can have global keybindings that'll be available for a particular mode in any buffer, or you can scope them to particular buffers.
This is very handy, as you might want to have specific options only in certain scenarios. E.g it'd probably make sense to only have the shortcut to open / go to a file, when you're in a file viewer of sorts, rather than in every buffer.

### Which-key

NoobVim uses [which-key plugin](https://github.com/folke/which-key.nvim) to keep track of which keybindings are available in any given buffer. Press `<Space>` and wait a moment — a popup will show all available leader bindings.

</details>

# 🚀 Getting started

## macOS (recommended)

```bash
git clone https://github.com/adrian-soomro/NoobVim.git
cd NoobVim
bash scripts/install.sh
```

The installer will:
1. Install Homebrew (if missing)
2. Install Neovim, ripgrep, fd, glow, cmake via brew
3. Install [mise](https://mise.jdx.dev/) (runtime version manager for Python/Node)
4. Install [direnv](https://direnv.net/)
5. Copy the config to `~/.config/nvim`
6. Run a headless `Lazy sync` to install all plugins

## Ubuntu / Debian

```bash
git clone https://github.com/adrian-soomro/NoobVim.git
cd NoobVim
bash scripts/install.sh
```

The installer detects Linux and uses `apt` + `brew` (linuxbrew) automatically.

## Manual install

1. Clone this repo to `~/.config/nvim`
2. Install the binaries listed below
3. Open `nvim` — [lazy.nvim](https://github.com/folke/lazy.nvim) will bootstrap itself and install all plugins automatically

### Required binaries

| Binary | Purpose | Install |
|--------|---------|---------|
| [neovim 0.10+](https://github.com/neovim/neovim/releases) | The editor | `brew install neovim` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Telescope live grep | `brew install ripgrep` |
| [fd](https://github.com/sharkdp/fd) | Telescope file search | `brew install fd` |
| [glow](https://github.com/charmbracelet/glow) | Markdown preview | `brew install glow` |
| [cmake](https://cmake.org/) | Build telescope-fzf-native | `brew install cmake` |
| [git 2.31+](https://git-scm.com/) | Required by many plugins | system or `brew install git` |
| [go](https://go.dev/) | Required by sqls (SQL LSP) | `brew install go` |

### Optional but recommended

| Binary | Purpose |
|--------|---------|
| [mise](https://mise.jdx.dev/) | Per-project Python/Node version management |
| [direnv](https://direnv.net/) | Per-directory env activation (virtualenvs, etc.) |
| [dotnet SDK](https://dotnet.microsoft.com/) | C# / OmniSharp LSP support |

After install, open nvim and run `:Lazy sync` if plugins didn't install automatically.

---

# ⚙️ Feature toggles

Every feature can be individually enabled or disabled in `config.json` at the root of the config directory. The file uses an **opt-out** model — a feature is enabled unless explicitly set to `false`.

```json
{
  "features": {
    "codecompanion": false,
    "dap": { "enabled": false },
    "lsp": {
      "enabled": true,
      "servers": {
        "omnisharp": false
      }
    }
  }
}
```

After changing `config.json`, restart Neovim for the changes to take effect.

---

# 🗺️ Keybindings

Press `<Space>` (leader) in NORMAL mode and wait — which-key will show a popup of all available bindings.

## Global shortcuts

| Key | Mode | Action |
|-----|------|--------|
| `<C-s>` | any | Save buffer |
| `<C-w>` | any | Close buffer |
| `<C-p>` | n | Find files (Telescope) |
| `<C-f>` | n | Search in current buffer |
| `<C-S-f>` | n | Live grep (search directory) |
| `<C-S-v>` | any | Clipboard history |
| `<A-b>` | n | Toggle file explorer |
| `<A-;>` | n | Toggle terminal 1 |
| `<A-'>` | n | Toggle terminal 2 |
| `<A-p>` | any | Preview markdown (glow) |

## Buffer navigation (tabs)

| Key | Action |
|-----|--------|
| `<C-,>` | Previous buffer |
| `<C-.>` | Next buffer |
| `<A-1>` – `<A-9>` | Go to buffer N |
| `<C-S-w>` | Close all other buffers |

## Window navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move to left/down/up/right window |

## LSP

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `R` | Rename symbol |
| `<leader>gd` | Peek definition |
| `<leader>gi` | Find implementations / references |
| `<leader>ca` | Code actions |
| `<leader>sd` | Show diagnostics |
| `<leader>f` | Format file |
| `<leader>oo` | Toggle symbol outline |
| `[d` / `]d` | Previous / next diagnostic |

## Git

| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hd` | Diff this file |
| `<leader>hD` | Open diffview |
| `[[` / `]]` | Previous / next hunk |

## Debug (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Run code |
| `<S-F5>` | Start / continue debug session |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>ib` | Toggle breakpoint |

## Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle project diagnostics |
| `<leader>tT` | Toggle buffer diagnostics |
| `<leader>ts` | Toggle symbols |

---

# 🤖 AI integration (CodeCompanion)

NoobVim includes [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) for AI-assisted editing via Claude.

Set your API key before opening Neovim:

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
```

Then use `:CodeCompanionChat` to open a chat buffer, or select code in VISUAL mode and run `:CodeCompanion` for inline edits.

To disable, set `"codecompanion": false` in `config.json`.

---

# 🧩 Plugins

| Category | Plugin |
|----------|--------|
| Plugin manager | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| Colour scheme | [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) (nordfox) |
| Status line | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) |
| Buffer tabs | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) |
| Startup | [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) |
| Sessions | [persistence.nvim](https://github.com/folke/persistence.nvim) |
| File explorer | [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) |
| Fuzzy finder | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) |
| LSP installer | [mason.nvim](https://github.com/williamboman/mason.nvim) |
| LSP engine | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) |
| LSP UI | [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) |
| Formatter | [conform.nvim](https://github.com/stevearc/conform.nvim) |
| Autocompletion | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) |
| Snippets | [LuaSnip](https://github.com/L3MON4D3/LuaSnip) |
| Syntax | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) |
| Debugger | [nvim-dap](https://github.com/mfussenegger/nvim-dap) + ui + python + JS/TS |
| Git signs | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) |
| Diff viewer | [diffview.nvim](https://github.com/sindrets/diffview.nvim) |
| Terminal | [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) |
| Code runner | [code_runner.nvim](https://github.com/CRAG666/code_runner.nvim) |
| Keybinding help | [which-key.nvim](https://github.com/folke/which-key.nvim) |
| Diagnostics panel | [trouble.nvim](https://github.com/folke/trouble.nvim) |
| TODO highlights | [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) |
| Clipboard history | [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua) |
| Markdown preview | [glow.nvim](https://github.com/ellisonleao/glow.nvim) |
| Commenting | [Comment.nvim](https://github.com/numToStr/Comment.nvim) |
| AI assistant | [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) |
| Env isolation | [direnv.nvim](https://github.com/actionshrimp/direnv.nvim) |
| Per-project LSP | [neoconf.nvim](https://github.com/folke/neoconf.nvim) |

---

# 🖥️ Terminal emulator setup

Certain keybindings use `Ctrl+Shift+key` combinations. These need to be explicitly forwarded by your terminal emulator.

NoobVim relies on these combinations:

| Combination |
|-------------|
| `Ctrl-Shift-f` |
| `Ctrl-Shift-v` |
| `Ctrl-Shift-w` |
| `Ctrl-.` |
| `Ctrl-,` |

### Alacritty / Kitty

Add to your Alacritty config (`~/.config/alacritty/alacritty.toml`):

```toml
[font]
normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
size = 13

[keyboard]
bindings = [
    { key = "F", mods = "Control|Shift", action = "ReceiveChar" },
    { key = "W", mods = "Control|Shift", action = "ReceiveChar" },
    { key = "V", mods = "Control|Shift", action = "ReceiveChar" },
    { key = ".", mods = "Control",        action = "ReceiveChar" },
    { key = ",", mods = "Control",        action = "ReceiveChar" }
]
```

### iTerm2 (macOS)

Go to **Preferences → Keys → Key Bindings** and add entries to send the following escape sequences:

| Combination | Escape sequence |
|-------------|----------------|
| `Ctrl-Shift-f` | `\u001b[70;5u` |
| `Ctrl-Shift-v` | `\u001b[86;5u` |
| `Ctrl-Shift-w` | `\u001b[87;5u` |
| `Ctrl-.` | `\u001b[46;5u` |
| `Ctrl-,` | `\u001b[44;5u` |

### macOS ⌘ (Command) shortcuts

Terminal Neovim never receives the Command key — macOS intercepts it before any byte reaches Neovim. The fix is **terminal-level remapping**: tell your terminal to forward ⌘+key as the same byte sequence it would send for the corresponding ⌃+key. Neovim sees Ctrl — no Lua changes needed. Both ⌃ and ⌘ will work simultaneously.

#### iTerm2

Go to **Preferences → Profiles → [your profile] → Keys → Key Mappings** and add entries with the "+" button:

| Key combo | Action | Value |
|-----------|--------|-------|
| ⌘S | Send Hex Code | `13` |
| ⌘P | Send Hex Code | `10` |
| ⌘F | Send Hex Code | `06` |
| ⌘W | Send Hex Code | `17` |
| ⌘⇧F | Send Escape Sequence | `[70;5u` |
| ⌘⇧V | Send Escape Sequence | `[86;5u` |
| ⌘⇧W | Send Escape Sequence | `[87;5u` |
| ⌘. | Send Escape Sequence | `[46;5u` |
| ⌘, | Send Escape Sequence | `[44;5u` |

> **Note on ⌘W**: iTerm2's global ⌘W closes the current tab, but profile-level key mappings take precedence over global shortcuts when the terminal has focus. Adding it at profile level is safe.

#### Alacritty

Add the following to the `[keyboard] bindings` list in `~/.config/alacritty/alacritty.toml`:

```toml
{ key = "S",      mods = "Command",       chars = "\x13" },
{ key = "P",      mods = "Command",       chars = "\x10" },
{ key = "F",      mods = "Command",       chars = "\x06" },
{ key = "W",      mods = "Command",       chars = "\x17" },
{ key = "F",      mods = "Command|Shift", chars = "\x1b[70;5u" },
{ key = "V",      mods = "Command|Shift", chars = "\x1b[86;5u" },
{ key = "W",      mods = "Command|Shift", chars = "\x1b[87;5u" },
{ key = "Period", mods = "Command",       chars = "\x1b[46;5u" },
{ key = "Comma",  mods = "Command",       chars = "\x1b[44;5u" },
```

---

# 📁 File Skeleton (template) support

When you create a new file in the file explorer, NoobVim can auto-populate it with a template based on its extension.

Add a `{extension}.skeleton` file to [`lua/file-skeleton-config/skeletons/`](./lua/file-skeleton-config/skeletons/). The variable `${FILE_NAME}` will be replaced with the name of the newly created file.

---

# 🏃 Using code runner

Run your code with `<F5>`. To run a whole project, you'll first need to tell [code_runner](https://github.com/CRAG666/code_runner.nvim#add-projects) how to run it.

*NB* You'll need to be in the project's directory for this to work as expected.

---

# ❓ Miscellaneous

- Some plugins require a Nerd Font. Install one from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts).
  On macOS: `brew install --cask font-jetbrains-mono-nerd-font`
- To update all plugins: open nvim and run `:Lazy sync`
- To check plugin health: `:checkhealth`

# Maintenance
Any docs around how to maintain this can be found [here](./docs/maintenance.md)
