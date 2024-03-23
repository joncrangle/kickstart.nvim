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
      function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd 'DiffviewOpen'
        else
          vim.cmd 'tabclose'
        end
      end,
      desc = 'Toggle [D]iffview',
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
