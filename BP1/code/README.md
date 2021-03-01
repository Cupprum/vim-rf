### Dependencies
- Docker 
- docker kontajner `my-vim`

### Kontajnery
__my_vim__
Skript `build-vim.bash` vytvori kontaner, ktory obsahuje cerstvo compilovanu
najnovsiu verziu editoru Vim. Tuto verziu ulozi pod tagom `my-vim`.

__syntax highlighting__
Pre spustenie kontajneru, v ktorom funguje zvyraznovanie syntaxe je potrebne
mat kontaner `my-vim` a nasledne sputit skript `run-vim-rf.bash`.

__syntax linting__
Pre spustenie kontajneru, v ktorom funguje syntax linting je potrebne mat
kontajner `my-vim` a nasledne sputit skript `run-vim-rflint.bash`.

### Pripomienky
Zvyraznovanie syntaxe nieje este kompletne dokoncene.
Syntax linting by mal byt kompletne dokonceny.
