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
	hyprland-plugins = {
		type = "git";
		url = "https://github.com/hyprwm/hyprland-plugins";
		rev = "e9457e08ca3ff16dc5a815be62baf9e18b539197";
		inputs.hyprland.follows = "hyprland";
	};
	hyprgrass = {
		 url = "git+https://github.com/horriblename/hyprgrass?rev=091d0e9a9877d08d5d4f51eb71e255b8c78ffd89";
		 inputs.hyprland.follows = "hyprland"; # IMPORTANT
	};
	hyprspace = {
		type = "git";
		url = "https://github.com/KZDKM/Hyprspace";
		rev = "a44d834af279f233a269d065d2e14fe4101d6f41";
		submodules = true;
		inputs.hyprland.follows = "hyprland";
	};
	hyprscroller = {
		type = "git";
		url = "https://gitlab.com/bulkiestpizza/hyprscroller";
		submodules = true;
		inputs.hyprland.follows = "hyprland";
	};
	split-monitor-workspaces = {
		url = "github:Duckonaut/split-monitor-workspaces?rev=b0ee3953eaeba70f3fba7c4368987d727779826a";
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
        hycov={
          type = "git";
          rev = "05fb15703d07a372b14a3260a337de13d1c16b91";
          url = "https://github.com/DreamMaoMao/hycov";
          inputs.hyprland.follows = "hyprland";
        };

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
