{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    cmake
    ninja

    llvmPackages.clang
    llvmPackages.clang-tools
    llvmPackages.lldb
    llvmPackages.llvm
    llvmPackages.mlir
  ] ++ lib.optionals(!pkgs.stdenv.isDarwin) [
    gcc
    gdb
  ];
}
