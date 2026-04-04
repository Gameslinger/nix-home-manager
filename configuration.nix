# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./users.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";

  # Bootloader.
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 3;
  #boot.loader.timeout = null;
  #boot.loader.systemd-boot.enable = true;
  boot.loader.grub.extraEntries = ''
         menuentry "Boot to UEFI" {
    	fwsetup
         }
  '';

  networking.hostName = "Zeus";
  networking.hostId = "8425e349";
  # Set your time zone.
  time.timeZone = "America/Las_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  #services.xserver = {
  #        enable = true;
  #        xkb.layout = "us";
  #        xkb.variant = "";
  #        desktopManager.plasma6.enable = true;
  #};

  #services.displayManager = {
  #        sddm.enable = true;
  #        defaultSession = "plasmawayland";
  #};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    tmux
    nmap
    iotop
    lsof
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  virtualisation.podman.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  #programs.nix-dl.libraries = with pkgs; [
  #];
  programs.kdeconnect.enable = true;

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.dbus.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # Firewall
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 53 ];
    #   allowedTCPPortRanges = [
    #      {from=1714; to=1764;} # KDE Connect
    #   ];
    #   allowedUDPPortRanges = [
    #      {from=1714; to=1764;} # KDE Connect
    #   ];
  };

  # DNS Settings
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager = {
      dns = "none";
      enable = true;
    };
  };

  nix.gc = {
    automatic = true;
    dates = "14d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  system.autoUpgrade.enable = true;
}
