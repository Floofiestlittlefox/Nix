{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

	hyprland = {
		type = "git";
		url="https://github.com/hyprwm/Hyprland";
                rev="ea2501d4556f84d3de86a4ae2f4b22a474555b9f";
		submodules = true;
   	};
	hyprland-plugins = {
		type = "git";
		url = "https://github.com/hyprwm/hyprland-plugins";
                rev = "8571aa9badf7db9c4911018a5611c038cc776256";
		inputs.hyprland.follows = "hyprland";
	};
	hyprgrass = {
                type = "git";
		 url = "https://github.com/horriblename/hyprgrass";
                 rev = "d9b556630de0130564508b73783dc3f38412e431";
		 inputs.hyprland.follows = "hyprland"; # IMPORTANT
	};
        #hyprspace = {
	#	type = "git";
	#	url = "https://github.com/KZDKM/Hyprspace";
        #        #rev = "a44d834af279f233a269d065d2e14fe4101d6f41";
	#	submodules = true;
	#	inputs.hyprland.follows = "hyprland";
	#};
	split-monitor-workspaces = {
		url = "github:Duckonaut/split-monitor-workspaces";
		inputs.hyprland.follows = "hyprland";
	};
	vulpix = {
		url = "git+https://gitlab.com/bulkiestpizza/vulpix-cursors";
	};
	eww = {
		url = "git+https://github.com/elkowar/eww.git";
	};
	nixvim = {
	    url = "github:nix-community/nixvim";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
        nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
        flake-utils.url = "github:numtide/flake-utils";
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        ags.url = "github:Aylur/ags";

        walker.url = "github:abenz1267/walker";
	#waypaper-engine = {
	#	url = "path:./customPackages/waypaper-engine/";
	#};

};

  outputs = { self, nixpkgs, home-manager, hyprland, nixos-hardware, nixneovimplugins, ...}@inputs: {

  	nixosConfigurations = {
		lachlanLaptop = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ 
			./configuration.nix
			./laptop/laptop.nix
			nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7.amdgpu
			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
			    	home-manager.useUserPackages = true;
			    	home-manager.users.lachlan = import ./home.nix;
				home-manager.extraSpecialArgs = { inherit inputs; };
				}
			];
		};
		lachlanDesktop = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				./desktop/desktop.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.lachlan = import ./home.nix;
					home-manager.extraSpecialArgs = { inherit inputs; };
				}
			];
		};
	};
};

}
