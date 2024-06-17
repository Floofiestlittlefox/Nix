{libs, config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nixneovimplugins.overlays.default
    inputs.emacs-overlay.overlays.default
  ];
	programs = {
		ssh.askPassword = "true";
		zsh.enable = true;
		firefox = {
			enable = true;
			package = pkgs.firefox;
			nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
		};
		kdeconnect.enable = true;
		mtr.enable = true;
		dconf.enable = true;  
		evolution = {
			enable = false;
			plugins = [ pkgs.evolution-ews ];
			};
		neovim = {
			enable = true;
			defaultEditor = true;
		};
                hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.system}.hyprland;
		};
	};
	environment.systemPackages = with pkgs; [
		abiword
		#inputs.waypaper-engine.packages.${pkgs.system}.waypaper-engine
		papers
                kanjidraw
                jiten
                jabref
                xournalpp
		obsidian
		perl538Packages.LaTeXML
		calibre
		tor
		wineWowPackages.waylandFull
		kbibtex
		inkscape
		ninja
		bibtool
		papis
		prusa-slicer
		amberol
		libdisplay-info
		exaile
		super-slicer-beta
		(callPackage ./customPackages/plexamp {})
		(callPackage ./customPackages/iio-hyprland {})
                (callPackage ./customPackages/wvkbd-n7n {})
		gnumake
		fzf
		pandoc
		chromium
		poppler_utils
		libwacom
		lsof
		rnote
		yt-dlp
		kdenlive
		joplin
		joplin-desktop
		supersonic
		feishin
		plex-mpv-shim
		jellyfin-mpv-shim
		htop
		btop
		appimage-run
		lightly-boehs
		variety
		tautulli
                kdePackages.qtwayland
                libsForQt5.qt5.qtwayland
		qalculate-qt
		qownnotes
		plasma-pass
		krita
		plasma-hud
		kdePackages.kmail
                kdePackages.dolphin
                kdePackages.okular
		kdePackages.merkuro
		kdePackages.polkit-kde-agent-1
		maliit-keyboard
		maliit-framework
		kdePackages.discover
                tagainijisho
		p3x-onenote
		acpi
		picard
		phosh
		mpv
		endeavour
		libinput
		libinput-gestures
		prismlauncher

		powertop
		alacritty
		swayfx
		grim
		slurp
		wl-clipboard
		bemenu
		swaybg
		swaylock
		swayidle
		swaysome
		obs-studio
		beets
		networkmanagerapplet
		zotero
		typst-lsp
		texlive.combined.scheme-full
		sassc
		vimPlugins.lazy-nvim
		rhythmbox
		cmake


		bat
		bc
		beets
		brightnessctl

		cmake
		cura

		eww
		
		fd
		feh

		gcc
		gdk-pixbuf
		git
		gnome-themes-extra
		gtk-engine-murrine

		i3
		imagemagick

		kitty

		libreoffice
		librsvg
		lsd
		lua
		luarocks
		lxappearance

		mupdf

		pavucontrol
		pcmanfm
		playerctl
		polkit
		python3
		pywal
		pqiv

		rhythmbox
		ripgrep

		sassc
		stow

		thunderbird
		tree
		typst


		vim
		vimPlugins.YouCompleteMe
		vscode

		wget
		wpgtk

		xdotool
                nix-search-cli

		zip
	];
	fonts.packages = with pkgs; [
		nerdfonts
		kanji-stroke-order-font
	];
}
