{inputs}:
{
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      placeholder = "Search...";
      fullscreen = true;
      list = {
        height = 200;
      };
    };
  };
}
