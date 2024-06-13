{pkgs, inputs, ...}:

{
  home.packages = with pkgs;
    [
      texlab
      nixd
      typst-lsp
      ltex-ls
    ];
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim 
  ];
  nixpkgs.overlays = [
    inputs.nixneovimplugins.overlays.default
  ];

  
  programs.sioyek = {
    enable = true;
    bindings = {
      "move_up" = "k";
      "move_down" = "j";
      "move_left" = "h";
      "move_right" = "l";
      "screen_down" = "<C-j>";
      "screen_up" = "<C-k>";
    };
  };

  programs.nixvim = {
    enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      yuck-vim
      vim-javascript
      pkgs.vimExtraPlugins.telescope-bibtex-nvim
    ];

    plugins = {
      typst-vim = {
        enable = true;
        settings = {
          pdf_viewer = "sioyek";
        };
      };
      lsp = {
        enable = true;
        servers = {
          ltex = {
            enable = true;
            settings = {
              language = "en-AU";
              completionEnabled = true;
            };
          };
          nixd = {
            enable = true;
          };
        };
      };


      lightline.enable = true;
      treesitter.enable = true;
      parinfer-rust = {
        enable = true;
        settings = {
          mode = "smart";
          force_balance = true;
        };
      };
      coq-nvim = {
        enable = true;
        settings = {
          auto_start = true;
        };
      };
      vimtex = {
        enable = true;
        settings = {
          view_general_viewer = "sioyek";
        };
        texlivePackage = pkgs.texlive.combined.scheme-full;
      };

      telescope = {
	enable = true;
	settings = {
	  pickers = {
	    find_files.hidden = false;
	  };
	  extensions = {
	    bibtex = {
	      depth = 1;
              custom_formats = [
                {
                  id = "tex"; 
                  cite_marker = "\\parencite{%s}";
                }
              ];
	      context_fallback = true;
	    };
	  };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        options.silent = true;
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>ref";
        options.silent = true;
        action = "<cmd>Telescope bibtex<CR>";
      }
    ];

    globals = {
      mapleader = "\\";
      maplocalleader = "\\";

    };

    opts = {
      number = true;
      relativenumber = true;
      syntax = "on";

      shiftwidth = 2;
    };
      

    extraConfigLua = ''
      vim.g['tex_flavour'] = 'latex'
      require"telescope".load_extension("bibtex")
    '';

  };
}
