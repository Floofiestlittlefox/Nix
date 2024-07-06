{stdenv, fetchurl, autoPatchelfHook, pkgs, ... }:
stdenv.mkDerivation rec {
  name = "catapult-${version}";
  version = "24.05a";

  file = fetchurl {
    url = "https://github.com/qrrk/Catapult/releases/download/24.05a/catapult-linux-x64-24.05a";
    hash = "sha256-QfILuKlSbxY3UrmqCkRjSBNFUropFSBSBYC/WfbUY98=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    pkgs.SDL2
    pkgs.SDL2_ttf
    pkgs.SDL2_image
    pkgs.SDL2_mixer
    pkgs.freetype
  ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    install -m 744 -D $file $out/bin/catapult-linux-x64-24.05a
    runHook postInstall
  '';

}


