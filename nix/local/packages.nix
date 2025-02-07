with inputs.nixpkgs; let
  #arch = lib.removeSuffix "-linux" system;
  arch = "aarch64";

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
  libwasmvm_1_5_4 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "1.5.4";
    src = fetchurl {
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.${arch}.so";
      sha256 =
        if arch == "x86_64"
        then "sha256-HapjAZsDmXpLSUeD57iG9EFyB9fVoGN3BGBBMBlSJ5I="
        else "sha256-cEscVHXqNVbcCAv2rjTaygpMGaawfHic8TGJoGUHd30=";
    };
    dontBuild = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/lib
      cp $src $out/lib/libwasmvm.${arch}.so
    '';
  };
  libwasmvm_1_5_5 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "1.5.5";
    src = fetchurl {
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.${arch}.so";
      sha256 =
        if arch == "x86_64"
        then "sha256-yqozWJzGsCStJHZ3HGUHoSQkfui6EKstmxtiAW4KoyE="
        else "sha256-ibF+okvXaWPa45DNkXHjlKAnYWO1gaQqO3dczWjv5rc=";
    };
    dontBuild = true;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/lib
      cp $src $out/lib/libwasmvm.${arch}.so
    '';
  };
  libwasmvm_1_5_8 = stdenv.mkDerivation rec {
    pname = "libwasmvm";
    version = "1.5.8";
    src = fetchurl {
      url = "https://github.com/CosmWasm/wasmvm/releases/download/v${version}/libwasmvm.${arch}.so";
      sha256 =
        if arch == "x86_64"
        then "sha256-xFgTY+tvSrKrpfgLBfuUDd7Jkp7LzX/0vgxSGpPsfo4="
        else "sha256-VCX6GobOmiyrtI5zDAgsRtdEaTiU8uBRtkIUIw6+pWw=";
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
  junod_23_0_0 = buildGoModule rec {
    pname = "junod";
    version = "23.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-HYLfhYiZPSERpAeTlmo5JpWOwboARszFSEqtunVPD3A=";
    };
    vendorHash = "sha256-oyxW/xvZne3Ybf+1tUUk2qP2gkjGuzdHjWYunXQB8g8=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_2];
    inherit postInstall;
  };
  junod_23_1_0 = buildGoModule rec {
    pname = "junod";
    version = "23.1.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-beasqFnVrZ/ZXu4T+bWLaGjEYXi3GgngCb9AtVKtpVU=";
    };
    vendorHash = "sha256-XDFhPFAe/UtlRFy+xWJlJ2fn+V39fVxZ20oX7oF1i5Q=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_4];
    inherit postInstall;
  };
  junod_24_0_0 = buildGoModule rec {
    pname = "junod";
    version = "24.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-wK2Uf/G0N+Tcxv+5I4fMBcFI2QMBU+HmMfSFRUdkgVs=";
    };
    vendorHash = "sha256-srBwnVyOx6Zt6n2e6WhZd+uHWNnpyv6fQTi1A9jsVd0=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_4];
    inherit postInstall;
  };
  junod_25_0_0 = buildGoModule rec {
    pname = "junod";
    version = "25.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-ElU53nRQXagFSSiICRiSICjasoDNdt73xqe2TW++9sc=";
    };
    vendorHash = "sha256-HDHsBuuJ+ta3ynYv8NVqEdd0h4UNWBelUA8j+YoEf4E=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_5];
    inherit postInstall;
  };
  junod_26_0_0 = buildGoModule rec {
    pname = "junod";
    version = "26.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-/Gz+HVoYiPLw///CRCvBQTBeE1S3xkAPOUn53CtJS54=";
    };
    vendorHash = "sha256-iynKKINRg3y2NCVIyp8u7VBIeKlqlkDT74oeO/9jnbo=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_5];
    inherit postInstall;
  };
  junod_27_0_0 = buildGoModule rec {
    pname = "junod";
    version = "27.0.0";
    src = fetchurl {
      url = "https://github.com/CosmosContracts/juno/archive/refs/tags/v${version}.tar.gz";
      sha256 = "sha256-Enwi9ixFgj5HaDegQUHp68+wOzdKrwHHe4lYltmY0Zk=";
    };
    vendorHash = "sha256-Iwifl3Rlc+PaYNywz2cnIv/S5b6GuPzamSAYGcrkpRo=";
    subPackages = "cmd/junod";
    buildInputs = [libwasmvm_1_5_8];
    inherit postInstall;
  };
in {
  inherit libwasmvm_1_5_1;
  inherit libwasmvm_1_5_2;
  inherit libwasmvm_1_5_4;
  inherit libwasmvm_1_5_5;
  inherit libwasmvm_1_5_8;
  inherit junod_18_1_0;
  inherit junod_19_0_0;
  inherit junod_19_1_0;
  inherit junod_20_0_0;
  inherit junod_21_0_0;
  inherit junod_22_0_0;
  inherit junod_22_0_1;
  inherit junod_23_0_0;
  inherit junod_23_1_0;
  inherit junod_24_0_0;
  inherit junod_25_0_0;
  inherit junod_26_0_0;
  inherit junod_27_0_0;
}
