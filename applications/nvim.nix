{pkgs, inputs, ...}:

{
  home.packages = with pkgs;
    [
      texlab
      nixd
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
      pkgs.vimExtraPlugins.telescope-bibtex-nvim
      pkgs.vimExtraPlugins.nvim-lspconfig
    ];

    plugins = {
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
                  cite_marker = "\parencite{%s}";
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
      require"telescope".load_extension("bibtex")
      require'lspconfig'.nixd.setup{}
      require'lspconfig'.texlab.setup{}
    '';

  };
}
