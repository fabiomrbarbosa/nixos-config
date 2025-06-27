{
  description = "NixOS configuration with flakes";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
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
