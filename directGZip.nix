pkgs: 
  {name, url, sha256}:
    with pkgs;
    let deriv = {
      inherit name gzip;
      src = pkgs.fetchurl {
        inherit url sha256;
      };
      phases = [ "installPhase" ];
      nativeBuildInputs = [
        autoPatchelfHook # Automatically setup the loader, and do the magic
      ];
      installPhase = ''
        mkdir -p $out/bin
        gzip -dc $src > $out/bin/${name}
        chmod +x $out/bin/${name}
      '';
    };
  in deriv
