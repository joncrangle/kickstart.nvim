-- in ~/.gitconfig, add:
--[[ [merge]
  tool = diffview
[mergetool]
  prompt = false
  keepBackup = false
[mergetool "diffview"]
  cmd = nvim -n -c "DiffviewOpen" "$MERGE" ]]

return {
  'sindrets/diffview.nvim',
  opts = {},
  keys = {
    {
      '<leader>gd',
      '<cmd>DiffviewOpen<cr>',
      desc = 'Open [D]iffview',
    },
  },
}
