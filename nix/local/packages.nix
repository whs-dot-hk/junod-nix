with inputs.nixpkgs; let
  postInstall = ''
    for f in "$out"/bin/*; do
      local nrp="$(patchelf --print-rpath "$f" | sed -E 's@(:|^)'$NIX_BUILD_TOP'[^:]*:@\1@g')"
      patchelf --set-rpath "$nrp" "$f"
    done
  '';

  libwasmvm_2_2_2 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "2.2.2";
    src = fetchurl {
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.x86_64.so";
      sha256 = "sha256-xtVXsOrNX+vlNWuxyh0JhJzjXbH5+tTvMQL5uslv8NY=";
    };
    dontBuild = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/lib
      cp $src $out/lib/libwasmvm.x86_64.so
    '';
  };
  junod_28_0_2 = buildGoModule rec {
    pname = "junod";
    version = "28.0.2";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-K5KziwhRlBjZPQF+MoW5jQdXIhxQWcxjG2HFgZfEiHE=";
    };
    vendorHash = "sha256-Fd1o4vt9Q0Oc2DT4Yh8A1QM0lqfoBhDggOopvrDkr44=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_2_2_2];
    inherit postInstall;
  };
in {
  inherit libwasmvm_2_2_2;
  inherit junod_28_0_2;
}
