return {
  lsp = {
    formatting = {
      filter = function(client)
        -- only enable null-ls for javascript files
        if vim.bo.filetype == "javascript" then
          return client.name == "null-ls"
        end

        if vim.bo.filetype == "typescript" then
          return client.name == "null-ls"
        end

        -- enable all other clients
        return true
      end
    },
  },
  plugins = {
    {
      "jay-babu/mason-null-ls.nvim",
      opts = {
        handlers = {
          -- for prettier
          prettier = function()
            require("null-ls").register(require("null-ls").builtins.formatting.prettier.with {
              condition = function(utils)
                return utils.root_has_file "package.json"
                  or utils.root_has_file ".prettierrc"
                  or utils.root_has_file ".prettierrc.json"
                  or utils.root_has_file ".prettierrc.js"
              end,
            })
          end,
          -- for prettierd
          prettierd = function()
            require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
              condition = function(utils)
                return utils.root_has_file "package.json"
                  or utils.root_has_file ".prettierrc"
                  or utils.root_has_file ".prettierrc.json"
                  or utils.root_has_file ".prettierrc.js"
              end,
            })
          end,
          -- For eslint_d:
          eslint_d = function()
            require("null-ls").register(require("null-ls").builtins.diagnostics.eslint_d.with {
              condition = function(utils)
                return utils.root_has_file "package.json"
                  or utils.root_has_file ".eslintrc.json"
                  or utils.root_has_file ".eslintrc.js"
              end,
            })
          end,
        },
      },
    },
  },
}
