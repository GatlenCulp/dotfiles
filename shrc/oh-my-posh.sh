OH_MY_POSH_DIR="$XDG_CONFIG_HOME/oh-my-posh"
OH_MY_POSH_THEME="nordcustom_v.2"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $OH_MY_POSH_DIR/themes/$OH_MY_POSH_THEME.omp.json)"
fi