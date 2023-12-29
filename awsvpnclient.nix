{ lib
, buildGoModule
, fetchFromGitHub
, makeWrapper
, openvpn
, xdg-utils
}:

buildGoModule rec {
  pname = "awsvpnclient";
  version = "cae3a69821bd2ad78423ae585d212400531fdb8d";

  src = fetchFromGitHub {
    owner = "ymatsiuk";
    repo = "aws-vpn-client";
    rev = "${version}";
    sha256 = "sha256-vJRQnTzJuhpYxG8YhH+QcZoRwvuuUzFOpunNo9mrfwI=";
  };

  vendorHash = "sha256-602xj0ffJXQW//cQeByJjtQnU0NjqOrZWTCWLLhqMm0=";

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    cp ${src}/awsvpnclient.yml.example $out/awsvpnclient.yml

    substituteInPlace $out/awsvpnclient.yml \
      --replace /home/myname/aws-vpn-client/openvpn "openvpn" \
      --replace /usr/bin/sudo "sudo"

    makeWrapper $out/bin/aws-vpn-client $out/bin/awsvpnclient \
      --run "cd $out" \
      --prefix PATH : "${lib.makeBinPath [ openvpn xdg-utils ]}"
  '';

}
