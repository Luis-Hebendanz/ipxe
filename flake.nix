{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        packages.default = pkgs.callPackage ./ipxe.nix { };

        defaultPackage = packages.default;

        devShell = with pkgs; mkShell {
          buildInputs = with pkgs; [
            llvmPackages_latest.libclang
            perl
            cdrkit
            xz
            openssl
            gnu-efi
            mtools
            python3
            (with python39Packages; [
              autopep8
              pylint
              pip
              ipython
            ])

          ];
          NIX_CFLAGS_COMPILE = "-Wno-error";

          # Dynamic libraries your precompiled executable needs
          # Find more with ldd <executable>
          NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
            stdenv.cc.cc
            glib
            zlib
            gtk3
            dbus
            fontconfig
          ]);
        };
      });
}
