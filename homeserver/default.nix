{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    #AllowedUsers = [ "gabe2max" ];
  };

  imports = [
    ./wireguard.nix
    #./grocy.nix
    ./nextcloud.nix
    #./grafana.nix
    ./sql.nix
    ./rdp.nix
    ./adguard.nix
    ./i2p.nix
  ];

}
