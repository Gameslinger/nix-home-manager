{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }@inputs:
    {
      nixosConfigurations."Zeus" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./homeserver
          ./orangehrm
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = {
              gabe2max = ./gabe2max;
              root =
                { nixvim, ... }:
                {
                  home.stateVersion = "23.11"; # Please read the comment before changing.
                  imports = [
                    nixvim.homeManagerModules.nixvim
                    ./gabe2max/nvim.nix
                  ];
                };
            };
            home-manager.extraSpecialArgs = {
              extensions = inputs.nix-vscode-extensions.extensions.${system};
              inherit nixvim;
            };
          }
        ];
      };
    };
}
