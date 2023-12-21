{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  name = "openocd-infineon";
  version = "4.2.0.999";

  src = fetchurl {
    url = "file://${./CyProgrammer_4.2.0.999.tar.gz}";
    sha256 = "jZ7bBsGhoHK4nMshMRutVCBXC40GT3L5U8uCROlvamA=";
  };

  buildInputs = [
    autoPatchelfHook
    libusb
    systemd
    glib
    zlib
    mesa
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    libxkbcommon
    freetype
    libGL
    fontconfig
    dbus
    krb5
  ];

  unpackPhase = ''
    tar -xzf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r openocd/bin/* $out/bin/
    chmod +x $out/bin/openocd

    mkdir -p $out/lib
    cp -r lib/* $out/lib/

    mkdir -p $out/scripts
    cp -r openocd/scripts/* $out/scripts/

    mkdir -p $out/flm
    cp -r openocd/flm/* $out/flm/
  '';

  meta = with pkgs.lib; {
    description = "Infineon's version of OpenOCD";
    homepage = "http://infineon.com/";
    license = licenses.unfree; # or appropriate license
    platforms = platforms.linux;
  };
}
