{
  description = "My flake-based NixOS + Home Manager setup";

  # ============================================================================
  # Inputs
  # ============================================================================

  inputs = {
    # Core
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/release-25.05";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets Management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Tools & Applications
    factory-cli-nix.url = "github:GutMutCode/factory-cli-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  # ============================================================================
  # Outputs
  # ============================================================================

  outputs = inputs@{ self, flake-parts, nixpkgs, nixpkgs-2505, home-manager, nixvim, factory-cli-nix, sops-nix, ... }:
    let
      # Common overlays applied to all configurations
      defaultOverlays = [ factory-cli-nix.overlays.default ];

      # Shared Home Manager modules
      homeManagerSharedModules = [
        nixvim.homeModules.nixvim
        sops-nix.homeManagerModules.sops
      ];

      # Helper to create pkgs with common settings
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = defaultOverlays;
      };

      mkPkgsStable = system: import nixpkgs-2505 {
        inherit system;
        config.allowUnfree = true;
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];

      # ==========================================================================
      # Flake-level outputs
      # ==========================================================================

      flake = {
        # ------------------------------------------------------------------------
        # Library Functions
        # ------------------------------------------------------------------------

        lib = {
          # Standalone Home Manager configuration (e.g., for macOS)
          makeHomeManagerConfig = { system, username, modules ? [ ] }:
            home-manager.lib.homeManagerConfiguration {
              pkgs = mkPkgs system;
              extraSpecialArgs = { inherit inputs username; };
              modules = homeManagerSharedModules ++ modules;
            };

          # Full NixOS configuration with integrated Home Manager
          makeNixosConfig = { system, hostname, username, modules ? [ ] }:
            let
              pkgs = mkPkgs system;
              pkgsStable = mkPkgsStable system;
            in
            nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                { nixpkgs.overlays = defaultOverlays; }
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useUserPackages = true;
                    useGlobalPkgs = true;
                    users.${username} = import ./home-manager/${username}.nix;
                    extraSpecialArgs = { inherit pkgs pkgsStable system inputs username hostname; };
                    sharedModules = homeManagerSharedModules;
                  };
                }
              ] ++ modules;
            };
        };

        # ------------------------------------------------------------------------
        # NixOS Configurations
        # ------------------------------------------------------------------------

        nixosConfigurations = {
          obelix = self.lib.makeNixosConfig {
            system = "x86_64-linux";
            hostname = "obelix";
            username = "qlyine";
            modules = [ ./hosts/obelix/configuration.nix ];
          };
        };

        # ------------------------------------------------------------------------
        # Standalone Home Manager Configurations
        # ------------------------------------------------------------------------

        homeConfigurations = {
          dso17 = self.lib.makeHomeManagerConfig {
            system = "aarch64-darwin";
            username = "dso17";
            modules = [ ./home-manager/dso17-macos.nix ];
          };
        };
      };

      # ==========================================================================
      # Per-system outputs
      # ==========================================================================

      perSystem = { system, ... }: {
        legacyPackages.pkgs = mkPkgs system;
      };
    };
}
