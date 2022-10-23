vim.g.ale_linters = {
    python = {'flake8', 'pydocstyle'},
    sh = {'shellcheck'},
    zsh = {'shellcheck'},
    lua = {'luacheck'},
    c = {'cpplint'},
    cpp = {'cpplint'},
    javascript = {'jshint'},
    js = {'jshint'}
}

vim.g.ale_fixers = {
    ['*'] = {},
    python = {'black', 'isort'},
    sh = {'shfmt'},
    zsh = {'shfmt'},
    lua = {'lua-format'},
    c = {'clang-format'},
    cpp = {'clang-format'},
    javascript = {'prettier'},
    js = {'prettier'},
    haskell = {'stylish-haskell'}
}

vim.g.ale_fix_on_save = 1
vim.g.ale_linters_explicit = 1
