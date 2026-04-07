-- vim-visual-multi keymaps (plugin sets up itself on load)
local map = vim.keymap.set
map("n", "<leader>ma", "<Plug>(VM-Select-All)<Tab>", { desc = "Select All" })
map("n", "<leader>mr", "<Plug>(VM-Start-Regex-Search)", { desc = "Start Regex Search" })
map("n", "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", { desc = "Add Cursor At Pos" })
map("n", "<leader>mo", "<Plug>(VM-Toggle-Mappings)", { desc = "Toggle Mapping" })
