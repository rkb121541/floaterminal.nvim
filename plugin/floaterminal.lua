vim.api.nvim_create_user_command("Floaterminal", function()
  require("floaterminal").toggle_terminal()
end, {})

vim.keymap.set({"n", "t"}, "<leader>tt", function()
  require("floaterminal").toggle_terminal()
end)

vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
