{ ... }:
{
  programs.vim = {
    enable = true;
    extraConfig = ''
    syntax on

    set number
    set showmatch
    set termguicolors

    set tabstop=4
    set shiftwidth=4
    set expandtab
    set smartindent

    set hlsearch
    set ignorecase
    set smartcase
    set incsearch
   '';
  };
}
