{ stdenv
, lib
, fetchFromGitHub
, wayland-scanner
, wayland
, pango
, glib
, harfbuzz
, cairo
, pkg-config
, libxkbcommon
}:

stdenv.mkDerivation rec {
  pname = "wvkbd-n7n";
  version = "76aab77ea40c915796f0cf87b0cb766505af1b68";

  src = fetchFromGitHub {
    owner = "nine7nine";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-9gDxMH1hghqjcXlbda7CHjDdjcjApjjie7caihKIg9M=";
  };

  postPatch = ''
    substituteInPlace Makefile \
      --replace "pkg-config" "$PKG_CONFIG"
  '';

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
  ];
  buildInputs = [
    cairo
    glib
    harfbuzz
    libxkbcommon
    pango
    wayland
  ];
  installFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    homepage = "https://github.com/jjsullivan5196/wvkbd";
    description = "On-screen keyboard for wlroots";
    maintainers = [ maintainers.elohmeier ];
    platforms = platforms.linux;
    license = licenses.gpl3Plus;
    mainProgram = "wvkbd-mobintl";
  };
}
