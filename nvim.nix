{pkgs, lib, config, ...}:

{
	home.packages = [

	];
	programs.neovim = {
		enable = false;
		coc = {
			enable = true;
		};

	};
}
