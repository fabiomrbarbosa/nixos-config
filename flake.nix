{
  description = "NixOS configuration with flakes";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nix-flatpak.url = "github:gmodena/nix-flatpak";
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";      
  };

  outputs = { self, nixpkgs, flake-utils, nixos-hardware, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        # Other devShells or packages
      }) // {
      nixosConfigurations.marshmallow = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          #nix-flatpak.nixosModules.nix-flatpak 
  
          ./hosts/thinkpad-t480/configuration.nix
          ./modules/packages.nix
          #./modules/flatpak.nix
        ];
      };
    };
}
