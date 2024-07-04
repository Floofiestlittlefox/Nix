{pkgs, ...}:
{
  home.packages = with pkgs; [
		prismlauncher
                (callPackage  ./catapult {})
  ];
}
