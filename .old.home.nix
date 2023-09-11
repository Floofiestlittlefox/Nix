{config, pkgs, ...}: {
  wayland.windowManager.hyprland.extraConfig = ''
  $mod = SUPER

bind = $mod SHIFT, RETURN, exec, firefox
bind = $mod, RETURN, exec, kitty
bind = $mod, e, exec, dolphin
${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

    # ...
  '';


#wayland.windowManager.hyprland.plugins = [
#  inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
#  "/absolute/path/to/plugin.so"
#];
}
