{ config, pkgs, ... }:
let
  nextcloud_port = 3401;
  nextcloud_addr = "0.0.0.0";
in
{
  environment.etc."nextcloud-admin-pass".text = "helloWorld1234";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    hostName = "nextcloud.tld";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    settings.trusted_domains = [
      "0.0.0.0"
      "*"
    ];
  };

  services.nginx.virtualHosts."nextcloud.tld".listen = [
    {
      addr = nextcloud_addr;
      port = nextcloud_port;
    }
  ];

  networking.firewall.allowedTCPPorts = [ nextcloud_port ];
}
