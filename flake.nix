{
  description = "AWS VPN client";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux = {
      awsvpnclient = nixpkgs.legacyPackages.x86_64-linux.callPackage ./awsvpnclient.nix {
        openvpn = nixpkgs.legacyPackages.x86_64-linux.callPackage ./openvpn.nix { };
      };
    };

    defaultPackage.x86_64-linux = (import nixpkgs {
      system = "x86_64-linux";
      overlays = [ self.overlay ];
    }).awsvpnclient;

    overlay = final: prev: {
      awsvpnclient = final.callPackage ./awsvpnclient.nix {
        openvpn = final.callPackage ./openvpn.nix { };
      };
    };

  };
}
