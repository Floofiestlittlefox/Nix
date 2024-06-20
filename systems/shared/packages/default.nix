{pkgs, inputs, ...}:
{
  nixpkgs.overlays = [
    inputs.nixneovimplugins.overlays.default
    inputs.emacs-overlay.overlays.default
    inputs.nur.overlay
  ];
  environment.systemPackages = with pkgs; [
    bat
    btop
    fd
    cmake
    fzf
    gcc
    gnumake
    gtk-engine-murrine
    htop
    networkmanagerapplet
    ninja
    polkit
    python3
    sassc
    tree
    wget
    zip
  ];
}
