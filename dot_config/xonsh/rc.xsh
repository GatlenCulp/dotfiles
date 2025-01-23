# xonsh
# xonsh https://marketplace.visualstudio.com/items?itemName=jnoortheen.xonsh
execx($(oh-my-posh init xonsh))
execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')