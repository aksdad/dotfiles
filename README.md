# History

- No more tmux for now
  - Don't have a need to SSH into boxes anymore 🤷‍♂️
- We use Wezterm

`brew bundle --file=~/Brewfile`

## Git Diff
```bash
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
```
- make sure to stow the lazygit dotfiles.

## Theme Switching (Dark/Light)

These dotfiles automatically sync with macOS system appearance (Dark/Light mode).

### Components:

1. **`get-theme`** (`dot-local/bin/get-theme`)
   - Returns "dark" or "light" based on current system appearance
   - Priority: cached value from `~/.cache/share/theme` → queries macOS directly → defaults to dark
   - Usage: `mode="--$(get-theme)"`

2. **Wezterm** (`dot-wezterm.lua`)
   - Auto-detects macOS appearance and switches between `rose-pine` (dark) and `rose-pine-dawn` (light)
   - Writes current theme to `~/.cache/share/theme` whenever config reloads

3. **Delta** (`dot-local/bin/delta-nvim`)
   - Uses `get-theme` to pass `--dark` or `--light` to delta
   - Ensures git diffs match your terminal theme

4. **Neovim**
   - Polls macOS appearance every 5 seconds via `defaults read -g AppleInterfaceStyle`
   - Syncs colorscheme automatically

### Manual stow commands:
```bash
stow --dotfiles -t ~ dot-local wezterm lazygit nvim
```

## GNU Stow
Stowing files:
```bash
stow --dotfiles -t ~ <folder name>
```

## Screenshot (old)

![screenshot](https://github.com/aksdad/dotfiles/blob/main/img/screenshot.jpg)
