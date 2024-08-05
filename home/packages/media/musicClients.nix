{pkgs, ...}:
{
  home.packages = with pkgs; [
    (callPackage ./plexamp{})
    audacious
    exaile
    rhythmbox
    picard
    playerctl
    strawberry
    finamp

  ];
}
