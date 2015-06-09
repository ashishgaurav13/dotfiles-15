#
# ~/.bashrc
#

# If not running interactively, don't do anything
#archey3 --color=white
PATH="${HOME}/Programs/NaCl/depot_tools:$PATH"
NPM_PACKAGES="${HOME}/.npm"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


# screenfetch -E -t -A 'Linux'
[[ $- != *i* ]] && return

alias reset='reset -Q'
alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
PS1='[\W] '
TERM='xterm'
CHROME_PATH="/usr/bin/google-chrome-stable/"
NACL_SDK_ROOT="${HOME}/Programs/NaCl/nacl_sdk/pepper_canary/"
export NACL_SDK_ROOT

# oracle xe
export ORACLE_HOME=/usr/lib/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export ORACLE_BASE=/usr/lib/oracle
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib

# chrome sandbox
export CHROME_DEVEL_SANDBOX=/home/agaurav77/Programs/NaCl/chrome/chrome-linux/chrome_sandbox

# android builds
PATH=~/bin:$PATH

# ruby gems
PATH=~/.gem/ruby/2.2.0/bin:$PATH
PATH=/usr/lib/ruby/gems/2.2.0/bin:$PATH
source `jump-bin --bash-integration`/shell_driver

# django shortcuts
alias manage='python manage.py'
