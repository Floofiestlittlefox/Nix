{pkgs, ...}:
let
  appimage-menu-updater = (pkgs.callPackage ./appimage-menu-updater.nix {});
    in
{
  systemd.user = {
    startServices = "sd-switch";
    services = {
      lxqt-policykit-agent = {
        Unit = {
          Description = "polkit-lxqt-agent";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
          Wants = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.lxqt.lxqt-policykit}/libexec/lxqt-policykit-agent";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      appimage-menu-updater = {
        Unit = {
          Description = "Appimage Menu Updater";
	  Type = "simple";
        };
        Service = {
          ExecStart = "/bin/sh -c 'HOME=%h ${appimage-menu-updater}'";
	};
        Install = {
	  WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
