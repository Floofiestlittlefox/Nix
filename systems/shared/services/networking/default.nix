{lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    sshuttle
  ];
  services = {
    samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;
      extraConfig = ''
        workgroup = WORKGROUP
        server string = smbnix
        netbios name = smbnix
        security = user 
        #use sendfile = yes
        #max protocol = smb2
        # note: localhost is the ipv6 localhost ::1
        hosts allow = 192.168.0. 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
        guest account = nobody
        map to guest = bad user
       '';
      shares = {
        public = {
            path = "/mnt/Shares/Public";
            browseable = "yes";
            "read only" = "no";
            "guest ok" = "yes";
            "create mask" = "0644";
            "directory mask" = "0755";
            "force user" = "username";
            "force group" = "groupname";
        };
        private = {
            path = "/mnt/Shares/Private";
            browseable = "yes";
            "read only" = "no";
            "guest ok" = "no";
            "create mask" = "0644";
            "directory mask" = "0755";
            "force user" = "username";
            "force group" = "groupname";
        };
      };
    };

    samba-wsdd = {
        enable = true;
        openFirewall = true;
    };
    
    gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome3.gvfs;
    };

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = true;
        PermitRootLogin = "prohibit-password";
      };
    };
    openvpn.servers = {
      homeVPN = { config = '' config ./client.ovpn ''; };
    };
    # Printing
    printing = {
      enable = true;
      drivers = [pkgs.cups-dymo];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  networking = {
      networkmanager.enable = true;
      firewall= {
        enable = true;
        allowPing = true;
        allowedTCPPorts = lib.mkDefault [ 22 ];
      };
      resolvconf.enable = true;
    };

  programs.mtr.enable = true;
}
