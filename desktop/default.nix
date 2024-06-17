{ config, pkgs, ... }:
{
    services = {
    	power-profiles-daemon.enable = false;

        tlp = {
		enable = false;
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";


			CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
			CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
			};
        };
    };
    virtualisation.docker.enable = true;
    virtualisation.docker.liveRestore = false;
    virtualisation.waydroid.enable = false;
    imports = [
    	./desktop-hardware-configuration.nix
        ../configuration.nix
];
	networking.hostName = "lachlanDesktop";
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};
}
