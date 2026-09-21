{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options.programs.llama = {
    enable = lib.mkEnableOption "llama.cpp built from latest git";
  };

  config = lib.mkIf config.programs.llama.enable {
    home.packages = [
      (pkgs.stdenv.mkDerivation {
        pname = "llama-cpp-latest";
        version = "git-${inputs.llama-cpp-src.shortRev or "unknown"}";
        src = inputs.llama-cpp-src;

        nativeBuildInputs = with pkgs; [
          cmake
          ninja
          pkg-config
        ];

        buildInputs = with pkgs; [
          openblas
          vulkan-headers
          vulkan-loader
          shaderc
        ];

        cmakeFlags = [
          "-DCMAKE_BUILD_TYPE=Release"
          "-DLLAMA_BUILD_TESTS=OFF"
          "-DGGML_BLAS=ON"
          "-DGGML_BLAS_VENDOR=OpenBLAS"
          "-DGGML_VULKAN=ON"
        ];

        enableParallelBuilding = true;
      })
    ];

    home.sessionVariables = {
      HSA_OVERRIDE_GFX_VERSION = "11.5.1";
    };
  };
}
