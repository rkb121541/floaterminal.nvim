local M = {}

M.config = {
  width = 0.8,
  height = 0.8,
  keymap = "<leader>tt",
}

function M.setup(user_opts)
  user_opts = user_opts or {}
  for k, v in pairs(user_opts) do
    if M.config[k] ~= nil then -- to make sure the user doesn't put something thats not in M.config
      M.config[k] = v
    else
      vim.notify(
        string.format("[floaterminal.nvim] Invalid option: '%s'", k),
        vim.log.levels.ERROR
      )
    end
  end
  vim.keymap.set({"n", "t"}, M.config.keymap, function()
    M.toggle_terminal()
  end, {})
end

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window()
  local width = math.floor(vim.o.columns * M.config.width)
  local height = math.floor(vim.o.lines * M.config.height)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf
  if vim.api.nvim_buf_is_valid(state.floating.buf) then
    buf = state.floating.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal")
  local float_border = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
  local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).background
  vim.api.nvim_set_hl(0, "FloatBorder", {
    fg = float_border.fg,
    bg = normal_bg
  })

  return { buf = buf, win = win }
end

function M.toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window()
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

return M
