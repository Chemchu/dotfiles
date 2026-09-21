{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      arduino-cli
      arduino-language-server
    ];
  };
}
