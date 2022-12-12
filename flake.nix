{
  description = "AWS VPN client";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages = flake-utils.lib.flattenTree {
          awsvpnclient = pkgs.callPackage ./awsvpnclient.nix {
            openvpn = pkgs.callPackage ./openvpn.nix { };
          };
        };
        defaultPackage = packages.awsvpnclient;
      }
    );
}
