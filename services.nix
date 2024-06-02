{ config, pkgs, ... }:
let 
   appimage-menu-updater = (pkgs.callPackage ./customPackages/appimage-menu-updater.nix {});
in
{
    services = {
		gvfs.enable = true;
		sysprof.enable = true;
		udev = {
			enable = true;
			packages = [ pkgs.gnome.gnome-settings-daemon ];
		};
		printing = {
			enable = true;
			drivers = [pkgs.cups-dymo];
		};
		avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
		flatpak.enable = true;
		openssh.enable = true;
		openssh.settings.PasswordAuthentication = false;
		libinput.enable = true;
		desktopManager.plasma6.enable = true;
		displayManager = {
			sddm.wayland.enable = false;
			sddm.enable = false;
			defaultSession = "hyprland";
		};
		xserver = {
			enable = true;
			displayManager.gdm.enable = true;
			desktopManager.gnome.enable = true;
		};
		

	};
    	sound.enable = true;
	hardware = {
		pulseaudio.enable = false;

	};
	systemd = {
		  user.services.polkit-kde-agent-1 = {
		    description = "polkit-kde-agent-1";
		    wantedBy = [ "graphical-session.target" ];
		    wants = [ "graphical-session.target" ];
		    after = [ "graphical-session.target" ];
		    serviceConfig = {
			Type = "simple";
			ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-agent-1";
			Restart = "on-failure";
			RestartSec = 1;
			TimeoutStopSec = 10;
		      };
		  };

		user.services.appimage-menu-updater = {
			enable = true;
			description = "AppImage Menu Updater";
			unitConfig = {
				Type = "simple";
			};
			serviceConfig = {
				ExecStart = "/bin/sh -c 'HOME=%h ${appimage-menu-updater}'";
			};
			wantedBy = [ "default.target" ];
		};
	};
	networking = {
	    networkmanager.enable = true; 
	    firewall.enable = false; 
	};
    	xdg.portal = {
		enable = true;
	};
	security.polkit.enable = true;
}
