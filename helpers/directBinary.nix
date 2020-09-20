pkgs: 
  {name, url, sha256}:
    with pkgs;
    let deriv = {
      inherit name;
      src = pkgs.fetchurl {
        inherit url sha256;
      };
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/$name
        chmod +x $out/bin/$name
      '';    
    };
  in deriv
