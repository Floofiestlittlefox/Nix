{pkgs, lib, config, inputs, ... }:
{
	home.packages = [
		pkgs.grimblast
		pkgs.swaynotificationcenter
		pkgs.swayosd
		pkgs.anyrun
		pkgs.waypaper
		pkgs.swww
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
		
		general {
			layout = scroller

		}

		debug:disable_logs=false
			
		'';
		settings = {
			"$mod" = "SUPER";
			monitor = [
				"eDP-1,1920x1200,0x0,1"
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
				"waypaper --restore --random --backend=swww &"
				"iio-hyprland &"
				"squeekboard &"
				
			];
			bindel = [
				", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
				", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
				", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
				", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

			];
			bindr = [
				"$mod, P, exec, pkill wofi || wofi --show drun"
				"$mod,Super_L, overview:toggle"
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
				"$mod, e, exec, dolphin"
				", Print, exec, grimblast copy area"
				"$mod, S, workspace, special"
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
				      "$mod, ${ws}, workspace, ${toString (x + 1)}"
				      "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
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
#			inputs.hyprgrass.packages.${pkgs.system}.default
#			inputs.hyprspace.packages.${pkgs.system}.Hyprspace
			#inputs.hyprscroller.packages.${pkgs.system}.default
		];
	};
}

