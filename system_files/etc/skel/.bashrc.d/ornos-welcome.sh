# Exibe o painel do OrnOS apenas em terminais interativos
if [[ $- == *i* ]] && command -v fastfetch &> /dev/null; then
    fastfetch
fi