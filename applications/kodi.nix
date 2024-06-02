{pkgs, lib, config, ...}:

{
	home.packages = [

	];
	programs.kodi= {
		enable = true;
		package = pkgs.kodi-wayland.withPackages (kodiPkgs: with kodiPkgs;
		[
			jellyfin
			osmc-skin
		]);
		
	};
}
