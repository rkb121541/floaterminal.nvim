# floaterminal.nvim

A simple floating terminal plugin for Neovim based on this [video](https://youtu.be/5PIiKDES_wc?si=NAfHfKuKz-IjBLEb).

![](screenshot.png)

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
    "rkb121541/floaterminal.nvim",
    config = function()
        require("floaterminal").setup()
    end,
}
```