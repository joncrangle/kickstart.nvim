return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', cmd = 'Mason', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      { 'saghen/blink.cmp' },

      { 'b0o/schemastore.nvim',    lazy = true,   opts = nil },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('ge', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Open [E]rror in Float')

          map('<leader>ci', function()
            vim.lsp.buf.code_action {
              apply = true,
              context = {
                only = { 'source.organizeImports' },
                diagnostics = {},
              },
            }
          end, 'LSP Organize [I]mports')

          if vim.bo.filetype == 'typescriptreact' then
            map('<leader>cI', function()
              vim.lsp.buf.code_action {
                apply = true,
                context = {
                  ---@diagnostic disable-next-line: assign-type-mismatch
                  only = { 'source.addMissingImports.ts' },
                  diagnostics = {},
                },
              }
            end, 'LSP Add Missing [I]mport')
          end
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following command is used to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>ti", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle [I]nlay Hints")
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, nvim-snippets, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        astro = {},
        basedpyright = {
          enabled = true,
          settings = {
            disableOrganizeImports = true,
            basedpyright = {
              analysis = {
                typeCheckingMode = 'standard',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
              },
            },
          },
        },
        bashls = {},
        biome = {},
        clangd = {},
        cssls = {},
        docker_compose_language_service = {},
        dockerls = {},
        eslint = {},
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = true,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            version = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            fieldalignment = true,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
          semanticTokens = true,
        },
        harper_ls = {
          filetypes = { "markdown" },
        },
        html = {},
        jqls = {},
        jsonls = {
          -- Lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              hint = {
                enable = true,
              },
              codeLens = {
                enable = true,
              },
              doc = {
                privateName = { '^_' },
              },
            },
          },
        },
        marksman = {},
        mdx_analyzer = {},
        ruff = {},
        svelte = {},
        tailwindcss = {
          filetypes_exclude = { 'markdown' },
          filetypes_include = {},
        },
        -- ts_ls = {},
        templ = {},
        vtsls = {
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {},
              require('schemastore').yaml.schemas())
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = '',
              },
            },
          },
        },
        zls = {},
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'codelldb',
        'delve',
        'goimports',
        'goimports-reviser',
        'gofumpt',
        'golines',
        'gomodifytags',
        'impl',
        'markdownlint-cli2',
        'markdown-toc',
        'prettier',
        'prettierd',
        'shellharden',
        'shfmt',
        'sqlfluff',
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    ft = { 'rust' },
    opts = {
      tools = { float_win_config = { border = 'rounded' } },
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>dr', function()
            vim.cmd.RustLsp('debuggables')
          end, { desc = 'Rust Debuggables', buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable('rust-analyzer') == 0 then
        vim.notify('rust-analyzer not found in PATH, please install it.\nhttps://rust-analyzer.github.io/',
          vim.log.levels.ERROR, { title = 'rustaceanvim' })
      end
    end,
  },
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      lsp = {
        enabled = true,
        ---@diagnostic disable-next-line: unused-local
        on_attach = function(client, bufnr)
        end,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    'vuki656/package-info.nvim',
    event = { 'BufRead package.json' },
    opts = {
      colors = {
        up_to_date = '#a6e3a1',
        outdated = '#f9e2af',
        invalid = '#f38ba8',
      },
      package_manager = 'pnpm',
    },
    config = function(_, opts)
      require('package-info').setup(opts)
      vim.cmd([[highlight PackageInfoUpToDateVersion guifg=]] .. opts.colors.up_to_date)
      vim.cmd([[highlight PackageInfoOutdatedVersion guifg=]] .. opts.colors.outdated)
      vim.cmd([[highlight PackageInfoInErrorVersion guifg=]] .. opts.colors.invalid)
    end,
  },
  {
    'zeioth/garbage-day.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    event = 'LspAttach',
    opts = {
      notifications = true,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
