    return {
        "npxbr/gruvbox.nvim",
        config = function()
            vim.g['gruvbox_contrast_dark'] = 'soft'
            vim.cmd [[colo gruvbox]]
        end
    }
