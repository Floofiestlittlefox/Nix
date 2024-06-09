{pkgs, lib, inputs, ...}:
{
  imports = [
    inputs.walker.homeManagerModules.walker
  ];
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      placeholder = "Search...";
      fullscreen = false;
      list = {
        height = 200;
      };
      align = {
        ignore_exclusive=false;
        horizontal = "center";
        vertical = "start";
        width = 400;
        anchors = {
          top = true;
          left = true;
        };
        margins = {
          left = 10;
        };
      };
      modules = [
        {
          name = "runner";
          prefix = "";
        }
        {
          name = "applications";
          prefix = "";
        }
        {
         name = "ssh";
            prefix = "";
            switcher_exclusive = true;
          }
          {
            name = "finder";
            prefix = "";
            switcher_exclusive = true;
          }
          {
            name = "commands";
            prefix = "";
            switcher_exclusive = true;
          }
        {
          name = "switcher";
          prefix = "/";
        }
        {
          name = "websearch";
          prefix = "?";
        }
      ];
    };
  };
}
