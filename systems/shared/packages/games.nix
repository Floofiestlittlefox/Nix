{pkgs, lib, fetchFromGithub, cataclysmDDA, ...}:
let 
  mod.noctsCataMod = cataclysmDDA.buildMod {
    modName = "Expansion";
    version = "0.G";
    src = fetchFromGithub {
      owner = "Noctifer-de-Mortem";
      repo = "nocts_cata_mod";
      rev = "f94caa60b4e2d1d8f8494dc3d37814af893a4b9e";
      hash = "";
    };
  };
in
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
