{ ... }:
{
  programs.nixvim = {
    enable = true;
    vimAlias = true;

    colorschemes.catppuccin.enable = true;
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    plugins = {
      web-devicons.enable = true;
      telescope.enable = true;
      bufferline.enable = true;
      lualine.enable = true;
      treesitter.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = false;

        settings = {
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<C-Space>" = "cmp.mapping.complete()";
          };
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };
      aerial.enable = true;
      cmp-nvim-lsp.enable = true;
      chadtree.enable = true;
      which-key.enable = true;
      spider.enable = true;
      leap.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            python = [
              "ruff_format"
              "ruff_fix"
              "ruff_organize_imports"
            ];
          };

          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
        };
      };
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          lua_ls.enable = true;
          nil_ls.enable = true;
          ruff.enable = true;
          pyright.enable = true;
        };
      };
      diagnostic.settings = {
        underline = true;
        update_in_insert = false;
        severity_sort = true;

        virtual_text = {
          spacing = 4;
          source = "if_many";
          prefix = " ●";
        };

        signs = {
          text = {
            "__rawKey__vim.diagnostic.severity.ERROR" = " ";
            "__rawKey__vim.diagnostic.severity.WARN" = " ";
            "__rawKey__vim.diagnostic.severity.HINT" = " ";
            "__rawKey__vim.diagnostic.severity.INFO" = " ";
          };

          texthl = {
            "__rawKey__vim.diagnostic.severity.ERROR" = "DiagnosticError";
            "__rawKey__vim.diagnostic.severity.WARN" = "DiagnosticWarn";
            "__rawKey__vim.diagnostic.severity.HINT" = "DiagnosticHint";
            "__rawKey__vim.diagnostic.severity.INFO" = "DiagnosticInfo";
          };
        };
      };

    };

    keymaps = [
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>CHADopen<cr>";
      }
      {
        mode = "n";
        key = "<esc>";
        action = "<cmd>noh<cr><esc>";
      }
      {
        mode = "n";
        key = "{";
        action = "<cmd>AerialPrev<CR>";
      }
      {
        mode = "n";
        key = "}";
        action = "<cmd>AerialNext<CR>";
      }
      {
        mode = "n";
        key = "<leader>a";
        action = "<cmd>AerialToggle!<CR>";
      }
      {
        mode = "i";
        key = "jk";
        action = "<esc>";
      }
      # Move to left split
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
      }
      # Move to down split
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
      }
      # Move to up split
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }
      # Move to right split
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>";
      }
      {
        mode = "n";
        key = "<Tab>";
        action = ":bnext<CR>";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = ":bprevious<CR>";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = ":bd<CR>";
      }
    ];

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      undofile = true;
    };

    autocmds = [
      {
        event = "BufWritePre";
        pattern = "*.py";
        command = "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } } })<CR> | silent !ruff --fix %<CR>";
      }
      {
        event = "FileType";
        pattern = [
          "tex"
          "latex"
          "markdown"
        ];
        command = "setlocal spell spelllang=en_us";
      }
      {
        event = [
          "FocusGained"
          "BufEnter"
          "CursorHold"
          "CursorHoldI"
        ];
        pattern = "*";
        command = "if mode() != 'c' | checktime | endif";
      }
    ];

  };
}
