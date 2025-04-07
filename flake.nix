{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    #hyprland.url = "github:hyprwm/Hyprland";

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-topology.url = "github:oddlama/nix-topology";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-topology, zen-browser, nixos-cosmic, ... } @ inputs:
  let
    host = "shadow";
    host2 = "reaper";
    username = "danny";
    system = "x86_64-linux";  # Define the system architecture here
    # Define pkgs with the necessary overlays
    pkgs = import nixpkgs {
      inherit system;
      overlays = [nix-topology.overlays.default];
    };

  in {

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
          inputs.nix-topology.nixosModules.default  # Add the nix-topology NixOS module here
          {
            nixpkgs = {
              overlays = [
                (final: prev: {
                  nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
                 })
              ];
            };
          }
        ];
      };
      "${host2}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host2;
        };
        modules = [
          ./hosts/${host2}/configuration.nix
          inputs.home-manager.nixosModules.default 
          inputs.dedsec-grub-theme.nixosModule
          nixos-cosmic.nixosModules.default 
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
            nixpkgs = {
              overlays = [
                (final: prev: {
                  nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
                 })
              ];
            };
          }
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
