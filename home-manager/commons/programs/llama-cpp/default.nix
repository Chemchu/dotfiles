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

        nativeBuildInputs = with pkgs; [cmake ninja pkg-config];

        buildInputs = with pkgs; [
          openblas
          rocmPackages.clr
          rocmPackages.hipblas
          rocmPackages.rocblas
        ];

        cmakeFlags = [
          "-DCMAKE_BUILD_TYPE=Release"
          "-DLLAMA_BUILD_TESTS=OFF"
          "-DGGML_BLAS=ON"
          "-DGGML_BLAS_VENDOR=OpenBLAS"
          "-DGGML_HIPBLAS=ON"
          "-DAMDGPU_TARGETS=gfx1151"
        ];

        enableParallelBuilding = true;
      })
    ];

    home.sessionVariables = {
      HSA_OVERRIDE_GFX_VERSION = "11.5.1";
    };
  };
}
