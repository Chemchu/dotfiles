-- Lineas relativas
vim.opt.relativenumber = true

-- Ajustes de longitud del TAB
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Sirve para mover bloques arriba y abajo
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move selection up"
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move selection down"
})
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Mantener cursor en medio cuando se mueve
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Redo
vim.keymap.set("n", "U", "<C-r>")

-- Desabilitar las flechas del teclado
vim.keymap.set({ "n", "v", "i" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<Down>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<Right>", "<Nop>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true
})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true
})

-- Añadir ()""''{}[] al texto seleccionado visualmente
vim.keymap.set({ "n", "v" }, "<leader>s", function()
end, {
    desc = "Funciones [S]urroundings"
})

vim.keymap.set({ "n", "v" }, "<leader>sa", function()
end, {
    desc = "Añadir [S]urroundings (Visual mode only)"
})
vim.keymap.set("v", "<leader>sa\"", "oc\"<C-r>\"\"", {
    desc = "Añade comillas al texto seleccionado"
})
vim.keymap.set("v", "<leader>sa(", "oc(<C-r>\")", {
    desc = "Añade paréntesis al texto seleccionado"
})
vim.keymap.set("v", "<leader>sa{", "oc{<C-r>\"}", {
    desc = "Añade llaves al texto seleccionado"
})
vim.keymap.set("v", "<leader>sa[", "oc[<C-r>\"]", {
    desc = "Añade corchetes al texto seleccionado"
})
vim.keymap.set("v", "<leader>sa'", "oc'<C-r>\"'", {
    desc = "Añade comillas simples al texto seleccionado"
})

vim.keymap.set({ "n", "v" }, "sa", function()
end, {
    desc = "Añadir [S]urroundings (Visual mode only)"
})
vim.keymap.set("v", "sa\"", "oc\"<C-r>\"\"", {
    desc = "Añade comillas al texto seleccionado"
})
vim.keymap.set("v", "sa(", "oc(<C-r>\")", {
    desc = "Añade paréntesis al texto seleccionado"
})
vim.keymap.set("v", "sa{", "oc{<C-r>\"}", {
    desc = "Añade llaves al texto seleccionado"
})
vim.keymap.set("v", "sa[", "oc[<C-r>\"]", {
    desc = "Añade corchetes al texto seleccionado"
})
vim.keymap.set("v", "sa'", "oc'<C-r>\"'", {
    desc = "Añade comillas simples al texto seleccionado"
})

-- Elimina ()""''{}[] al texto seleccionado visualmente
vim.keymap.set({ "n", "v" }, "<leader>sd", function()
end, {
    desc = "Eliminar [S]urroundings"
})
vim.keymap.set("n", "<leader>sd\"", "yi\"va\"p", {
    desc = "Eliminar las comillas"
})
vim.keymap.set("n", "<leader>sd(", "yi(va(p", {
    desc = "Eliminar los paréntesis"
})
vim.keymap.set("n", "<leader>sd{", "yi{va{p", {
    desc = "Eliminar las llaves"
})
vim.keymap.set("n", "<leader>sd[", "yi[va[p", {
    desc = "Eliminar los corchetes"
})
vim.keymap.set("n", "<leader>sd'", "yi'va'p", {
    desc = "Eliminar las comillas"
})

vim.keymap.set("n", "sd\"", "yi\"va\"p", {
    desc = "Eliminar las comillas"
})
vim.keymap.set("n", "sd(", "yi(va(p", {
    desc = "Eliminar los paréntesis"
})
vim.keymap.set("n", "sd{", "yi{va{p", {
    desc = "Eliminar las llaves"
})
vim.keymap.set("n", "sd[", "yi[va[p", {
    desc = "Eliminar los corchetes"
})
vim.keymap.set("n", "sd'", "yi'va'p", {
    desc = "Eliminar las comillas"
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('yankhighlight', {
        clear = true
    })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*'
})
