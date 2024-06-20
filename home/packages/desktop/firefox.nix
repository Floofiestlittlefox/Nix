{pkgs, ...}:
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
          ];
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
            "browser.search.isUS" = false;
            "browser.search.region" = "AU";
            "browser.newtabpage.pinned" = [{
              title = "NixOS";
              url = "https://nixos.org";
            }];
          };
        };
      };
    };
  };
 }
