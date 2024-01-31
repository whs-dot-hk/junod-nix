with inputs.nixpkgs; let
  arch = lib.removeSuffix "-linux" system;

  libwasmvm_1_5_2 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "1.5.2";
    src = fetchurl {
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.${arch}.so";
      sha256 =
        if system == "x86_64-linux"
        then "sha256-sMO3YeXwDkW9r+vP6cA71wO4iz9TXJRMqOJ++biRzRA="
        else "sha256-fnaRRwg5cKAzVvurNvl2xfaeJiow9NspXlfEIM6o4DQ=";
    };
    dontBuild = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/lib
      cp $src $out/lib/libwasmvm.${arch}.so
    '';
  };
  junod_19_0_0 = buildGoModule rec {
    pname = "junod";
    version = "19.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-xplKbPjZtdyM4Wka6RIhCwcq94HqxI2VQZtcvebQmc0=";
    };
    vendorHash = "sha256-gVdB0qjArLGI+HJgymrHBjbb10olUDqNbG/xKpVpfHM=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_2];
    postInstall = ''
      for f in "$out"/bin/*; do
        local nrp="$(patchelf --print-rpath "$f" | sed -E 's@(:|^)'$NIX_BUILD_TOP'[^:]*:@\1@g')"
        patchelf --set-rpath "$nrp" "$f"
      done
    '';
  };
in {
  inherit libwasmvm_1_5_2;
  inherit junod_19_0_0;
}
