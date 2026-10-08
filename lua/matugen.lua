local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Fondos
    base00 = '#000000',
    base01 = '#0a0b0b',
    base02 = '#161717',
    base03 = '#6d6d6d',
    -- Textos
    base04 = '#909090',
    base05 = '#828282',
    base06 = '#828282',
    base07 = '#828282',
    -- Acentos
    base08 = '#dddddd',
    base09 = '#999999',
    base0A = '#939393',
    base0B = '#b7b7b7',
    base0C = '#e99696',
    base0D = '#e99696',
    base0E = '#e99696',
    base0F = '#967171',
  }
end

-- recarga en caliente cuando Noctalia manda SIGUSR1
local signal = vim.uv.new_signal()
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
