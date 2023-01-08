{
  description = "";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = {self, ...} @ inputs:
    inputs.utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels: {
        # run with `nix fmt`
        formatter = channels.nixpkgs.writeShellApplication {
          name = "format";
          text = "treefmt";
          runtimeInputs = with channels.nixpkgs; [
            treefmt
            alejandra
          ];
        };

        devShells.default = channels.nixpkgs.mkShell {
          packages = with channels.nixpkgs; [
            # Formatting
            treefmt
            alejandra
          ];
        };
      };
    };
}
