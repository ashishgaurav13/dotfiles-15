set number
syntax on
set tabstop=2 softtabstop=0 expandtab smarttab shiftwidth=2
au BufNewFile *.cpp r ~/.vim/basic.cpp
set mouse=a
map <xCSI>[62~ <MouseDown>
behave xterm
