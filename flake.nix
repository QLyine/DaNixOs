{
  description = "My flake-based NixOS + Home Manager setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nvf, zen-browser, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "qlyine";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Helper function to get the current hostname
      currentHostname = host: host.config.networking.hostName;

    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs (hostname: nxSys:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${hostname}/configuration.nix # Assumes you have per-host configs here
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home-manager/${username}.nix;
              home-manager.extraSpecialArgs = { # Pass hostname to home-manager modules
                inherit pkgs system inputs username hostname;
              };
            }
          ];
        }
      ) {
        # Define your hosts here
        "obelix" = { }; # Example for host "obelix"
        # "another-host" = { }; # Example for another host
        # The key (e.g., "obelix") will be the hostname
      };
    };
}

