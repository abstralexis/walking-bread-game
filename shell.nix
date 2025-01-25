# Useless garbage redundant file. Segfaults if you run in nix-shell.
# Just install the dependencies and cry if it doesn't work.
# Waaaaaah.
let
  pkgs=import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") { };
in pkgs.mkShell {
  buildInputs = with pkgs; [
    rustc
    cargo

    libGL
    xorg.libX11
    xorg.libXi
    libxkbcommon

    openssl
    pkg-config
    cmake
    clang
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
      with pkgs;
      pkgs.lib.makeLibraryPath [ libGL xorg.libX11 xorg.libXi libxkbcommon openssl ]
    }"
  '';
}