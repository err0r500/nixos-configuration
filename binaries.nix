let
  pkgs = import <nixpkgs> {};
  hashicorpReleases = import ./hashicorpReleases.nix pkgs;
  directBin = import ./directBinary.nix pkgs;
in 
  let terraform = pkgs.stdenv.mkDerivation (hashicorpReleases {
    name = "terraform";
    sha256 = "6c1c6440c5cb199e85926aea65773450564f501fddcd7876f453ba95b45ba746";
    version = "0.13.2";
  });
  packer = pkgs.stdenv.mkDerivation (hashicorpReleases {
    name = "packer";
    sha256 = "089fc9885263bb283f20e3e7917f85bb109d9335f24d59c81e6f3a0d4a96a608";
    version = "1.6.2";
  });
  kind = pkgs.stdenv.mkDerivation (directBin {
    name = "kind";
    sha256 = "1g4n9ml8qls9rn7wxz7bhfsh99fijqca7iy2nxhx21dqg6s3s73q";
    url = "https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64";
  });
  in [
  terraform 
  packer
  kind
  ]
