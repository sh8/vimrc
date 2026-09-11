# vimrc

My private vimrc

Requires Neovim 0.12+, a C compiler, `curl`, `tar`, and the `tree-sitter` CLI
0.26.1+ on `PATH`. Tree-sitter uses the `main` branch and installs Python and
Markdown parsers automatically. Plugin updates also refresh installed parsers.

When migrating an existing installation from the old Tree-sitter `master`
branch, run `:call dein#clear_state()`, restart Neovim, let dein finish installing
the new branch, and restart once more to discard the old Lua modules and queries.
