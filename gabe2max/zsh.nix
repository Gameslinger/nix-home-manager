{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    oh-my-zsh
    bat
    eza
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    initContent =
      let
        PS1 = lib.mkOrder 1500 "export PS1=\"%F{green}%n%f:%F{blue}%m%f[%F{red}%~%f]>\"";
        EDITOR = lib.mkOrder 1501 "export EDITOR=\"nvim\"";
      in
      lib.mkMerge [
        PS1
        EDITOR
      ];
    shellAliases = {
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      grep = "grep --color=auto";
      vi = "vim -u NONE";
      xzegrep = "xzegrep --color=auto";
      xzfgrep = "xzfgrep --color=auto";
      xzgrep = "xzgrep --color=auto";
      zegrep = "zegrep --color=auto";
      zfgrep = "zfgrep --color=auto";
      zgrep = "zgrep --color=auto";
      ip = "ip -c";
      diff = "colordiff";
      cat = "bat";
      ls = "eza --icons=always --color=always -s type";
      vim = "nvim";
    };
  };
}
