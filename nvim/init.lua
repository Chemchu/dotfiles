local function source_pre_config(vim)
    local core_config_files = {
        "packer_init.lua",
        "mappings.lua",
    }

    for _, name in ipairs(core_config_files) do
        local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
        local source_cmd = "source " .. path
        vim.cmd(source_cmd)
    end
end

local function source_client(vim, client_name)
    local path = string.format("%s/client/%s", vim.fn.stdpath("config"), client_name)
    local source_cmd = "source " .. path
    vim.cmd(source_cmd)
end

local function source_post_config(vim)
    local after_core_config_files = {
        "post_mappings.lua",
    }

    for _, name in ipairs(after_core_config_files) do
        local path = string.format("%s/core/after/%s", vim.fn.stdpath("config"), name)
        local source_cmd = "source " .. path
        vim.cmd(source_cmd)
    end
end

local function main(vim)
    -- Source los mappings básicos y la instalación de packer
    source_pre_config(vim)

    if vim.g.vscode then
        -- Carga las dependencias y pluggings si se usa VSCode
        source_client(vim, "vscode.lua")
    else
        -- Carga las dependencias normales de NeoVim
        source_client(vim, "nvim.lua")
    end

    -- Carga las configuraciones finales de NeoVim 
    source_post_config(vim)
end

-- Arranque de la aplicación
main(vim)