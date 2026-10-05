local f = vim.fn.expand("~/.config/theme/nvim-colorscheme")

local function apply()
  local ok, lines = pcall(vim.fn.readfile, f)
  if ok and lines[1] and lines[1] ~= "" then
    pcall(vim.cmd.colorscheme, lines[1])
  end
end

vim.api.nvim_create_autocmd("VimEnter", { callback = apply })

local w = vim.uv.new_fs_event()
if w then
  w:start(f, {}, vim.schedule_wrap(apply))
end
