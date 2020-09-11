pkgs: 
  {name, url, sha256}:
    with pkgs;
    let deriv = {
      inherit name;
      src = pkgs.fetchurl {
        inherit url sha256;
      };
      nativeBuildInputs = [ unzip ];
      sourceRoot = ".";
      installPhase = ''
        mkdir -p $out/bin
        mv ${name} $out/bin
      '';
    };
  in deriv
