{ pkgs, ... }:
{
  imports = [
    ./packages
    ./services
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix.settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    substituters = [
      "https://hyprland.cachix.org" 
      "https://nix-community.cachix.org/"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  boot =  {
		kernelPackages = pkgs.linuxPackages_zen;
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};
  time.timeZone = "Australia/Brisbane";
	i18n = {
		defaultLocale = "en_AU.UTF-8";
	};
  console = {
    font = "Lat2-Terminus16";
		useXkbConfig = true;
	};

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" "KanjiStrokeOrders" ];
        sansSerif = [ "Liberation Sans" "KanjiStrokeOrders" ];
        monospace = [ "Liberation Mono" ];
      };
    };
  };
  users = {
    defaultUserShell = pkgs.zsh;
    users.lachlan = {
      isNormalUser = true;
      extraGroups = [ "adbusers" "wheel" "networkmanager" "lp" "docker" "video" "input" ];
    };
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  system.stateVersion = "23.11";

}

