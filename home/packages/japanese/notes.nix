{pkgs, ... }:

{
  home.packages = with pkgs; [
    tagainijisho
    kanjidraw
    jiten
    xournalpp
  ];
}
