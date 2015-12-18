{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, hsp, hsx2hs, reform, stdenv, text }:
      mkDerivation {
        pname = "reform-hsp";
        version = "0.2.6.1";
        src = ./.;
        libraryHaskellDepends = [ base hsp hsx2hs reform text ];
        homepage = "http://www.happstack.com/";
        description = "Add support for using HSP with Reform";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
