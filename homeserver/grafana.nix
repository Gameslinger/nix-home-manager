{ configs, pkgs, ... }:

let
  grafana_port = 3402;
in
{
  networking.firewall = {
    allowedTCPPorts = [ grafana_port ];
  };
  services.grafana = {
    enable = true;
    settings = {
      server = {
        # Listening Address
        http_addr = "0.0.0.0";
        # and Port
        http_port = grafana_port;
        # Grafana needs to know on which domain and URL it's running
        domain = "localhost";
        #root_url = "https://your.domain/grafana/"; # Not needed if it is `https://your.domain/`
        #serve_from_sub_path = true;
        security.secret_key = "SW2YcwTIb9zpOOhoPsMm";
      };
    };
  };

}
