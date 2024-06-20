{pkgs, ...}:
{

  services.emacs = {
    enable = true;
    client = {
      enable = true;
    };
    socketActivation.enable = true;
    startWithUserSession = true;
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraConfig = import ./emacs.el;
    extraPackages = epkgs: with epkgs; [
      magit
      evil            
      goto-chg        
      undo-tree       
      lsp-bridge
      yasnippet       
      acm-terminal    
      ace-popup-menu
      pulsar          
      workgroups2
      ivy             
      swiper
      counsel         
      sublimity       
      ef-themes       

      zoxide

      nixos-options
      nixpkgs-fmt
      nix-mode
      
                            
      auctex          
      auctex-latexmk  
      cdlatex         
      lsp-latex       

    ];
  };
}
