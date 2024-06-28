{pkgs, ...}:
{
  programs.texlive = {
    enable = true;
    packageSet = pkgs.texlive;
  };

  home.packages = with pkgs; [
    texlab
    pandoc
  ];
}
