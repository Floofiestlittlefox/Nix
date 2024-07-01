{pkgs, lib, config, ...}:
{
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    java.enable = true;
  };
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
  environment.systemPackages = 
  with pkgs; [
    cataclysm-dda   
  ];
}
