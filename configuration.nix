# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
{
	imports = 
	[
		./services.nix
		./packages.nix
		./environment.nix
		./hardware-configuration.nix
		./laptop.nix
	];

	nix.settings = {
		experimental-features = [ "flakes" "nix-command" ];
		substituters = ["https://hyprland.cachix.org"];
    		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
	};
	nixpkgs.config = {
		allowUnfree = true;
	};
	# Use the systemd-boot EFI boot loader.
	boot =  {
		kernelPackages = pkgs.linuxPackages_zen;
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

	time.timeZone = "Australia/Brisbane";
	i18n = {
		defaultLocale = "en_US.UTF-8";
		inputMethod = {
			enabled = "ibus";
			ibus.engines = with pkgs.ibus-engines; [ mozc ];
			fcitx5 = {
				plasma6Support = true;
				waylandFrontend = true;
				addons = with pkgs; [
					fcitx5-mozc
					fcitx5-gtk
				];
			};
		};

	};

	console = {
		font = "Lat2-Terminus16";
		useXkbConfig = true;
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	programs.zsh.enable = true;
	users = {
		defaultUserShell = pkgs.zsh;
		users.lachlan = {
			isNormalUser = true;
			extraGroups = [ "wheel" "networkmanager" "lp" "docker" "video" "input" ];
			packages = with pkgs; [];
		};
	};
	system.stateVersion = "23.11";
}
