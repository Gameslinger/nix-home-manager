{ config, pkgs, ... }:
let
  port = 3000;
  address = "0.0.0.0";
in
{
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    mutableSettings = false;
    settings = {
      http.address = "${address}:${port}";
      users = [
        {
          name = "gabe2max";
          password = "$2a$10$4M1Tgl4LK6AW73i37CXpP.1EuEhztM9pOv1BOLnkvOiemA6BqKv1.";
        }
      ];
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        upstream_dns = [
          "https://dns10.quad9.net/dns-query"
        ];
        bootstrap_dns = [
          "9.9.9.10"
          "149.112.112.10"
          "2620:fe::10"
          "2620:fe::fe:10"
        ];
      };
      filters = [
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          id = 1;
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt";
          id = 2;
        }
      ];
    };
  };
}
