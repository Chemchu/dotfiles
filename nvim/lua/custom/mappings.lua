local M = {}

M.arrow_keys = {
  n = {
    ["<Up>"] = {"<Nop>", "Up arrow disabled"},
    ["<Down>"] = {"<Nop>", "Down arrow disabled"},
    ["<Left>"] = {"<Nop>", "Left arrow disabled"},
    ["<Right>"] = {"<Nop>", "Right arrow disabled"},
  },
  v = {
    ["<Up>"] = {"<Nop>", "Up arrow disabled"},
    ["<Down>"] = {"<Nop>", "Down arrow disabled"},
    ["<Left>"] = {"<Nop>", "Left arrow disabled"},
    ["<Right>"] = {"<Nop>", "Right arrow disabled"},
  },
  i = {
    ["<Up>"] = {"<Nop>", "Up arrow disabled"},
    ["<Down>"] = {"<Nop>", "Down arrow disabled"},
    ["<Left>"] = {"<Nop>", "Left arrow disabled"},
    ["<Right>"] = {"<Nop>", "Right arrow disabled"},
  },
  x = {
    ["<Up>"] = {"<Nop>", "Up arrow disabled"},
    ["<Down>"] = {"<Nop>", "Down arrow disabled"},
    ["<Left>"] = {"<Nop>", "Left arrow disabled"},
    ["<Right>"] = {"<Nop>", "Right arrow disabled"},
  },
}

M.quality_of_life = {
  n = {
    ["<C-d>"] = {"<C-d>zz", "Center screen when jumping down"},
    ["<C-u>"] = {"<C-u>zz", "Center screen when jumping up"},
    ["n"] = {"nzzzv", "Center screen when jumping forward"},
    ["N"] = {"Nzzzv", "Center screen when jumping backwards"},
    ["U"] = {"<C-r>", "Redo"},
  },
  v = {
    ["J"] = {": m '>+1<CR>gv=gv", "Move selection up"},
    ["K"] = {": m '<-2<CR>gv=gv", "Move selection down"}
  },
  x = {
    ["<leader>p"] = {"\"_dp", "Non-overriding paste"}
  }
}

M.surroundings = {
  n = {
    ["<leader>sd\""] = {"yi\"va\"p", "Remove the nearest double quotes"},
    ["<leader>sd("] = {"yi(va(p", "Remove the nearest parenthesis"},
    ["<leader>sd{"] = {"yi{va{p", "Removethe nearest llaves"},
    ["<leader>sd["] = {"yi[va[p", "Remove the nearest corchetes"},
    ["<leader>sd'"] = {"yi'va'p", "Remove the nearest single quotes"},
    ["sd\""] = {"yi\"va\"p", "Remove the nearest double quotes"},
    ["sd("] = {"yi(va(p", "Remove the nearest parenthesis"},
    ["sd{"] = {"yi{va{p", "Removethe nearest llaves"},
    ["sd["] = {"yi[va[p", "Remove the nearest corchetes"},
    ["sd'"] = {"yi'va'p", "Remove the nearest single quotes"},
  },
  v = {
    ["<leader>sa\""] = {"oc\"<C-r>\"\"", "Add double quotes to the selected text"},
    ["<leader>sa("] = {"oc(<C-r>\")", "Add parenthesis to the selected text"},
    ["<leader>sa{"] = {"oc{<C-r>\"}", "Add llaves to the selected text"},
    ["<leader>sa["] = {"oc[<C-r>\"]", "Add corchetes to the selected text"},
    ["<leader>sa'"] = {"oc'<C-r>\"'", "Add single quotes to the selected text"}
  }
}

return M
