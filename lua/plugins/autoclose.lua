return {
  {
    -- Cierra solo los pares: () [] {} "" ''
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      -- Al aceptar una función del autocompletado, agrega los paréntesis
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    -- Escribes <div> y aparece </div>; si renombras una etiqueta, renombra la otra
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
