{lib, fetchFromGithub, pkgs, ...}:
let 
  customMods = self: super: lib.recursiveUpdate super {
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
  };
in
{
  cataclysm-dda.withMods (mods: with mods.extend customMods; [
    noctsCataMod
  ])
}
