
with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "ncmpcpp-git";
  version = "master";

  src = fetchFromGitHub {
    owner  = "ncmpcpp";
    repo   = "ncmpcpp";
    rev    = "9f44edf0b1d74da7cefbd498341d59bc52f6043f";
    sha256 = "PjCzo3OSj/QIi2fdeV28ZjPiqLf6XAnZeNrDyjXt5wU=";
  };

  buildInputs = [ autoconf automake boost ncurses readline libtool ];

  patchPhase = ''
    substituteInPlace Makefile.am --replace "/usr" ""
  '';
  configurePhase = "./autogen.sh; ./configure.sh";
  installFlags = [ "DESTDIR=$(out)" ];
}
