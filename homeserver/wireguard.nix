{ config, pkgs, ... }:
let
  wg_port = 51820;
  interface = "wlp3s0";
in
{
  networking.nat.enable = true;
  networking.nat.externalInterface = "${interface}";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ wg_port ];
  };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "192.168.2.1/16" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = wg_port;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        				${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o ${interface} -j MASQUERADE
        				'';

      # This undoes the above command
      postShutdown = ''
        				${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 192.168.2.0/24 -o ${interface} -j MASQUERADE
        				'';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/root/wireguard-keys/private";

      peers = [
        # List of allowed peers.
        {
          # Feel free to give a meaning full name
          # Public key of the peer (not a file path).
          publicKey = "V800uE363aQPL8DVpX2f7+Rh9985RXMPulL+abDy438=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "192.168.2.2/32" ];
        }
      ];
    };
  };
}
