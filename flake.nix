{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";


    home-manager= {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

	hyprland = {
		type = "git";
		url="https://github.com/hyprwm/Hyprland";
		submodules = true;
   	};
	hyprgrass = {
                type = "git";
		 url = "https://github.com/horriblename/hyprgrass";
		 inputs.hyprland.follows = "hyprland"; # IMPORTANT
	};
	split-monitor-workspaces = {
          type = "git";
	  url = "https://github.com/Duckonaut/split-monitor-workspaces";
	  inputs.hyprland.follows = "hyprland";
	};

  vulpix = {
    url = "git+https://gitlab.com/bulkiestpizza/vulpix-cursors";
  };
  typst = {
    url = "github:typst/typst";
    inputs.nixpkgs.follows = "nixpkgs";
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
  sops-nix.url = "github:Mic92/sops-nix";
  walker.url = "github:abenz1267/walker";
};

  outputs = { nixpkgs, home-manager, nixos-hardware, nur, sops-nix, ...}@inputs: {

  	nixosConfigurations = {
		lachlanLaptop = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [ 
			./systems/laptop
                        sops-nix.nixosModules.sops
                        nur.nixosModules.nur
			nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7.amdgpu
			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
			    	home-manager.useUserPackages = true;
			    	home-manager.users.lachlan = import ./home/home.nix;
				home-manager.extraSpecialArgs = { inherit inputs; };
				}
			];
		};
		lachlanDesktop = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./systems/desktop
                                sops-nix.nixosModules.sops
                                nur.nixosModules.nur
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.lachlan = import ./home/home.nix;
					home-manager.extraSpecialArgs = { inherit inputs; };
				}
			];
		};
	};
};

}
