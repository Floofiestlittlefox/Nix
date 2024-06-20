{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./services
    ../shared/
  ];
  networking.hostName = "lachlanDesktop";
}
