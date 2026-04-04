{ config, pkgs, ... }:
let
  orangehrm = import ./orangehrm.nix { inherit pkgs; } {
    dbHost = "localhost";
    dbPort = "3306";
    dbName = "orangehrm";
    dbUser = "orange";
    dbPass = "helloWorld1234";
  };
in
{
  systemd.tmpfiles.rules = [
    "d /var/orangehrm 0755 wwwrun wwwrun -"
  ];
  services.httpd = {
    enable = true;
    enablePHP = true;
    phpPackage = pkgs.php83;
    virtualHosts."localhost" = {
      hostName = "localhost";
      documentRoot = orangehrm;
      extraConfig = ''
        				  DirectoryIndex index.php index.html

        				  <FilesMatch \.php$>
        				    SetHandler application/x-httpd-php
        				  </FilesMatch>

        				  <Directory "/var/www">
        				    AllowOverride All
        				    Require all granted
        				  </Directory>
        				'';
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 ];
  };
}
