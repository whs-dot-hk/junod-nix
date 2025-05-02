with inputs.nixpkgs; let
  postInstall = ''
    for f in "$out"/bin/*; do
      local nrp="$(patchelf --print-rpath "$f" | sed -E 's@(:|^)'$NIX_BUILD_TOP'[^:]*:@\1@g')"
      patchelf --set-rpath "$nrp" "$f"
    done
  '';

  postFixup = ''
    mkdir -p $out/bin
    cp $src $out/bin/junod
    chmod +x $out/bin/junod
  '';

  libwasmvm_1_5_8 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "1.5.8";
    src = fetchurl {
      sha256 = "sha256-xFgTY+tvSrKrpfgLBfuUDd7Jkp7LzX/0vgxSGpPsfo4=";
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.x86_64.so";
    };
    dontBuild = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/lib
      cp $src $out/lib/libwasmvm.x86_64.so
    '';
  };
  junod_27_0_0 = buildGoModule rec {
    pname = "junod";
    version = "27.0.0";
    src = fetchurl {
      sha256 = "sha256-Enwi9ixFgj5HaDegQUHp68+wOzdKrwHHe4lYltmY0Zk=";
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
    };
    vendorHash = "sha256-Iwifl3Rlc+PaYNywz2cnIv/S5b6GuPzamSAYGcrkpRo=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_8];
    inherit postInstall;
  };
  junod_28_0_2 = stdenv.mkDerivation rec {
    pname = "junod";
    version = "28.0.2";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/releases/download/v${version}/junod";
      sha256 = "sha256-7x8AcT5msL3qUDc074cvFaNaBNKOGGdOZB8D/jVoNZc=";
    };
    dontUnpack = true;
    dontBuild = true;
    dontConfigure = true;
    dontInstall = true;
    dontPatch = true;
    dontPatchELF = true;
    inherit postFixup;
  };
in {
  inherit libwasmvm_1_5_8;
  inherit libwasmvm_2_2_2;
  inherit junod_27_0_0;
  inherit junod_28_0_2;
}
