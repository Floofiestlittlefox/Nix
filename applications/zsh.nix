{pkgs, lib, config, ...}:

{
	home.packages = [

	];
	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.zsh= {
		enable = true;
		enableCompletion = true;
		enableVteIntegration = true;
		autocd = true;
		dotDir = "$HOME/.config/zsh?";
		autosuggestion = {
			enable = true;
		};
		history = {
			extended = true;
			expireDuplicatesFirst = true;
			ignoreDups = true;
			path = "$ZDOTDIR/.zsh_hist";
			share = true;
		};
		plugins = [
			{
				name = "aloy";
				file = "aloy.zsh-theme";
				src = pkgs.fetchFromGitHub {
					owner = "garethclews";
					repo = "aloy";
					rev = "042f3b092be9cc007c322fa189233fae81de08a7";
					hash = "sha256-zLAW0x38xkcU7850AWHOXTEKJBLIAtnCdqDeSuVGWm8=";
				};
			}
		];
		shellAliases = {
			ls = "lsd --group-directores-first";
		};
		initExtra = ''
			update () { i=$(pwd); cd ~/.config/nix/; sudo nixos-rebuild switch --flake '.#'$(hostname); cd $i }
		'';
		
	};
}
