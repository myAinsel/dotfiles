{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "morgan";
  home.homeDirectory = "/home/morgan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.calibre
    pkgs.remmina
    pkgs.veracrypt
    pkgs.lutris
    pkgs.vlc
    pkgs.ptyxis
    pkgs.obsidian
    pkgs.bitwarden
    pkgs.zotero
    pkgs.standardnotes
    pkgs.discord
    pkgs.gnome.polari
    pkgs.protonmail-desktop
    pkgs.kdenlive
    pkgs.mission-center
    pkgs.yubioath-flutter
    pkgs.burpsuite
    pkgs.dwarf-fortress
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.gsconnect
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.logo-menu
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.tailscale-qs
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/morgan/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs = {
    firefox = {
      enable = true;
      enableGnomeExtensions = true;
      policies = {
        OfferToSaveLogins = false;
        FirefoxHome = {
          "SponsoredTopSites" = false;
          "Highlights" = false;
          "Pocket" = false;
          "SponsoredPocket" = false;
        };
      }; 
    };
    chromium = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "Morgan Ainsel";
      userEmail = "15658969+myAinsel@users.noreply.github.com";
      signing = {
        key = "";
      };
    };
    gpg = {
      enable = true;
      mutableKeys = true; # Possibly change this
    };
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      #extensions = with pkgs.vscode-extensions; [
      #  ms-python.python
      #  platformio.platformio-ide
      #  tailscale.vscode-tailscale
      # ftsamoyed.theme-pink-cat-boo
      #  #Catppuccin.catppuccin-vsc-icons
      #  #ms-vscode-remote.vscode-remote-extensionpack
      #  ms-vscode-remote.remote-ssh
      #  ms-vscode-remote.remote-containers
      #  ms-vscode.cpptools
      #  eamodio.gitlens
      #  vscodevim.vim
      #  bbenoist.nix
      #  github.codespaces
      #  dracula-theme.theme-dracula
      #  #rust-lang.rust-analyzer
      #];
    };
    hyfetch = {
      enable = true;
      settings = {
        preset = "lesbian"; # gay
        mode = "rgb";
      };
    };  
    
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      #catppuccin = { 
      #  enable = true;
      #  flavor = "frappe";
      #};
    };
    #kitty = { 
    #  catppuccin = {
    #    enable = true;
    #    flavor = "frappe";
    #  };
    #};
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "WhiteSur-pink-dark";
      package = pkgs.whitesur-icon-theme.override {
        boldPanelIcons = true;
        alternativeIcons = true;
        themeVariants = ["pink"];
      };
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = { 
        color-scheme = "prefer-dark";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
          appindicator.extensionUuid
          logo-menu.extensionUuid
          dash-to-dock.extensionUuid
          tailscale-qs.extensionUuid
        ];
       };
     };
  };
}
