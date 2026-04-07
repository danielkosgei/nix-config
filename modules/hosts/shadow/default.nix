{ self, inputs, ... }: {

  flake.nixosConfigurations.shadow = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.shadowConfiguration
    ];
  };
}
