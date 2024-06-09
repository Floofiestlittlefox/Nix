{pkgs, inputs, ... }:
{
	home.packages = [
		pkgs.grimblast
		pkgs.swaynotificationcenter
		pkgs.swayosd
		pkgs.anyrun
		pkgs.swww
		pkgs.waypaper
		pkgs.nwg-drawer
		pkgs.squeekboard
		pkgs.libnotify
	];
	programs = {
		wofi.enable = true;
	};
wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.default;
		extraConfig = ''
		env=XDG_MENU_PREFIX,plasma-
		input {
			follow_mouse = 1
			mouse_refocus = true
		}
		device {
			name = at-translated-set-2-keyboard
			repeat_rate=50
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
			layout = scroller

		}

		debug:disable_logs=false

                submap=overview
                  bindn=, Return, submap, reset
                  bindn=, escape, submap, reset
                  bindn=$mod, Super_l, submap, reset
                  bindn=, catchall,exec, nwg-drawer 
                  bindrn=,catchall, submap, reset
                submap=reset




			
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
				

			];
			animation = [
				"windows,1,3,default,popin 80%"
				"workspaces,1,6,default"
			];
			exec-once = [
				"swaync &"
				"swayosd-server &"
				"waypaper --restore --random --backend swww &"
				"iio-hyprland &"
				"squeekboard &"
                                "nwg-drawer -r"
				
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
                                #"$mod, P, exec, pkill wofi || wofi --show drun"
				"$mod,Super_L, overview:toggle"
                                #"$mod, Super_L, submap, overview"
				"Caps_Lock,Caps_Lock, exec, swayosd-client --caps-lock"
			];
			bindl = [
				", switch:on:Lenovo Yoga Tablet Mode Control switch, exec, gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true"
				", switch:off:Lenovo Yoga Tablet Mode Control switch, exec, gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false"

			];
	
			bind =
			[
				"$mod Shift, Q, exit"
				"$mod Shift, Return, exec, firefox"
				"$mod, Return, exec, kitty"
				"$mod, Backspace, killactive"

				"$mod, F, fullscreen"
				"$mod, Space, togglefloating"
				"$mod, e, exec, dolphin"
				", Print, exec, grimblast copy area"
				#"$mod, S, workspace, special"
				"$mod, l, scroller:movefocus, r"
				"$mod, k, scroller:movefocus, u"
				"$mod, j, scroller:movefocus, d"
				"$mod, h, scroller:movefocus, l"
				"$mod Shift, l, scroller:movewindow, r"
				"$mod Shift, k, scroller:movewindow, u"
				"$mod Shift, j, scroller:movewindow, d"
				"$mod Shift, h, scroller:movewindow, l"
				"$mod, M, scroller:alignwindow, c"

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
			];
		};
		plugins = [
			inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
			inputs.hyprgrass.packages.${pkgs.system}.default
                        #inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
                        inputs.hyprspace.packages.${pkgs.system}.Hyprspace
			inputs.hyprscroller.packages.${pkgs.system}.default
			inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
                        #inputs.hycov.packages.${pkgs.system}.hycov
		];
	};
}

