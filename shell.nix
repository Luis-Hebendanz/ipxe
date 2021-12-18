  { pkgs ? import <nixpkgs> {}, luis }:
  pkgs.mkShell {
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
    shellHook = ''
    export HISTFILE=$PWD/.history
    # To be able to execute precompiled dynamic binaries
    export NIX_LD=$(cat /nix/store/88ghxafjpqp5sqpd75r51qqg4q5d95ss-gcc-wrapper-10.3.0/nix-support/dynamic-linker);
    '';

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
  }
