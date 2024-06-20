{pkgs,...}:
{
    il8n.inputMethod = {
        defaultLocale = "en_AU.UTF-8";
        inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
        ];
       };
    };
    gtk = {
        gtk2.extraConfig = ''
                         gtk-im-module=fcitx
        '';
        gtk3.extraConfig = {
          gtk-im-module="fcitx";
        };
        gtk4.extraConfig = { 
            gtk-im-module="fcitx";
        };
    };
}
