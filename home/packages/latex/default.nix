{pkgs, ...}:
{
  programs.texlive = {
    enable = true;
    packageSet = pkgs.texlive.combined.scheme-full;
  };

  home.packages = with pkgs; [
    texlab
		pandoc
  ];
}
