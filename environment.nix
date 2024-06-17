{config, ...}:
{
    environment.sessionVariables = rec {
        XDG_CACHE_HOME  = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";
	CALIBRE_USE_SYSTEM_THEME = "1";

	QT_QPA_PLATFORM = "wayland";
        GDK_BACKEND     = "wayland";

        QT_IM_MODULE="fcitx";
        QT5_IM_MODULE="fcitx";
        GTK_IM_MODULE="fcitx";

        #  Not officially in the specification
        XDG_BIN_HOME    = "$HOME/.local/bin";
        PATH = [ 
        "${XDG_BIN_HOME}"
        ];
    };
}
