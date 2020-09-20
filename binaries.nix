let
  pkgs = import <nixpkgs> {};
  hashicorpReleases = import ./helpers/hashicorpReleases.nix pkgs;
  directBin = import ./helpers/directBinary.nix pkgs;
  directZip = import ./helpers/directZip.nix pkgs;
  directGZip = import ./helpers/directGZip.nix pkgs;
in 
  let 
    terraform = pkgs.stdenv.mkDerivation (hashicorpReleases {
      name = "terraform";
      sha256 = "6c1c6440c5cb199e85926aea65773450564f501fddcd7876f453ba95b45ba746";
      version = "0.13.2";
    });

    packer = pkgs.stdenv.mkDerivation (hashicorpReleases {
      name = "packer";
      sha256 = "089fc9885263bb283f20e3e7917f85bb109d9335f24d59c81e6f3a0d4a96a608";
      version = "1.6.2";
    });

    vagrant = pkgs.stdenv.mkDerivation (hashicorpReleases {
      name = "vagrant";
      version = "2.2.10";
      sha256 = "4d3358abae81459ffda06699d7589b708b508f8711e3f2ff6fabd5ce89c0e7b0";
    });

    kind = pkgs.stdenv.mkDerivation (directBin {
      name = "kind";
      sha256 = "1g4n9ml8qls9rn7wxz7bhfsh99fijqca7iy2nxhx21dqg6s3s73q";
      url = "https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64";
    });

   terraform-ls = pkgs.stdenv.mkDerivation (directZip {
      name = "terraform-ls";
      sha256 = "0nw5gdhd6an6k9apgzpsncx9m3n4naw760wbgl8b3m7wwhx7sf0v";
      url = "https://releases.hashicorp.com/terraform-ls/0.7.0/terraform-ls_0.7.0_linux_amd64.zip";
    });

    haskell-language-server-wrapper = pkgs.stdenv.mkDerivation (directGZip {
      name = "haskell-language-server-wrapper";
      sha256 = "026hmd6c8ilf7p5h3rk63ywd358hm0xbmniplnkdfilgri3j26sm";
      url = "https://github.com/haskell/haskell-language-server/releases/download/0.4.0/haskell-language-server-wrapper-Linux.gz";
    });

    haskell-language-server = pkgs.stdenv.mkDerivation (directGZip {
      name = "haskell-language-server";
      sha256 = "0d4lwfy3ywrmz5qppzq11khk9n9744zrmgp5nl618dcl5di1w0aa";
      url = "https://github.com/haskell/haskell-language-server/releases/download/0.4.0/haskell-language-server-Linux-8.6.5.gz";
    });

   elm = pkgs.stdenv.mkDerivation (directGZip {
      name = "elm";
      sha256 = "0p0m1xn4s4rk73q19fz1bw8qwhm6j3cqkrbq6jbmlwkzn8mzajp4";
      url = "https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz";
    });


  
  in [
  terraform 
  packer
  vagrant
  kind
  terraform-ls
  elm
 # haskell-language-server-wrapper
 # haskell-language-server
  ]
