# History

Install [GNU Stow](https://www.gnu.org/software/stow/)
`brew install stow`

Install [tmux](https://github.com/tmux/tmux/wiki)
`brew install tmux`

Install [nvim](https://neovim.io)
`brew install neovim`

Install [starship](https://starship.rs)
`brew install starship`

Installed [tmux plugin manager](https://github.com/tmux-plugins/tpm)
`brew install tpm`
`echo "run '/opt/homebrew/opt/tpm/share/tpm/tpm'" >> ~/.tmux.conf`

Installed [tmux tokyonight](https://github.com/janoamaral/tokyo-night-tmux)
Install deps for tmux tokyonight
`brew install --cask font-noto-sans-symbols-2`
`brew install bash bc coreutils gawk gh glab gsed jq nowplaying-cli`
`echo 'set -g @plugin "janoamaral/tokyo-night-tmux"' >> ~/.tmux.conf`

Added gnu sed to PATH
`echo 'export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"' >> ~/.zshrc`
`npm install -g markdownlint-cli`
`npm install --save-dev markdownlint-cli`

## Screenshot

![screenshot](https://github.com/aksdad/dotfiles/blob/main/img/screenshot.jpg)
