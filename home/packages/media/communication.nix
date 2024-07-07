{pkgs, ...}:
{
  accounts.email.accounts.general = {
    address = "lachlanleoknell@gmail.com";
    thunderbird = {
      enable = true;
      profiles = "default";
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        name = "default";
      };
    };
  };
  home.packages = with pkgs; [
    element-desktop
  ];
  
}
