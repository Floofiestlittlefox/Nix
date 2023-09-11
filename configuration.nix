# Edit this copnfiguration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, ... }: 


{
  imports =
    [ # Include the results of the hardware scan.
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      #./home.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  users.defaultUserShell = pkgs.zsh;
  
# configuration.nix
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    experimental-features = [ "nix-command" "flakes" ];
    
  };
   nixpkgs.config.allowUnfree = true; 
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Australia/Brisbane";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     #keyMap = "us";
     useXkbConfig = true; # use xkbOptions in tty.
   };

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.displayManager.sddm.enable = true;
   services.xserver.desktopManager.plasma5.enable=true;
   services.xserver.windowManager.awesome.enable=true;
   #services.xserver.displayManager.defaultSession = "plasmawayland";
   services.flatpak.enable = true;
   services.emacs.enable = true;
   environment.plasma5.excludePackages = with pkgs.libsForQt5; [
     xdg-desktop-portal-kde
   ];
#systemd.services.mpd.environment = {
#    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
#    XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
#};
#   services.mpd = {
#     user = "lachlan";
#     enable = true;
#     musicDirectory= "/home/lachlan/Music";
#     extraConfig = ''
#                 state_file "~/.mpd/state"
#                 pid_file "~/.mpd/pid"
#                 db_file "~/.mpd/db"
#                 playlist_directory "~/.mpd/playlists"
#                 audio_output {
#                              type "pipewire"
#                              name "Pulse"
#                 }
#'';
#};
  

  # Configure keymap in X11
   services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      # enable this module      
      enable = true;
      # defaults (no need to be set unless modified)
      quantum = 64;
      rate = 48000;
    };
  };
  
  # make pipewire realtime-capable
  security.rtkit.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.lachlan= {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
       kmail
       wofi
       obsidian
     ];
   };
   environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.n
     wget
     eww-wayland
     osdlyrics
     mpdris2
     mako
     gitFull
     progress
     librewolf
     nicotine-plus
     gamescope
     cantata
     inputs.nix-gaming.packages.${pkgs.system}.proton-ge
     inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
     swww
     btop
     openttd-jgrpp
     kitty
     swaybg
     rofi
     arandr
     cargo
     gcc
     wofi
     libsForQt5.qtstyleplugin-kvantum
     polkit-kde-agent
     qt5ct
     xdg-desktop-portal-hyprland
     pavucontrol
     mpc-cli
     waybar
     sonata
     autoconf
     autoconf-archive
     automake
     libtool
     ncmpc
     mpdevil
     gccgo
     kid3
     python311Packages.eyeD3
     lsd
     nodejs_20
     kbibtex
     nmap
     texlive.combined.scheme-full
     jq
   ];
   environment.variables = {
   #"QT_QPA_PLATFORMTHEME"="qt5ct";
   };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
 programs.mtr.enable = true;
programs.partition-manager.enable = true;
 programs.zsh = {
 enable = true;
 #shellInit = "/home/lachlan/.nix-profile/etc/profile.d/hm-session-vars.sh";
 syntaxHighlighting.enable = true;
 autosuggestions.enable = true;
 shellAliases = {
 ls = "lsd";
 update = "sudo nixos-rebuild switch";
 edit = "cd /etc/nixos/nixsync/; emacsclient -c ./configuration.nix &; disown";
 };
 histSize=10000;
 histFile = "~/.zsh/history";
 ohMyZsh = {
 enable = true;
 theme = "avit";
 };
};
 programs.gnupg.agent = {

   enable = true;
   enableSSHSupport = true;
 };
 programs.hyprland.enable = true;
programs.steam = { 
enable = true;
remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true;
  };
programs.ssh = {
extraConfig = ''Host Laptop
 	User lachlan
	HostName 192.168.68.121

	Host Desktop 
	User lachlan
	HostName 180.150.104.138
	Port 22
	'';
	};

fonts.packages = with pkgs; [
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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
   openssh.enable = true;
   syncthing.enable = true;
};
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

