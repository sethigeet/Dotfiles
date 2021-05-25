local wordlist_file_path = DATA_PATH .. "/wordlist_en.txt"

if vim.fn.filereadable(vim.fn.expand(wordlist_file_path)) ~= 1 then
    vim.fn.echoerr("the wordlist file (" .. wordlist_file_path ..
                       ") does not exist! Please download it and put it in the right place")
else
    vim.cmd("set dictionary=" .. wordlist_file_path)
end
