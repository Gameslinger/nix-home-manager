{ pkgs, ... }:
let
  i2p_ports = [
    4444
    4447
  ];
in
{
  networking.firewall.allowedTCPPorts = i2p_ports;

  services.i2pd = {
    enable = true;
    proto = {
      httpProxy = {
        enable = true;
        address = "0.0.0.0";
      };
      socksProxy.enable = true;
      http.enable = true;
    };
  };
}
