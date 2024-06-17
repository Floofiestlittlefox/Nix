{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager= {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

	hyprland = {
		type = "git";
		url="https://github.com/hyprwm/Hyprland";
                rev="fe7b748eb668136dd0558b7c8279bfcd7ab4d759";
		submodules = true;
   	};
	hyprland-plugins = {
		type = "git";
		url = "https://github.com/hyprwm/hyprland-plugins";
                rev = "e9457e08ca3ff16dc5a815be62baf9e18b539197";
		inputs.hyprland.follows = "hyprland";
	};
	hyprgrass = {
                type = "git";
		 url = "https://github.com/horriblename/hyprgrass";
                 rev = "091d0e9a9877d08d5d4f51eb71e255b8c78ffd89";
		 inputs.hyprland.follows = "hyprland"; # IMPORTANT
	};
	split-monitor-workspaces = {
          type = "git";
          rev = "b0ee3953eaeba70f3fba7c4368987d727779826a";
	  url = "https://github.com/Duckonaut/split-monitor-workspaces";
	  inputs.hyprland.follows = "hyprland";
	};

	vulpix = {
		url = "git+https://gitlab.com/bulkiestpizza/vulpix-cursors";
	};

	nixvim = {
	    url = "github:nix-community/nixvim";
	    inputs.nixpkgs.follows = "nixpkgs";
	};

        emacs-overlay.url = "github:nix-community/emacs-overlay/";
        nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
        flake-utils.url = "github:numtide/flake-utils";
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        ags.url = "github:Aylur/ags";

        walker.url = "github:abenz1267/walker";
};

  outputs = { nixpkgs, home-manager, nixos-hardware, ...}@inputs: {

  	nixosConfigurations = {
		lachlanLaptop = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ 
			./laptop
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
				./desktop
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
