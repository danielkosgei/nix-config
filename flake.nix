{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland.url = "github:hyprwm/Hyprland";

    nvf.url = "github:notashelf/nvf";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-topology.url = "github:oddlama/nix-topology";
  };

  outputs = { self, nixpkgs, nixos-hardware, nvf, nix-topology, ... } @ inputs: 
  let
    host = "shadow";
    username = "danny";
    system = "x86_64-linux";  # Define the system architecture here
    # Define pkgs with the necessary overlay for nix-topology
    pkgs = import nixpkgs {
      inherit system;
      overlays = [nix-topology.overlays.default];
    };

  in {
    # Define your default packages, such as Neovim in this case
    packages."x86_64-linux".default =
      (nvf.lib.neovimConfiguration {
        pkgs = pkgs.legacyPackages."x86_64-linux";
        modules = [./modules/home-manager/development/nvf.nix];
      })
      .neovim;

    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
           inherit inputs;
           inherit username;
           inherit host;
        };
        modules = [
          ./hosts/${host}/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.dedsec-grub-theme.nixosModule
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
          inputs.nvf.nixosModules.default
          inputs.nix-topology.nixosModules.default  # Add the nix-topology NixOS module here
        ];
      };
    };

    # Define topology output for the system
    topology.x86_64-linux = import nix-topology {
      inherit pkgs;  # Make sure pkgs includes the nix-topology overlay
      modules = [
        ./topology.nix  # Define your custom global topology configuration
        { nixosConfigurations = self.nixosConfigurations; }  # Use existing NixOS configurations
      ];
    };
  };
}
