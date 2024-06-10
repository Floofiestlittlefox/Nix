{pkgs, lib, config, inputs,...}:

{
	home.packages = [

	];
	programs.eww = {
		enable = true;
		package = inputs.eww.packages.${pkgs.system}.default;
                configDir = ./eww-config;
	};

}
