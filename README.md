# awsvpnclient

nix flake that provides https://github.com/samm-git/aws-vpn-client/pull/16

### Using the flake

```nix
{
  inputs.awsvpnclient.url = "github:ymatsiuk/awsvpnclient";
  outputs = { self, nixpkgs, awsvpnclient }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixps = nixpkgs.lib.nixosSystem {
        # ...
        modules = [{ environment.systemPackages = [ awsvpnclient ]; }];
        # ...
      };
      overlays = [
        (final: prev: {
          awsvpnclient = awsvpnclient.packages.${system}.awsvpnclient;
        })
      ];
    };
}
```

### Using the client

```bash
awsvpnclient start --config ~/path/to/config.ovpn
```
