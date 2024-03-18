    return {
        'hoob3rt/lualine.nvim',
        config = function()
          require('lualine').setup{
            options = {
              theme = 'gruvbox',
              section_separators = {'', ''},
              component_separators = {'', ''},
              icons_enabled = true,
            },
            sections = {
              lualine_a = { {'mode', upper = true} },
              lualine_b = { {'branch', icon = ''} },
              lualine_c = { {'filename', file_status = true}, { 'diagnostics', sources = { 'coc' } } },
              lualine_x = { 'encoding', 'fileformat', 'filetype' },
              lualine_y = { 'progress' },
              lualine_z = { 'location'  },
            },
            inactive_sections = {
              lualine_a = {  },
              lualine_b = {  },
              lualine_c = { 'filename' },
              lualine_x = { 'location' },
              lualine_y = {  },
              lualine_z = {   }
            },
            extensions = { 'fugitive' }
        }
      end
    }
