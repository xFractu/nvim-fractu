-- Colores de sintaxis estilo VS Code "Dark Modern" solo para HTML, CSS/SCSS y TypeScript.
-- Alterna con :DarkModern o <leader>uv. No toca neo-tree, lualine ni el resto de la interfaz.

local M = {}

local flag = vim.fn.stdpath("data") .. "/dark_modern_on"
local function enabled() return vim.uv.fs_stat(flag) ~= nil end

-- ===== COLORES (edítalos aquí) =====
local c = {
  -- HTML
  html_angle   = "#777064",
  html_tag     = "#4f91d4",
  html_attr    = "#9cdcfe",
  html_func    = "#dbd69f",
  html_paren   = "#fbce05",
  html_string  = "#c78f74",
  html_comment = "#5b9455",
  white        = "#ffffff",
  -- TypeScript
  ts_ctrl      = "#c586c0",
  ts_var       = "#92dcfe",
  ts_string    = "#ce9178",
  ts_type      = "#4fc4a0", -- NUEVO: verde agua (más azul: #4ec9b0, más verde: #4fc48a)
  ts_kw        = "#5598cd",
  ts_func      = "#dbd69f",
  ts_num       = "#adcea3",
  ts_comment   = "#5b9455",
  br1 = "#ffc60b", br2 = "#da6ece", br3 = "#179fff",
  -- CSS
  css_special  = "#5591ba",
  css_selector = "#d5aa65",
  css_prop     = "#91dcfa",
  css_num      = "#b4cca3",
  css_value    = "#c27c58",
  css_comment  = "#6a9955",
}

local TS   = { "typescript", "javascript", "tsx" }
local CSS  = { "css", "scss" }
local HTML = { "html", "angular" }

local function set(groups, langs, color, extra)
  for _, g in ipairs(groups) do
    for _, l in ipairs(langs) do
      vim.api.nvim_set_hl(0, "@" .. g .. "." .. l,
        vim.tbl_extend("force", { fg = color }, extra or {}))
    end
  end
end

function M.apply()
  if not enabled() then return end

  -- HTML
  set({ "tag.delimiter" }, HTML, c.html_angle)
  set({ "tag" }, HTML, c.html_tag)
  set({ "tag.attribute" }, HTML, c.html_attr)
  -- NUEVO: valores de atributos (incluye href/src, que Neovim trata como URL y deja grises)
  set({ "string", "string.special", "string.special.url", "markup.link.url", "markup.link" },
      HTML, c.html_string, { underline = false })
  set({ "comment" }, HTML, c.html_comment)
  set({ "operator" }, HTML, c.white)
  set({ "punctuation.bracket" }, HTML, c.html_paren)
  set({ "function", "function.call", "function.method", "function.method.call" }, { "angular" }, c.html_func)
  -- NUEVO: en plantillas de Angular, [prop], (evento), *ngIf y variables son "atributo"
  set({ "tag.attribute", "attribute", "property", "variable", "variable.member",
        "keyword", "keyword.directive" }, { "angular" }, c.html_attr)

  -- TypeScript
  set({ "keyword.import", "keyword.export", "keyword.conditional", "keyword.conditional.ternary",
        "keyword.return", "keyword.repeat", "keyword.exception", "keyword.coroutine" }, TS, c.ts_ctrl)
  set({ "keyword", "keyword.function", "keyword.modifier", "keyword.type", "keyword.operator",
        "keyword.directive", "boolean", "constant.builtin", "variable.builtin", "type.qualifier" }, TS, c.ts_kw)
  set({ "variable", "variable.parameter", "variable.member", "property" }, TS, c.ts_var)
  set({ "string", "string.escape", "string.regexp" }, TS, c.ts_string)
  set({ "type", "type.builtin", "type.definition", "attribute", "attribute.builtin", "constructor" }, TS, c.ts_type)
  set({ "function", "function.call", "function.builtin", "function.method", "function.method.call" }, TS, c.ts_func)
  set({ "number", "number.float" }, TS, c.ts_num)
  set({ "comment", "comment.documentation" }, TS, c.ts_comment)
  set({ "punctuation.bracket" }, TS, c.br1)

  -- CSS / SCSS
  set({ "attribute", "attribute.builtin" }, CSS, c.css_special)
  set({ "type", "tag" }, CSS, c.css_selector)
  set({ "property", "variable.member" }, CSS, c.css_prop)
  set({ "number", "number.float" }, CSS, c.css_num)
  set({ "string", "string.special", "constant", "constant.builtin", "variable" }, CSS, c.css_value)
  set({ "comment" }, CSS, c.css_comment)

  -- NUEVO: , ; . : ? en blanco
  set({ "punctuation.delimiter", "punctuation.special" }, TS, c.white)
  set({ "punctuation.delimiter", "punctuation.special" }, CSS, c.white)
  set({ "punctuation.delimiter" }, HTML, c.white)

  -- NUEVO: colores para las consultas propias (carpeta queries/)
  vim.api.nvim_set_hl(0, "@dm_import",       { fg = c.ts_var })
  vim.api.nvim_set_hl(0, "@dm_ts_var", { fg = c.ts_var })
  vim.api.nvim_set_hl(0, "@dm_html_string",  { fg = c.html_string, underline = false })
  vim.api.nvim_set_hl(0, "@dm_css_selector", { fg = c.css_selector })
  vim.api.nvim_set_hl(0, "@dm_css_value",    { fg = c.css_value })
  vim.api.nvim_set_hl(0, "@dm_css_prop",     { fg = c.css_prop })
  vim.api.nvim_set_hl(0, "@dm_css_num",      { fg = c.css_num })

  -- llaves, corchetes y paréntesis por nivel
  vim.api.nvim_set_hl(0, "DMBracket1", { fg = c.br1 })
  vim.api.nvim_set_hl(0, "DMBracket2", { fg = c.br2 })
  vim.api.nvim_set_hl(0, "DMBracket3", { fg = c.br3 })
end

function M.toggle()
  if enabled() then
    vim.uv.fs_unlink(flag)
    package.loaded["matugen"] = nil
    pcall(function() require("matugen").setup() end)
    vim.notify("Dark Modern: apagado")
  else
    local f = io.open(flag, "w")
    if f then f:close() end
    vim.notify("Dark Modern: encendido")
  end
  vim.api.nvim_exec_autocmds("ColorScheme", {})
end

local aug = vim.api.nvim_create_augroup("DarkModern", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = aug,
  callback = function() vim.schedule(M.apply) end,
})
vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and enabled() then client.server_capabilities.semanticTokensProvider = nil end
  end,
})

vim.api.nvim_create_user_command("DarkModern", M.toggle, {})
vim.keymap.set("n", "<leader>uv", M.toggle, { desc = "Alternar colores Dark Modern" })

vim.schedule(M.apply)
return M
