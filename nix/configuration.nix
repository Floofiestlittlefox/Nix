# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./archbox.nix
      ./wayland.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall = {
  enable = false;
};
 # services.minecraft-server = {
 #       enable = true;
 #       eula =true;
 #       declarative = true;
 #serverProperties = {
 #     server-port = 25565;
 #     gamemode = "survival";
 #     motd = "Minecraft server";
 #     max-players = 15;
 #     enable-rcon = true;
 #     # This password can be used to administer your minecraft server.
 #     # Exact details as to how will be explained later. If you want
 #     # you can replace this with another password.
 #     "rcon.password" = "pepito.1";
 #     level-seed = "";
 #   };
 # };

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_US.UTF-8";
 # services 
  services.xserver.enable = true;
  services.xserver.windowManager.i3 = { 
	enable = true;
	extraPackages = with pkgs; [
		dmenu
		i3status
		i3lock
		xdotool
		feh
		dunst
		cataclysm-dda
		jamesdsp
	];
};

 # systemd.services.tailscale-autoconnect = {
 # description = "Automatic connection to Tailscale";

 # # make sure tailscale is running before trying to connect to tailscale
 # after = [ "network-pre.target" "tailscale.service" ];
 # wants = [ "network-pre.target" "tailscale.service" ];
 # wantedBy = [ "multi-user.target" ];

 # # set this service as a oneshot job
 # serviceConfig.Type = "oneshot";

  # have the job run this shell script
  #script = with pkgs; ''
  #  # wait for tailscaled to settle
  #  sleep 2

  #  # check if we are already authenticated to tailscale
  #  status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
  #  if [ $status = "Running" ]; then # if so, then do nothing
  #    exit 0
  #  fi

  #  # otherwise authenticate with tailscale
  #  ${tailscale}/bin/tailscale up -authkey tskey-auth-kW5TDq1CNTRL-3zpSGWyCHycgQKjwRAjzxcLnsAXzXWaTX '';
#

  services.xserver.layout = "us";
  
  services.printing.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.xfce = {
	enable = true;
	noDesktop = true;
	enableXfwm = false;
	};
  services.xserver.displayManager.defaultSession="xfce";

  nixpkgs.config.allowUnfree = true;
  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
package = pkgs.steam.override {
      extraLibraries = p: with p; [
        (lib.getLib networkmanager)
      ];
    };
};
security.rtkit.enable = true;
  hardware.opengl.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  jack.enable = true;
};
  services.openssh.enable = true;
  services.flatpak.enable = true;

programs.hyprland =  { 
enable = true;
#package = inputs.hyprland.packages.${pkgs.system}.hyprland;
};
fonts.fonts = with pkgs; [
(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
];
    fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };
  i18n.inputMethod = { 
  enabled = "fcitx5";
  fcitx5.addons = with pkgs; [
  fcitx5-mozc
  fcitx5-gtk
  ];
};

# user
xdg.portal = { 
enable = true;
extraPortals = with pkgs; [ 
xdg-desktop-portal-kde
];
};
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;
  users.users.lachlan= {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
environment.pathsToLink = [ "/libexec" ]; 

  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     pkgsi686Linux.gnutls
     git
     discord
     webcord
     anki-bin
     jq
     pkgs.swww
     rustc
     musescore
     qt6.qtwayland
     xorg.libxcb.dev
     htop
     nicotine-plus
     btop 
     calibre
     prismlauncher
     openjdk17
     unzip
     xorg.xkill
  ];
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.settings = {
  experimental-features = [ "nix-command" "flakes" ];
  substituters = ["https://nix-gaming.cachix.org" "https://hyprland.cachix.org"];
  trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
};
  system.stateVersion = "unstable"; # Did you read the comment?

}

