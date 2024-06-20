{...}:
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
      nativeMessagingHosts.packages = [ pkgs.firefox.pwa];
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
  }
