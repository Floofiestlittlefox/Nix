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
	hyprgrass = {
		 url = "git+https://github.com/horriblename/hyprgrass?rev=f888dab948219197e2870cfd261b6f87690484a7";
		 inputs.hyprland.follows = "hyprland"; # IMPORTANT
	};
	hyprspace = {
		type = "git";
		url = "https://github.com/KZDKM/Hyprspace";
		submodules = true;
		inputs.hyprland.follows = "hyprland";
	};
	hyprscroller = {
		type = "git";
		url = "https://github.com/dawsers/hyprscroller";
		rev = "733cfebfd241ecb98298314986896ad46dad3ccd";
		submodules = true;
		inputs.hyprland.follows = "hyprland";
		};
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
			./hardware-configuration.nix
			./packages.nix
			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
			    	home-manager.useUserPackages = true;
			    	home-manager.users.lachlan = import ./home.nix;
				home-manager.extraSpecialArgs = { inherit inputs; };
			}
		];
	};
  };
  homeConfigurations."lachlan@lachlanLaptop" = home-manager.lib.homeManagerConfiguration {
	modules = [
		hyprland.homeManagerModules.default
		./home.nix
		./hyprland.nix
		{wayland.windowManager.hyprland.enable = true;}
		];
	};


  };
}

