{...}:
{
  programs.ssh.extraConfig = ''
    Host theodore-desktop
      HostName 180.150.104.138
      Port 22
      User theodoreknell

    Host lachlan-desktop
      HostName 180.150.104.138
      Port 9999
      User lachlan
    '';
}
