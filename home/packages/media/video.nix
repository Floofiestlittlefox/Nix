{pkgs, ...}:
{
  home.packages = with pkgs; [
		kdenlive
		mpv
		obs-studio
		yt-dlp
  ];
}
