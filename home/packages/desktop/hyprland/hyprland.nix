{pkgs, inputs, ... }:
{
	home.packages = with pkgs; [
		grimblast
    brightnessctl
		slurp
		swaynotificationcenter
		swayosd
		anyrun
		swww
		waypaper
		nwg-drawer
		squeekboard
		libnotify
                wl-clipboard
            kdePackages.polkit-kde-agent-1
            (callPackage ./wvkbd-n7n {})
            (callPackage ./iio-hyprland {})
	];
wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.default;
                systemd.enable = true;
                xwayland.enable = true;
		extraConfig = ''
		env=XDG_MENU_PREFIX,plasma-
                env=NIXOS_OZONE_WL=1
		input {
			follow_mouse = 1
			mouse_refocus = true
		}
		device {
			name = at-translated-set-2-keyboard
			repeat_rate=100
			repeat_delay=300
			middle_button_emulation=0
							      
		}
		device {
			name = elan06fa:00-04f3:327e-touchpad
			scroll_method=2fg
			natural_scroll=true
			
		}
		gestures {
			workspace_swipe=true
			workspace_swipe_cancel_ratio = 0.15

                        workspace_swipe_distance = 700
			workspace_swipe_touch=true
		}
		plugin:touch_gestures {
			sensitivity = 6.0
			workspace_swipe_fingers = 3
		}
		plugin:scroller {
			focus_wrap = false
		}
		plugin:overview {
			autoDrag = true
			exitOnSwitch = true
			showEmptyWorkspace = false
                        hideRealLayers = false
                        centerAligned = false
                        hideTopLayers = true
		}

                plugin:hyprexpo {
                  gap_size = 5
                  workspace_method = center current

                  enable_gesture = true
                  gesture_fingers = 3
                  gesture_distance = 300
                  gesture_posititive = true
                }
		
		general {
                        resize_on_border = true

		}

		debug:disable_logs=false





			
		'';
		settings = {
			"$mod" = "SUPER";
			monitor = [
				"eDP-1,1920x1200,0x0,1"
				"DP-1, 1920x1080,-1920x0,1"
				"DP-2, 1920x1080,0x0,1"
				"HDMI-A-1, 1920x1080,auto-right,1"
			];
			windowrulev2= [
				"float,class:^(nwg-drawer)$,title:^(nwg-drawer)$"
				"pseudo,class:^(squeekboard)$,title:^(squeekboard)$"
                                "stayfocused,class:^(walker)$,title::^(walker)$"
			];
			animation = [
				"windows,1,3,default,popin 80%"
				"workspaces,1,6,default"
			];
			exec-once = [
				"swaync &"
                                "fcitx5"
				"swayosd-server &"
				"waypaper --restore --random --backend swww &"
				"iio-hyprland &"
                                "wvkbd-mobintl -L -H 300"
                                "ags"
				
			];
			bindel = [
				", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
				", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
				", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
				", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
				", F3, exec, swayosd-client --output-volume raise"
				", F2, exec, swayosd-client --output-volume lower"


			];
			bindr = [
                                "$mod, P, exec, walker"
                                #"$mod,Super_L, overview:toggle"
                                #"$mod, Super_L, submap, overview"
				"Caps_Lock,Caps_Lock, exec, swayosd-client --caps-lock"
			];
			bindl = [
				", switch:on:Lenovo Yoga Tablet Mode Control switch, exec, gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true"
				", switch:off:Lenovo Yoga Tablet Mode Control switch, exec, gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false"

			];
	
			bind =
			[

                                 ", swipe:4:ld,killactive"

                                
				"$mod Shift, Q, exit"
				"$mod Shift, Return, exec, firefox"
				"$mod, Return, exec, kitty"
				"$mod, Backspace, killactive"

				"$mod, F, fullscreen"
				"$mod, Space, togglefloating"
				"$mod, e, exec, dolphin"
				", Print, exec, grimblast copy area"
				#"$mod, S, workspace, special"
				"$mod, l, movefocus, r"
				"$mod, k, movefocus, u"
				"$mod, j, movefocus, d"
				"$mod, h, movefocus, l"
				"$mod Shift, l, movewindow, r"
				"$mod Shift, k, movewindow, u"
				"$mod Shift, j, movewindow, d"
				"$mod Shift, h, movewindow, l"

				"$mod, equal, resizeactive, 100 0"
				"$mod, minus, resizeactive, -100 0"

				", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
				", F4, exec, swayosd-client --output-volume mute-toggle"

				
				
			]
			 ++ (
				# workspaces
				# binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
				builtins.concatLists (builtins.genList (
				    x: let
				      ws = let
					c = (x + 1) / 10;
				      in
					builtins.toString (x + 1 - (c * 10));
				    in [
				      "$mod, ${ws}, split-workspace, ${toString (x + 1)}"
				      "$mod SHIFT, ${ws}, split-movetoworkspace, ${toString (x + 1)}"
				    ]
				  )
				  10)
	      		);		

			bindm = [
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
				"$mod ALT, mouse:272, resizewindow"
                                ", longpress:3, movewindow"
                                ", longpress:4, resizewindows"

			];
		};
		plugins = [
			inputs.hyprgrass.packages.${pkgs.system}.default
                        #inputs.hyprspace.packages.${pkgs.system}.Hyprspace
                        #inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
			inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
                        #inputs.hycov.packages.${pkgs.system}.hycov
		];
	};
}

