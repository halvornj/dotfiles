return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = function() require('nvim-treesitter').update() end,
    config = function()
      require('nvim-treesitter').install({
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      })

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local move = require('nvim-treesitter-textobjects.move')
      local function map(lhs, fn, query)
        vim.keymap.set({ 'n', 'x', 'o' }, lhs, function() fn(query, 'textobjects') end)
      end

      map(']f', move.goto_next_start,     '@function.outer')
      map(']c', move.goto_next_start,     '@class.outer')
      map(']a', move.goto_next_start,     '@parameter.inner')
      map(']F', move.goto_next_end,       '@function.outer')
      map(']C', move.goto_next_end,       '@class.outer')
      map(']A', move.goto_next_end,       '@parameter.inner')
      map('[f', move.goto_previous_start, '@function.outer')
      map('[c', move.goto_previous_start, '@class.outer')
      map('[a', move.goto_previous_start, '@parameter.inner')
      map('[F', move.goto_previous_end,   '@function.outer')
      map('[C', move.goto_previous_end,   '@class.outer')
      map('[A', move.goto_previous_end,   '@parameter.inner')
    end,
  },
}
