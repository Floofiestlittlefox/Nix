{ lib, stdenv, fetchFromGitHub, meson, ninja, sassc, gdk-pixbuf, librsvg, gtk_engines, gtk-engine-murrine }:

stdenv.mkDerivation rec {
  pname = "Libadwaita-Breeze-Dark";
  version = "4.0";

  src = fetchFromGitHub {
    owner = "MrCompoopter";
    repo = pname;
    rev = "628533b48af908d77e446ad4e560ed65a74a1199";
    sha256 = "1q026wa8xgyb6f5k7pqpm5zav30dbnm3b8w59as3sh8rhfgpbf80";
  };

  nativeBuildInputs = [ meson ninja sassc ];

  buildInputs = [ gdk-pixbuf librsvg gtk_engines ];

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  meta = with lib; {
    description = "Themes for GTK, gnome-shell and Xfce";
    homepage = "https://github.com/lassekongo83/zuki-themes";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = [ maintainers.romildo ];
  };
}
