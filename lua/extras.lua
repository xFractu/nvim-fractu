-- 1. Líneas largas: sin salto de línea, con scroll horizontal
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("wrap: " .. tostring(vim.wo.wrap))
end, { desc = "Alternar salto de línea" })

-- texto seleccionado en visual
local function visual_text()
  vim.cmd('noau normal! "vy')
  return vim.fn.getreg("v")
end

-- 2a. Visual + Ctrl+F: busca la selección en el archivo
vim.keymap.set("x", "<C-f>", function()
  local text = visual_text()
  vim.fn.setreg("/", "\\V" .. vim.fn.escape(text, "\\"):gsub("\n", "\\n"))
  vim.opt.hlsearch = true
  vim.cmd("normal! n")
end, { desc = "Buscar selección en el archivo" })

-- 2b. Ctrl+Shift+F: busca en toda la carpeta (también <leader>sg)
local function grep_project(visual)
  local opts = {}
  if visual then
    opts.default_text = (visual_text():gsub("\n.*", ""))
  end
  require("telescope.builtin").live_grep(opts)
end
vim.keymap.set("x", "<C-S-f>", function() grep_project(true) end, { desc = "Buscar selección en el proyecto" })
vim.keymap.set("n", "<C-S-f>", function() grep_project(false) end, { desc = "Buscar en el proyecto" })
vim.keymap.set("x", "<leader>sg", function() grep_project(true) end, { desc = "Buscar selección en el proyecto" })
vim.keymap.set("n", "<leader>sg", function() grep_project(false) end, { desc = "Buscar en el proyecto" })

-- 3. Ctrl+A selecciona todo el archivo
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Seleccionar todo" })

-- alternativa con Alt+F
vim.keymap.set("x", "<M-f>", function() grep_project(true) end, { desc = "Buscar selección en el proyecto" })
vim.keymap.set("n", "<M-f>", function() grep_project(false) end, { desc = "Buscar en el proyecto" })

-- scroll horizontal con la rueda (Ctrl o Shift + rueda)
vim.opt.mouse = "a"
for _, mode in ipairs({ "n", "v", "i" }) do
  vim.keymap.set(mode, "<C-ScrollWheelDown>", "<Cmd>normal! 6zl<CR>", { desc = "Scroll a la derecha" })
  vim.keymap.set(mode, "<C-ScrollWheelUp>",   "<Cmd>normal! 6zh<CR>", { desc = "Scroll a la izquierda" })
  vim.keymap.set(mode, "<S-ScrollWheelDown>", "<Cmd>normal! 6zl<CR>", { desc = "Scroll a la derecha" })
  vim.keymap.set(mode, "<S-ScrollWheelUp>",   "<Cmd>normal! 6zh<CR>", { desc = "Scroll a la izquierda" })
end
