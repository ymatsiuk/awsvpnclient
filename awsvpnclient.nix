{ lib
, buildGoModule
, fetchFromGitHub
, makeWrapper
, openvpn
, sudo
, xdg-utils
}:

buildGoModule rec {
  pname = "awsvpnclient";
  version = "b9ea37937a3f4ca6a6442691886a108c49bab185";

  src = fetchFromGitHub {
    owner = "ajm113";
    repo = "aws-vpn-client";
    rev = "${version}";
    sha256 = "sha256-vJRQnTzJuhpYxG8YhH+QcZoRwvuuUzFOpunNo9mrfwI=";
  };

  vendorSha256 = "sha256-602xj0ffJXQW//cQeByJjtQnU0NjqOrZWTCWLLhqMm0=";

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    cp ${src}/awsvpnclient.yml.example $out/awsvpnclient.yml

    substituteInPlace $out/awsvpnclient.yml \
      --replace /home/myname/aws-vpn-client/openvpn "openvpn" \
      --replace /usr/bin/sudo "/run/wrappers/bin/sudo"

    makeWrapper $out/bin/aws-vpn-client $out/bin/awsvpnclient \
      --run "cd $out" \
      --prefix PATH : "${lib.makeBinPath [ openvpn xdg-utils sudo ]}"
  '';

}
