{pkgs, ...}: {
  home.packages = [
    (pkgs.python311.withPackages (ppkgs: [
      ppkgs.numpy
      ppkgs.requests
    ]))
  ];
}
