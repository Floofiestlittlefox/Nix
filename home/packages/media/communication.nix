{pkgs, ...}:
{
  accounts.email.accounts.general = {
    address = "lachlanleoknell@gmail.com";
    thunderbird = {
      enable = true;
      profiles = [ "default" ];
    };
    primary = true;
    realName = "Lachlan Knell";
  };

  programs.thunderbird = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };
  home.packages = with pkgs; [
    element-desktop
  ];
  
}
