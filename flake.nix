{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

	hyprland = {
		type = "git";
		url="https://github.com/hyprwm/Hyprland";
		rev="fe7b748eb668136dd0558b7c8279bfcd7ab4d759";
		submodules = true;
   	};
#	hyprgrass = {
#		 url = "git+https://github.com/horriblename/hyprgrass?rev=f888dab948219197e2870cfd261b6f87690484a7";
#		 inputs.hyprland.follows = "hyprland"; # IMPORTANT
#	};
#	hyprspace = {
#		type = "git";
#		url = "https://github.com/KZDKM/Hyprspace";
#		submodules = true;
#		inputs.hyprland.follows = "hyprland";
#	};
#	hyprscroller = {
#		type = "git";
#		url = "ssh://git@gitlab.com/bulkiestpizza/hyprscroller";
#		submodules = true;
#		inputs.hyprland.follows = "hyprland";
#		};
	vulpix = {
		url = "git+https://gitlab.com/bulkiestpizza/vulpix-cursors";
	};
	eww = {
		url = "git+https://github.com/elkowar/eww.git";
	};
};

  outputs = { self, nixpkgs, home-manager, hyprland, ...}@inputs: {

  	nixosConfigurations = {
		lachlanLaptop = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ 
			./configuration.nix
			./laptop.nix
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
				./desktop.nix
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
