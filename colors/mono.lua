vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.termguicolors = true
vim.g.colors_name = "mono"

local c = {
  fg = "#e8e8e8", bright = "#ffffff", mid = "#a8a8a8", dim = "#6b6b6b",
  faint = "#2e2e2e", surf = "#1c1c1c", sel = "#3a3a3a",
}
local function hi(g, o) vim.api.nvim_set_hl(0, g, o) end

hi("Normal",       { fg = c.fg, bg = "NONE" })
hi("NormalFloat",  { fg = c.fg, bg = c.surf })
hi("FloatBorder",  { fg = c.dim, bg = c.surf })
hi("Comment",      { fg = c.dim, italic = true })
hi("Constant",     { fg = "#c4c4c4" })
hi("String",       { fg = "#bcbcbc" })
hi("Identifier",   { fg = c.fg })
hi("Function",     { fg = c.bright, bold = true })
hi("Statement",    { fg = c.mid, bold = true })
hi("Operator",     { fg = c.mid })
hi("PreProc",      { fg = "#9a9a9a" })
hi("Type",         { fg = "#d8d8d8", italic = true })
hi("Special",      { fg = "#c4c4c4" })
hi("LineNr",       { fg = c.dim })
hi("CursorLine",   { bg = c.surf })
hi("CursorLineNr", { fg = c.bright, bold = true })
hi("Visual",       { bg = c.sel })
hi("Search",       { fg = "#0d0d0d", bg = "#c4c4c4" })
hi("IncSearch",    { fg = "#0d0d0d", bg = "#ffffff" })
hi("Pmenu",        { fg = c.fg, bg = c.surf })
hi("PmenuSel",     { fg = c.bright, bg = c.sel })
hi("StatusLine",   { fg = c.fg, bg = c.surf })
hi("StatusLineNC", { fg = c.dim, bg = c.surf })
hi("WinSeparator", { fg = c.faint })
hi("VertSplit",    { fg = c.faint })
hi("Directory",    { fg = "#d0d0d0", bold = true })
hi("Error",        { fg = c.bright, bold = true })
hi("DiagnosticError", { fg = c.bright })
hi("DiagnosticWarn",  { fg = "#c4c4c4" })
hi("DiagnosticInfo",  { fg = "#a8a8a8" })
hi("DiagnosticHint",  { fg = c.dim })
