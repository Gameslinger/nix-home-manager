{ pkgs, ... }:
{
  users.users = {
    root = {
      initialHashedPassword = "$6$testingmkpasswd$92UTGe2RJgqjv9eC2TqGnsxSHD9GHtg.GhpNa5H/GVx.qBmic.CxawwUO0j5CDWN1zHCYKPl3huqaIvzNKyg2.";
    };

    gabe2max = {
      isNormalUser = true;
      name = "gabe2max";
      home = "/home/gabe2max";
      description = "Gabe Maxfield";
      shell = pkgs.zsh;
      group = "gabe2max";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "video"
        "audio"
        "input"
      ];
      # packages = with pkgs; [ ];
      initialHashedPassword = "$6$oSL/QHvUZomwXgaV$aMPrablrd1lDVJHS1ZZhBRGbdwAciBSyM6BShdsI7/KxaW3Ln8pWZtYioCkH.trAncft8DdjUIerh/i/hQR/3.";
      openssh.authorizedKeys.keyFiles = [ ./gabe2max.pub ];
    };
  };
  users.groups = {
    gabe2max = { };
  };
}
