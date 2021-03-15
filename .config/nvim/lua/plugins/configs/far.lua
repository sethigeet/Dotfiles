vim.g["far#source"] = "rg"

vim.o.lazyredraw = true -- improve scrolling performance when navigating through large results

vim.g["far#window_width"] = 50

-- Use %:p with buffer option only
vim.g["far#file_mask_favorites"] = {
    '%:p', '**/*.*', '**/*.js', '**/*.py', '**/*.java', '**/*.css', '**/*.html',
    '**/*.vim', '**/*.cpp', '**/*.c', '**/*.h'
}
vim.g["far#window_min_content_width"] = 30
vim.g["far#enable_undo"] = 1

-- vim.g["far#ignore_files"] = {'$HOME/.config/nvim/utils/farignore'}
vim.g["far#ignore_files"] = {
    'node_modules/', 'env/', 'venv/', 'build/', 'dist/', 'target/'
}
