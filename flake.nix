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
      username = "qlyine"; # Assuming this is for Linux

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # Variables for macOS Home Manager
      darwinSystem = "aarch64-darwin"; # Or "x86_64-darwin" for Intel Macs
      darwinUsername = "dso17";
      pkgsDarwin = import nixpkgs {
        system = darwinSystem;
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

      # Home Manager configuration for standalone macOS
      homeConfigurations."${darwinUsername}" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsDarwin; # Use pkgs for the Darwin system
        extraSpecialArgs = {
          inherit inputs;
          username = darwinUsername;
          # You can add hostname here if needed by your configs, e.g.:
          # hostname = "your-mac-hostname"; 
        };
        modules = [
          ./home-manager/${darwinUsername}-macos.nix
          # You can add common home-manager modules here if you have them
          # e.g., ./home-manager/common/some-common-settings.nix
        ];
      };
    };
}

