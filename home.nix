# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 
{
  # You can import other home-manager modules here
  imports = [
  	./hyprland.nix
	./ranger.nix
	./eww.nix
	./nvim.nix
  ];
	  home = {
	    username = "lachlan";
	    homeDirectory = "/home/lachlan";
	    pointerCursor = {
		gtk.enable = true;
		name = "Vulpix";
		package = inputs.vulpix.packages.${pkgs.system}.vulpix;
		size = 24;
		};
	};
  	gtk = {
		enable = true;
		cursorTheme = {
			name = "Vulpix";
			size = 24;
		};
		iconTheme = {
			package = pkgs.papirus-icon-theme;
			name = "Papirus-Dark";
		};
		theme = {
			package = pkgs.orchis-theme;
			#package = (pkgs.callPackage ./breeze-gtk {});
			name = "Orchis-Orange-Dark";
		};
		font = {
			name = "Sans";
			size = 11;
		};
	};
	qt = {
		enable = true;
		platformTheme = {
			name = "kde";
		};
		#style = {
		#	package = pkgs.orchis-theme;
		#	name = "orchis-orange-compat-dark";
		#};
	};


	

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.papis = {
  	enable = true;
	libraries = {
		Default = {
			isDefault = true;
			name = "Default";
			settings = {
				dir = "~/assignments/Documents/Papers";
			};
		};
	};
	settings = {
		editor = "nvim";
		file-browser = "ranger";
		match-format = "{doc[tags]}{doc.subfolder}{doc[title]}{doc[author]}{doc[year]}";
		header-format = "<red>{doc.html_escape[title]}</red>
  <span color='#ff00ff'>  {doc.html_escape[author]}</span>
  <yellow>   ({doc.html_escape[year]})</yellow>";
		add-folder-name = "{doc[title]} {doc[author]}";
		add-file-name = "{doc[title]} {doc[author]}";
	
	};
};
	
  

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
