{...}:
{
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.9";
      dynamic_background_opacity = "yes";
      confirm_os_window_close = "0";
    };
    shellIntegration.enableZshIntegration = true;
  };
}


