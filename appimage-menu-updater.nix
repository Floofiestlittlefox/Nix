# MIT

# # Using it:
#
# let
#   appimage-menu-updater = (pkgs.callPackage ./somewhere/appimage-menu-updater.nix {});
# in
# {
#   systemd.user.services.appimage-menu-updater = {
#     enable = true;
#     description = "AppImage Menu Updater";
#     unitConfig = {
#       Type = "simple";
#     };
#     serviceConfig = {
#       ExecStart = "/bin/sh -c 'HOME=%h ${appimage-menu-updater}'";
#     };
#     wantedBy = [ "default.target" ];
#   };
# }

{
  writeShellScript,
  inotify-tools,
  p7zip
}:

writeShellScript "appimage-menu-updater.sh"
''
  shopt -s nullglob

  remove_old_files () {
    for path in "$HOME"/.local/share/applications/appimage-menu-updater*; do
      rm "$path"
    done
    for path in "$HOME"/.local/share/icons/hicolor/appimage-menu-updater*; do
      rm "$path"
    done
  }

  update_each () {
    path="$1"
    file="$2"

    echo "found $file"

    desktop_source=$(${p7zip.outPath}/bin/7z l -ba -slt "$path" | grep '\.desktop$' | head -n1 | sed --expression 's/Path = //')
    desktop_target="$HOME/.local/share/applications/appimage-menu-updater-$file.desktop"
    ${p7zip.outPath}/bin/7z e "$path" "$desktop_source" -y -so > "$desktop_target"
    sed -i "s@Exec=.*@Exec=appimage-run $path@" "$desktop_target"

    update_icon "$path" "$desktop_target"
  }

  update_icon () { # @TODO: split it somehow
    path="$1"
    desktop_target="$2"

    echo "updating icon"

    icon_link_proto_source=$(grep Icon= "$desktop_target" | head -n1 | sed 's/Icon=//')
    icon_link_source=$(${p7zip.outPath}/bin/7z l -ba -slt "$path"  | grep -e "Path = $icon_link_proto_source.\(png\|svg\)" | head -n1 | sed 's/Path = //')
    if [[ "$icon_link_source" ]]; then
      tempdir=$(mktemp -d)
      ${p7zip.outPath}/bin/7z x "$path" "$icon_link_source" -o"$tempdir" >/dev/null

      icon_temp_maybe_link=$(find "$tempdir"/* | head -n1)
      if [[ -L "$icon_temp_maybe_link" ]]; then
        icon_source=$(readlink "$icon_temp_maybe_link")

        if [[ "$icon_source" ]]; then
          ${p7zip.outPath}/bin/7z x "$path" "$icon_source" -y -o"$tempdir"
          if [[ -f "$tempdir/$icon_source" ]]; then
            icon_temp_source=$tempdir/$icon_source
          else
            echo 'icon link target does not exists'
          fi
        else
          echo 'icon link is invalid'
        fi

      else
        icon_temp_source=$icon_temp_maybe_link
      fi

      if [[ "$icon_temp_source" ]]; then
        icon_target="$HOME/.local/share/icons/hicolor/appimage-menu-updater-"$(basename "$icon_temp_source")
        mv "$icon_temp_source" "$icon_target"
        sed -i "s@Icon=.*@Icon=$icon_target@" "$desktop_target"
      fi

      rm -Rf "$tempdir"
    else
      echo 'icon file not found'
    fi
  }

  update () {
    echo 'updating...'

    remove_old_files

    for path in "$HOME"/Applications/*.AppImage; do
      update_each "$path" $(basename "$path")
    done
  }

  mkdir -p "$HOME/Applications"

  update
  while ${inotify-tools.outPath}/bin/inotifywait -e modify,delete,moved_to,moved_from "$HOME"/Applications; do
    update
  done
''
