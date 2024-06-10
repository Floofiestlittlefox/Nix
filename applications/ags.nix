{pkgs, inputs}:
{
  imports = [
    inputs.ags.homeManagerModules.defaults
  ];

  programs.ags = {
    enable = true;

    configDir = ./ags;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      bun
    ];
  };
}
