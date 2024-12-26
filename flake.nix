{
  description = "My Flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dedsec-grub-theme = {
      url = "gitlab:VandalByte/dedsec-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };


};

  outputs = { self, nixpkgs, hyprland-qtutils, ... }@inputs: {
    nixosConfigurations = {
      shadow = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/shadow/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
