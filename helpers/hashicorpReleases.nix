pkgs: 
  {name, version, sha256}:
    with pkgs;
    let deriv = {
      name = name;
      src = pkgs.fetchurl {
        sha256 = sha256; 
        url = "https://releases.hashicorp.com/${name}/${version}/${name}_${version}_linux_amd64.zip";
      };
      nativeBuildInputs = [ unzip ];
      sourceRoot = ".";
      installPhase = ''
        mkdir -p $out/bin
        mv ${name} $out/bin
      '';    
    };
  in deriv
