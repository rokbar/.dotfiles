{ pkgs, ... }:
let 
  lsColorScript = pkgs.writeShellScript "ls-color-check" ''
    if ls --color > /dev/null 2>&1; then
      echo "--color"
    else
      echo "-G"
    fi
  '';
in
{
  home.shellAliases = {
    pn = "pnpm";
    pbp = "lsof -i";
    l = "ls -lF $(${lsColorScript})";
    la = "ls -lAF $(${lsColorScript})";
    lsd = "ls -lF $(${lsColorScript}) | grep --color=never '^d'";
    ls = "command ls $(${lsColorScript})";
    path ="echo $PATH | tr ':' '\\n'";
  };
}
