{pkgs, ...}:
let
  appimage-menu-updater = (pkgs.callPackage ./appimage-menu-updater.nix {});
    in
{
  systemd.user = {
    startServices = "sd-switch";
    services = {
      lxqt-policykit-agent = {
        description = "polkit-lxqt-agent";
        wantedBy = ["graphical-session.target"];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.lxqt.lxqt-policykit}/libexec/lxqt-policykit-agent";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      appimage-menu-updater = {
        enable = true;
        description = "Appimage Menu Updater";
        unitConfig = {
				  Type = "simple";
			  };
			  serviceConfig = {
				  ExecStart = "/bin/sh -c 'HOME=%h ${appimage-menu-updater}'";
			  };
			  wantedBy = [ "default.target" ];
		  };
	  };
  };
 }
