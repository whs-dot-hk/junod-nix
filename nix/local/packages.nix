with inputs.nixpkgs; let
  arch = lib.removeSuffix "-linux" system;

  postInstall = ''
    for f in "$out"/bin/*; do
      local nrp="$(patchelf --print-rpath "$f" | sed -E 's@(:|^)'$NIX_BUILD_TOP'[^:]*:@\1@g')"
      patchelf --set-rpath "$nrp" "$f"
    done
  '';

  libwasmvm_1_5_1 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "1.5.1";
    src = fetchurl {
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.${arch}.so";
      sha256 =
        if arch == "x86_64"
        then "sha256-DfFpkL3WhLaMJhOcYpEVqDzEBhIDjIgFwz/cDj0hfZo="
        else "sha256-wsEsit3gD43zgYTNcFCjqeyVDKwpGfqohh9uCLtHOa8=";
    };
    dontBuild = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/lib
      cp $src $out/lib/libwasmvm.${arch}.so
    '';
  };
  libwasmvm_1_5_2 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "1.5.2";
    src = fetchurl {
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.${arch}.so";
      sha256 =
        if arch == "x86_64"
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
  junod_18_1_0 = buildGoModule rec {
    pname = "junod";
    version = "18.1.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-7i229NOdydHyrBpC20GeH6FWERHJuvgcbBkm6+PzlIw=";
    };
    vendorHash = "sha256-p4lWDRrmXOmB1x99f5/jHBKm3E1xbGowjIJs17gLIzI=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_1];
    inherit postInstall;
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
    inherit postInstall;
  };
  junod_19_1_0 = buildGoModule rec {
    pname = "junod";
    version = "19.1.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-q4KrO69oSKgBIeyr+dSvxCH+8LmmVO6x1SeYstRXY8Y=";
    };
    vendorHash = "sha256-gVdB0qjArLGI+HJgymrHBjbb10olUDqNbG/xKpVpfHM=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_2];
    inherit postInstall;
  };
  junod_20_0_0 = buildGoModule rec {
    pname = "junod";
    version = "20.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-Mjk7qNltAf3WFMb+VKfI/B7t5j85JlAE8E0WOKlm3h0=";
    };
    vendorHash = "sha256-gVdB0qjArLGI+HJgymrHBjbb10olUDqNbG/xKpVpfHM=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_2];
    inherit postInstall;
  };
  junod_21_0_0 = buildGoModule rec {
    pname = "junod";
    version = "21.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-FsuXf/O3QpmgHMvQurA8ZuMisYePvAStXvXoyH6wPps=";
    };
    vendorHash = "sha256-Z5I16c/qRTmJJzAjQp6vmUrSd2F+RV13UYHHnLnhFcE=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_2];
    inherit postInstall;
  };
  junod_22_0_0 = buildGoModule rec {
    pname = "junod";
    version = "22.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-t0x2YpcFCOiA48mcytpJ0ztwHeyU+ZkKp7WfkjasZHA=";
    };
    vendorHash = "sha256-5TTW7ftC5bQgdKOQJtmAQ8GyAuAtTmeFIl+hh12WX4M=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_2];
    inherit postInstall;
  };
  junod_22_0_1 = buildGoModule rec {
    pname = "junod";
    version = "22.0.1";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-zgTcdUImhc2ZUQyUZ3MdxbcWH1Z99rP3FFc2Iuc3T70=";
    };
    vendorHash = "sha256-5TTW7ftC5bQgdKOQJtmAQ8GyAuAtTmeFIl+hh12WX4M=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_2];
    inherit postInstall;
  };
in {
  inherit libwasmvm_1_5_1;
  inherit libwasmvm_1_5_2;
  inherit junod_18_1_0;
  inherit junod_19_0_0;
  inherit junod_19_1_0;
  inherit junod_20_0_0;
  inherit junod_21_0_0;
  inherit junod_22_0_0;
  inherit junod_22_0_1;
}
