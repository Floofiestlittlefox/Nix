{...}:
{
  programs.git = {
    enable = true;
    userName = "Lachlan Knell";
    userEmail = "lachlanleoknell@gmail.com";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = false;
      };
    };
  };
}
