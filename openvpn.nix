{ openvpn
, fetchpatch
}:

openvpn.overrideAttrs (oldAttrs: rec {
  patches = [
    (fetchpatch {
      url = "https://raw.githubusercontent.com/ymatsiuk/aws-vpn-client/f929e910e3d81928a845f9c69f2edba958344ec6/openvpn-v2.6.8-aws.patch";
      sha256 = "sha256-pbgmt5o/0k4lZ/mZobl0lgg39kxEASpk5hf6ndopayY=";
    })
  ];
})
