{
  description = "Koi - Theme scheduling for the KDE Plasma Desktop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages.default = pkgs.callPackage ./dev.nix {
          # TODO: clearly I am too stupid to understand `callPackage` correctly. This should be possible in a more elegant way?
          kconfig = pkgs.libsForQt5.kconfig;
          kwidgetsaddons = pkgs.libsForQt5.kwidgetsaddons;
          wrapQtAppsHook = pkgs.libsForQt5.wrapQtAppsHook;
          kcoreaddons = pkgs.libsForQt5.kcoreaddons;
          qtbase = pkgs.libsForQt5.qtbase;
          mkDerivation = pkgs.stdenv.mkDerivation;
          inherit (pkgs) cmake;
        };
      }
    );
}
