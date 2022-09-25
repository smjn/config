vim.cmd([[
    let g:ale_linters = {'python': ['flake8', 'pydocstyle'], 'sh': ['shellcheck']} 
    let g:ale_fixers = {'*': [], 'python': ['black', 'isort'], 'sh': ['shfmt']}
    let g:ale_fix_on_save = 1
]])
