{pkgs, lib, config, ...}:

{
	home.packages = [

	];
	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
	programs.zsh= {
		enable = true;
		enableCompletion = true;
		enableVteIntegration = true;
		autocd = true;
		autosuggestion = {
			enable = true;
		};
		history = {
			extended = true;
			expireDuplicatesFirst = true;
			ignoreDups = true;
			dotDir = "$HOME/.config/zsh?";
			path = "$ZDOTDIR/.zsh_hist";
			share = true;
		};
		shellAliases = {
			ls = "lsd --group-directores-first";
		};
		initExtra = {
			"update () { i=$(pwd); cd ~/.config/nix/; sudo nixos-rebuild switch --flake '.#'$(hostname); cd $i"
		};
	};
}
