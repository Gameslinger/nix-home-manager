{
  config,
  pkgs,
  nixvim,
  extensions,
  ...
}:

{
  home.username = "gabe2max";
  home.homeDirectory = "/home/gabe2max";

  imports = [
    nixvim.homeManagerModules.nixvim
    ./zsh.nix
    ./nvim.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = [
      extensions.vscode-marketplace.golang.go
      extensions.open-vsx-release.rust-lang.rust-analyzer
    ];
  };

  home.packages = with pkgs; [
    #android-studio-stable
    #apache tika # Not on repo
    #arduino
    #audacity
    bat
    #blender
    #brave
    colordiff
    delta # Diff with syntax highlighting
    #discord
    dust
    eza
    #flameshot
    gcc
    #gimp
    gthumb
    hunspell
    hunspellDicts.en_US
    #inkscape
    #kalgebra
    libreoffice-qt
    librewolf
    #neovim
    obsidian
    #obs-studio
    #octave
    ripgrep # Faster version of grep
    rustup
    #slack
    #steam
    #tigervnc
    tldr
    tor-browser
    vlc
    vscodium
    #wireshark-qt
    #xournalpp
    #XP Pen for graphics tablet
    #zoom-us
    zoxide
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.brave; # unstable.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # Grammarly
    ];
    commandLineArgs = [
    ];
    #extraopts = {
    #	"OsColorMode" = "dark";
    #};
  };

  programs.git = {
    enable = true;
    userName = "Gabe Maxfield";
    userEmail = "gabe2max@gmail.com";
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
      };
    };
  };

}
