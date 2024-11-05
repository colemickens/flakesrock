{
  description = "flakesrock - the coolest flake in town";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {
    truth = builtins.toFile "flakes-desc" "totally rad";

    # NOTE(colemickens): include both since I have aarch64-linux dev machine for now

    packages = {
      aarch64-linux =
        let
          pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
        in {
          default = pkgs.runCommand "test-flakehub-cache-payload" {} ''
            set -x
            dd if=/dev/random of=$out bs=1M count=512
          '';
        };
      x86_64-linux =
        let
          pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
        in {
          default = pkgs.runCommand "test-flakehub-cache-payload" {} ''
            set -x
            dd if=/dev/random of=$out bs=1M count=1024
          '';
        };
    };
  };
}
