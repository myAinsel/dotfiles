{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "morgan";
  home.homeDirectory = "/home/morgan";
  imports = [
    <catppuccin/modules/home-manager>
  ];
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
    # Core Utilities
    pkgs.nautilus
    pkgs.loupe
    pkgs.vlc
    pkgs.ptyxis
    pkgs.libreoffice
    pkgs.mission-center
    
    # Media
    pkgs.calibre
    pkgs.kdenlive
    pkgs.audacity
    
    # Work Tools
    pkgs.android-studio
    pkgs.qtcreator
    pkgs.remmina
    pkgs.obsidian
    pkgs.burpsuite
    pkgs.standardnotes
    pkgs.veracrypt
    pkgs.zotero

    # Communication
    pkgs.discord
    pkgs.gnome.polari
    pkgs.protonmail-desktop
    
    # Other
    pkgs.yubioath-flutter
    pkgs.wineWowPackages.stable
    pkgs.bottles
    pkgs.bitwarden
    pkgs.dwarf-fortress
    pkgs.pika-backup
    pkgs.bibata-cursors

    # Gnome Extensions
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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "$terminal ranger";
      "$menu" = "wofi --show drun";
      "$ws1" = "1: term";
      "$ws2" = "2: code";
      "$ws3" = "3: write";
      "$ws4" = "4: browse";
      "$ws5" = "5: work";
      "$ws6" = "6. watch";
      monitor = [ 
        "DP-2,preferred,0x0,1"
        "eDP-1,preferred,auto-right,1"
      ];
      exec-once = [
        "hyprpaper"
        "hypridle"
        "pipewire"
        "wireplumber"
        "pipewire-pulse"
        "waybar"
        "mako"
      ];
      env = [
        "XCURSOR_THEME, Bibata-Modern-Classic"
        "XCURSOR_SIZE,20"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,20"
        "NIXOS_OZONE_WL,1"
      ];
      general = {
        gaps_in = 10;
        gaps_out = 10;
        border_size = 4;
        "col.active_border" = " rgba(ec0065ee) rgba(ea3a85ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 5;
        active_opacity = 1;
        inactive_opacity = 0.8;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      misc.force_default_wallpaper = 2;
      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, D, exec, $menu"
        "$mod, E, exec, $fileManager"
        "$mod SHIFT, Q, killactive," 
        "$mod ALT SHIFT, Q, exit"
        "$mod SHIFT, L, exec, hyprlock"
        "$mod, V, togglefloating"
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$mod, 1, workspace, name:$ws1"
        "$mod, 2, workspace, name:$ws2"
        "$mod, 3, workspace, name:$ws3"
        "$mod, 4, workspace, name:$ws4"
        "$mod, 5, workspace, name:$ws5"
        "$mod, 6, workspace, name:$ws6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod SHIFT, 1, movetoworkspace, name:$ws1"
        "$mod SHIFT, 2, movetoworkspace, name:$ws2"
        "$mod SHIFT, 3, movetoworkspace, name:$ws3"
        "$mod SHIFT, 4, movetoworkspace, name:$ws4"
        "$mod SHIFT, 5, movetoworkspace, name:$ws5"
        "$mod SHIFT, 6, movetoworkspace, name:$ws6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        
      ];

      # ++ (
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      #   builtins.concatLists (builtins.genList (
      #       x: let
      #         ws = let
      #           c = (x + 1) / 10;
      #         in
      #           builtins.toString (x + 1 - (c * 10));
      #       in [
      #         "$mod, ${ws}, workspace, ${toString (x + 1)}"
      #         "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      #       ]
      #     )
      #     10)
      # );
      bindm = [ 
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      windowrulev2 = "suppressevent maximize, class:.*";
    };
  };
  programs = {
    firefox = {
      enable = true;
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
      #mutableKeys = true; # Possibly change this
    };
    hyprlock = {
      enable = true;
      settings = {
        background = [
          {
            monitor="";
            path = "/home/morgan/dotfiles/Wallpapers/celestepeak.png";
            blur_passes = 2;
            blur_size = 5;
            brightness = 0.75;
          }
        ];
        label = [
          { 
            monitor = "";
            text = "$TIME";
            text_align = "center";
            color = "rgba(210,210,210,0.95)";
            font_size = 48;
            font_family = "Ubuntu";
            position = "640, 360";
            # halign = "center";
  #         # valign = "center";
          }
        ];
      };
    };
    waybar = {
      enable = true;
      settings = {
        mainBar = {
        height = 25;
        spacing = 8;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["privacy"];
        modules-right = ["pulseaudio" "network" "battery" "tray" "clock"];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1: term" = "";
            "2: code" = "󰅩";
            "3: write" = "󰼭";
            "4: browse" = "󰖟";
            "5: work" = "󰦑";
            "6: watch" = "";
            "urgent" = "󰈅";
            "focused" = "";
            "default" = "";
          };
        };
        "pulseaudio" = {
           "format-icons" = {
           "format" = "{icon} {volume}%";
             "headphones"= "";
             "default" = ["" ""];
 
           };
        };
        "network" = {
          "format-disconnected" = "󰌙";
          "format-ethernet" = "󰈀";
          "format-wifi" = " {signalStrength}";
          "tooltip-format-wifi" = "{essid}";
        };
        "battery" = {
          "format" = "{icon}";
          "states" = {
           "warning" = 20;
           "critical" = 10;
          };
          "tooltip-format" = "{capacity}%" ;
          "format-icons"= ["" "" "" "" ""];
        };
 
       };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: Ubuntu Nerd Font;
          font-size: 14px;
          min-height: 0;
        }
        window#waybar {
         background: transparent;
         color: white; 
         border-bottom: 2px solid gray;
        }
        #window {
          font-weight: bold;
          font-family: "Ubuntu";
        }
        #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-top: 2px solid transparent;
        }
        #workspaces button.focused {
            color: #c9545d;
            border-top: 2px solid #c9545d;
        }
        
        #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
          padding: 0 3px;
          margin: 0 2px;
        }
        #battery {
        }
        #clock {
        }
        #pulseaudio {
        }
        #network {
        }
      '';
    };
    wofi = {
      enable = true;
    };
    vscode = {
      enable = true;
      mutableExtensionsDir = false;
      #package = pkgs.vscode.fhs;
      # I'll set this up Nixy-style when I figure out packaging
      extensions = with pkgs.vscode-extensions; [
       ms-python.python
      #  platformio.platformio-ide
       tailscale.vscode-tailscale
      # ftsamoyed.theme-pink-cat-boo
      catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
      #  #ms-vscode-remote.vscode-remote-extensionpack
       ms-vscode-remote.remote-ssh
       ms-vscode-remote.remote-containers
       ms-vscode.cpptools
       eamodio.gitlens
       vscodevim.vim
       bbenoist.nix
       github.codespaces
       #rust-lang.rust-analyzer
      ];
    };
    hyfetch = {
      enable = true;
      settings = {
        preset = "lesbian"; # gay
        mode = "rgb";
        color_align.mode = "horizontal";
        brightness = 0.57;
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
      catppuccin = { 
        enable = true;
        flavor = "frappe";
      };
      #settings = builtins.fromTOML (builtins.readFile "/home/morgan/starship.toml");
      # settings = {
        # format = lib.concatStrings [
          # "[](#9A348E)"
          # "$os"
          # "$username"
          # "[](#9A348E)"
          # "$directory"
          # "[](fg:#DA627D bg:#FCA17D)"
          # "$git_branch"
          # "$git_status"
          # "[](fg:#FCA17D bg:#86BBD8)"
          # "$c"
          # "$elixir"
          # "$elm"
          # "$golang"
          # "$gradle"
          # "$haskell"
          # "$java"
          # "$julia"
          # "$nodejs"
          # "$nim"
          # "$rust"
          # "$scala"
          # "[](fg:#86BBD8 bg:#06969A)"
          # "$docker_context"
          # "[](fg:#06969A bg:#33658A)"
          # "$time"
          # "[ ](fg:#33658A)"
        # ];
        # add_newline = false;
        # username = {
          # show_always = true;;
          # style_user = "bg:#9A348E";
          # style_root = "bg:#9A348E";
          # format = "[$user ]($style)";
          # disabled = false;
        # };
        # directory = 
      # };
    };
    kitty = { 
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "Fira Code Retina";
        size = 12;
      };
      catppuccin = {
        enable = true;
        flavor = "frappe";
      };
    };
    ranger = {
      enable = true;
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    gh = {
      enable = true;
    };
  };
  services = {
   hyprpaper = {
     enable = true;
     settings = { 
       preload = "/home/morgan/Pictures/Wallpapers/celestepeak.png";
       wallpaper = ",/home/morgan/Pictures/Wallpapers/celestepeak.png";
     };
   };
   mako = {
     enable = true;
     anchor = "top-right";
   };
   hypridle = {
     enable = true;
     settings = {
       general = {
         lock_cmd = "pidof hyprlock || hyprlock";       # avoid starting multiple hyprlock instances.
         before_sleep_cmd = "hyprlock";   # lock before suspend.
         after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
       };
       listener = [
         {
           timeout = 120;
           on-timeout = "systemctl suspend";
         }
       ];
     };
   };
  };
  #  systemd = {
  #    user.services.polkit-gnome-authentication-agent-1 = {
  #      description = "polkit-gnome-authentication-agent-1";
  #      wantedBy = ["graphical-session.target"];
  #      wants = ["graphical-session.target"];
  #      after = ["graphical-session.target"];
  #      serviceConfig = {
  #        Type = "simple";
  #        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #        Restart = "on-failure";
  #        RestartSec = 1;
  #        TimeoutStopSec = 10;
  #      };
  #   };
  #};
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    font = {
      name = "Ubuntu";
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
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = { 
        cursor-theme = "Bibata-Modern-Classic";
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
  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
  #  #configPackages = [
    #  pkgs.xdg-desktop-portal-hyprland
    #  pkgs.xdg-desktop-portal-gtk
    #];
  #};
}
