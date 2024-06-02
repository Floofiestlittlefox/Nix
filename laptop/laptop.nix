{ config, pkgs, ... }:
{
    services = {
    	power-profiles-daemon.enable = false;
        tlp = {
		enable = true;
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";


			CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
			CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
			};
        };
    };
    hardware.sensor.iio.enable = true;
    virtualisation.docker.enable = false;
    virtualisation.waydroid.enable = true;
    	imports = [
    		./laptop-hardware-configuration.nix

	];
	networking.hostName = "lachlanLaptop";
	hardware.bluetooth = {
		enable = false;
		powerOnBoot = false;
	};
}
