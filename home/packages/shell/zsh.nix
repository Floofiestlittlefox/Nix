{pkgs, lib, config, ...}:

{
	home.packages = with pkgs; [
		lsd
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
		dotDir = ".config/zsh";
		autosuggestion = {
			enable = true;
		};
		history = {
			extended = true;
			expireDuplicatesFirst = true;
			ignoreDups = true;
			path = ".config/zsh/.zsh_hist";
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
			{
				name = "zsh-syntax-highlighting";
				file = "zsh-syntax-highlighting.zsh";
				src = pkgs.fetchFromGitHub {
					owner = "zsh-users";
					repo = "zsh-syntax-highlighting";
					rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
					hash ="sha256-4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
				};
			}
				
		];
		shellAliases = {
			ls = "lsd --group-directories-first";
			cd = "z";
			cdi = "zi";
		};
		initExtra = ''
			update () { i=$(pwd); cd ~/.config/nix/; sudo nixos-rebuild switch --flake '.#'$(hostname); cd $i }
			(cat ~/.cache/wal/sequences &)
			unsetopt beep

		'';

		
	};
}
