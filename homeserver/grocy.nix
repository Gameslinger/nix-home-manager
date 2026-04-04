{ config, pkgs, ... }:
let
  grocy_port = 3400;
  grocy_addr = "0.0.0.0";
in
{
  services.grocy = {
    enable = true;
    hostName = "grocy.tld";
    nginx.enableSSL = false;

  };

  services.nginx.virtualHosts."grocy.tld".listen = [
    {
      addr = grocy_addr;
      port = grocy_port;
    }
  ];
  networking.firewall.allowedTCPPorts = [ grocy_port ];

}
