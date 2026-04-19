vim howtos and rc hints

# scroll vim document on macOS trackpad
To scroll document in Vim using two-finger trackpad scrolling. Trackpad scrolling stays in Vim and moves through the file from top to bottom instead of scrolling terminal output/history.

## iTerm2:
Preferences > Advanced > Mouse
Scroll wheel sends arrow keys when in alternate screen mode = Yes

## tmux:
~/.tmux.conf
set -g mouse on


## Vim:
~/.vim_runtime/my_configs.vim
set mouse=a

