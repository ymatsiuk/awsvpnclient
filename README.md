# awsvpnclient

nix flake that provides https://github.com/samm-git/aws-vpn-client/pull/16

### Usage

```nix
{
  inputs = {
    awsvpnclient.url = "github:ymatsiuk/awsvpnclient";
  };

  outputs = {self, nixpkgs, awsvpnclient }:
  {
    nixosConfigurations.nixps = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        {
          nix.extraOptions = "experimental-features = nix-command flakes";
          nix.package = pkgs.nixUnstable;
          nixpkgs.overlays = [ awsvpnclient.overlay ];
        }
      ];
    };
 };
}
```

You can find a slightly more sophisticated example in [my flake](https://github.com/ymatsiuk/nixos-config/blob/8dca28ee74bfe18b7bc1c55feb1d5df2ade6008f/flake.nix#L64)
