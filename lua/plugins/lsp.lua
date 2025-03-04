local lspconfig = require('lspconfig') 

lspconfig.golangci_lint_ls.setup{}
lspconfig.cmake.setup{}
lspconfig.clangd.setup{}
lspconfig.pylsp.setup{}
