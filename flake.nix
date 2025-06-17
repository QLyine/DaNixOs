{
  description = "My flake-based NixOS + Home Manager setup";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, home-manager, nixvim, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];

      flake = {
        lib = {
          makeHomeManagerConfig = { system, username, modules ? [] }:
            let
              pkgs = import inputs.nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
              nuScripts = pkgs.fetchFromGitHub {
                owner = "nushell";
                repo = "nu_scripts";
                rev = "32cdc96414995e41de2a653719b7ae7375352eef";
                sha256 = "sha256-vn/YosQZ4OkWQqG4etNwISjzGJfxMucgC3wMpMdUwUg=";
              };
            in
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit inputs username;
                nuCustomCompletions = "${nuScripts}/custom-completions";
              };
              modules = [
                nixvim.homeManagerModules.nixvim
              ] ++ modules;
            };

          makeNixosConfig = { system, hostname, username, modules ? [] }:
            let
              pkgs = import inputs.nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
              nuScripts = pkgs.fetchFromGitHub {
                owner = "nushell";
                repo = "nu_scripts";
                rev = "32cdc96414995e41de2a653719b7ae7375352eef";
                sha256 = "sha256-vn/YosQZ4OkWQqG4etNwISjzGJfxMucgC3wMpMdUwUg=";
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
                    inherit pkgs system inputs username hostname;
                    nuCustomCompletions = "${nuScripts}/custom-completions";
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

