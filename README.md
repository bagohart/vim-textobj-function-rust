# vim-textobj-function-rust
This is a Vim plugin that adds text objects `if` (inner function) and `af` (around function) for Rust.
It extends [vim-textobj-function](https://github.com/kana/vim-textobj-function), so you need to have that installed, too.

Both textobjects seek backwards, i.e. if the cursor is between two functions, the previous function is selected.

*This plugin works, but if you use Neovim, by now you probably want to use Treesitter-derived text objects instead.*
