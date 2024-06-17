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
	];

	nix.settings = {
          experimental-features = [ "flakes" "nix-command" ];
          substituters = [
            "https://hyprland.cachix.org" 
            "https://nix-community.cachix.org/"
          ];
          trusted-public-keys = [
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
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
		defaultLocale = "en_AU.UTF-8";
		inputMethod = {
			enabled = "fcitx5";
			ibus.engines = with pkgs.ibus-engines; [ mozc ];
			fcitx5 = {
				plasma6Support = false;
                                waylandFrontend = true;
				addons = with pkgs; [
                                        fcitx5-rime
					fcitx5-mozc
				];
			};
		};

	};

	console = {
		font = "Lat2-Terminus16";
		useXkbConfig = true;
	};

        fonts = {
          enableDefaultPackages = true;
          packages = with pkgs; [
            liberation_ttf
            kanji-stroke-order-font
          ];
          fontconfig = {
            defaultFonts = {
              serif = [ "Liberation Serif" "KanjiStrokeOrders" ];
              sansSerif = [ "Liberation Sans" "KanjiStrokeOrders" ];
              monospace = [ "Liberation Mono" ];
            };
          };
        };

	# Define a user account. Don't forget to set a password with ‘passwd’.
	programs.zsh.enable = true;
	users = {
		defaultUserShell = pkgs.zsh;
		users.lachlan = {
			isNormalUser = true;
			extraGroups = [ "wheel" "networkmanager" "lp" "docker" "video" "input" ];
			openssh.authorizedKeys.keys = [ "ssh-rsa AAAAC3NzaC1lZDI1NTE5AAAAIJRyaHRAU4gZzwPqsNZtfs65FHnHdQTNeRBgKMlDLxZp lachlan@lachlanLaptop" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxUqOjSxVsegRphQEurJuirn/W8ep1X4ZAE0a/eTOOOKn6Egc50Va2FVv+2bGiR+CoXfX+ALzdA/cSGlITeDNyy7yuzjjq2G6+9jCAq61RvBh1iBtgAn0+Xsrirlv4J7UEEzp5QdbUJ6z4RoN3FRB/nHUX8/7dT63s6P4NqRuSXMsRes2nw+/r7ywIxwptVJ+q8JZgE1DFFzUfKQkjsazHSlkOBbbS6G5oLt1v9HD7TmtBWjwgzi1DNRqRQKdUBePINdCvFCjldDHW3YfezBjPyGYZ7aUKFHSNKqTJocOGwbGzj0VFCFKNjpASi70hYH4KyNvXI+/Ue/DRQD4L6rbIkATncNni0LXNdJW/Ux47DO+4AdjjNJrh3AqHKowaRCbr8K8bmA/bYz3PxiJddqRpbrlLaG7zGh1/SIXuc+xYKHHqps/8vvSUenWWb1YD0tsBq0Yuk5c/RBDQsUn+QLO3fOgSQFp7giwnHuP/mtjywJrfn7VzyaNjm lachlan@lachlanDesktop" ];
			packages = with pkgs; [];

		};
	};
        swapDevices = [{
          device = "/var/lib/swapfile";
          size = 16*1024;
        }];
	system.stateVersion = "23.11";
}
