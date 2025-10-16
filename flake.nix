{
  description = "My flake-based NixOS + Home Manager setup";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/release-25.05"; # stable branch 25.05
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, nixpkgs-2505, home-manager, nixvim, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];

      flake = {
        lib = {
          makeHomeManagerConfig = { system, username, modules ? [ ] }:
            let
              pkgs = import inputs.nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
            in
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit inputs username;
              };
              modules = [
                nixvim.homeManagerModules.nixvim
              ] ++ modules;
            };

          makeNixosConfig = { system, hostname, username, modules ? [ ] }:
            let
              pkgs = import inputs.nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
              pkgsStable = import inputs.nixpkgs-2505 {
                inherit system;
                config.allowUnfree = true;
              };
            in
            nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                home-manager.nixosModules.home-manager
                {
                  home-manager.useUserPackages = true;
                  home-manager.useGlobalPkgs = true;
                  home-manager.users.${username} = import ./home-manager/${username}.nix;
                  home-manager.extraSpecialArgs = {
                    inherit pkgs system inputs username hostname pkgsStable;
                  };
                  home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
                }
              ] ++ modules;
            };
        };

        nixosConfigurations = {
          obelix = self.lib.makeNixosConfig {
            system = "x86_64-linux";
            hostname = "obelix";
            username = "qlyine";
            modules = [ ./hosts/obelix/configuration.nix ];
          };
        };

        homeConfigurations = {
          "dso17" = self.lib.makeHomeManagerConfig {
            system = "aarch64-darwin";
            username = "dso17";
            modules = [ ./home-manager/dso17-macos.nix ];
          };
        };
      };

      perSystem = { system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          legacyPackages = { inherit pkgs; };
        };
    };
}

