{
  description = "";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = {self, ...} @ inputs:
    inputs.utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels: let
        this-project-app = inputs.utils.lib.mkApp {drv = this-project;};
        this-project = channels.nixpkgs.buildGoModule {
          name = "this-project";
          version = "0.0";

          src = ./.;

          vendorSha256 = "sha256-pQpattmS9VmO3ZIQUFn66az8GSmB4IvYhTTCFn6SUmo=";
        };
      in {
        apps.this-project = this-project-app;
        apps.default = this-project-app;
        packages.this-project = this-project;
        packages.default = this-project;

        # run with `nix fmt`
        formatter = channels.nixpkgs.writeShellApplication {
          name = "format";
          text = "treefmt";
          runtimeInputs = with channels.nixpkgs; [
            treefmt
            gofumpt
            alejandra
          ];
        };

        devShells.default = channels.nixpkgs.mkShell {
          packages = with channels.nixpkgs; [
            go_1_19
            gopls

            # Formatting
            treefmt
            gofumpt
            alejandra
          ];
        };
      };
    };
}
