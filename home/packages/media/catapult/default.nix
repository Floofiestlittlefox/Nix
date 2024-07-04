{stdenv, fetchurl, autoPatchelfHook, pkgs, ... }:
stdenv.mkDerivation rec {
  name = "Catapult-${version}";
  version = "24.05a";

  src = fetchurl {
    url = "https://github.com/qrrk/Catapult/releases/download/24.05a/catapult-linux-x64-${version}";
    hash = "";
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
  installPhase = ''
    runHook preInstall
    install -m755 -D catapult-linux-x64-${version} $out/bin/catapult
    runHook postInstall
  '';

};


