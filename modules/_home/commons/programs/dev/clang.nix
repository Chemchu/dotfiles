{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      llvmPackages_20.libcxxClang
    ];
  };
}
