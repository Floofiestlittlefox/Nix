{pkgs, lib, config, ...}:

{
	home.packages = [

	];
	programs.neovim = {
		enable = true;
		extraLuaConfig = lib.fileContents ./nvim/init.lua;
	};
}
