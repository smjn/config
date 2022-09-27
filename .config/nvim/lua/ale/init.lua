vim.cmd [[
    let g:ale_linters = {'python': ['flake8', 'pydocstyle'], 'sh': ['shellcheck'], 'zsh': ['shellcheck'], 'lua': ['luacheck'], 'c': ['cpplint'], 'cpp': ['cpplint']} 
    let g:ale_fixers = {'*': [], 'python': ['black', 'isort'], 'sh': ['shfmt'], 'zsh': ['shfmt'], 'lua': ['lua-format'], 'c': ['clang-format'], 'cpp': ['clang-format']}
    let g:ale_fix_on_save = 1
]]
