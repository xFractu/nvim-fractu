local M = {}

-- fondo y texto de la paleta activa
local bg = '#141414'
local fg = '#e6e6e6'

-- proporción de mezcla fondo -> texto (0 = fondo, 1 = texto)
local L = {
  variables  = 0.92, -- variables, etiquetas
  constantes = 0.74, -- números, constantes
  tipos      = 0.96, -- clases, tipos
  strings    = 0.80, -- textos entre comillas
  especiales = 0.70, -- regex, escapes
  funciones  = 0.98, -- funciones, métodos
  keywords   = 0.20, -- return, function, if
  delimitad  = 0.15, -- {}, (), []
}

local function rgb(h)
  h = h:gsub('#', '')
  return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
end

local function mix(t)
  local ar, ag, ab = rgb(bg)
  local br, bgc, bb = rgb(fg)
  return string.format('#%02x%02x%02x',
    math.floor(ar + (br - ar) * t + 0.5),
    math.floor(ag + (bgc - ag) * t + 0.5),
    math.floor(ab + (bb - ab) * t + 0.5))
end

function M.setup()
  require('base16-colorscheme').setup {
    -- Fondos
    base00 = '#141414',
    base01 = '#1f1f1f',
    base02 = '#2a2a2a',
    base03 = '#626262',
    -- Textos
    base04 = '#b0b0b0',
    base05 = '#ffffff',
    base06 = '#ffffff',
    base07 = '#ffffff',
    -- Sintaxis: escala de grises
    base08 = mix(L.variables),
    base09 = mix(L.constantes),
    base0A = mix(L.tipos),
    base0B = mix(L.strings),
    base0C = mix(L.especiales),
    base0D = mix(L.funciones),
    base0E = '#000000',
    base0F = '#0a0a0a',
  }
end

-- recarga en caliente cuando Noctalia manda SIGUSR1
local signal = vim.uv.new_signal()
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
    vim.api.nvim_exec_autocmds('ColorScheme', {})
  end)
)

return M
