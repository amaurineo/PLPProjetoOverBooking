:- (initialization main).
:- include('mensagens.pl').

main :-
    writeln("\n--------------------Seja bem vindo ao sistema OVERBOOKING!--------------------\n"),
    menuPrincipal,
    read(Opcao),
    escolheOpcao(Opcao),
    halt.

escolheOpcao(1):- writeln("Entrou na area do cliente"),(main).
escolheOpcao(2):- writeln("Entrou na area do funcionario"),(main).
escolheOpcao(3):- writeln("Entrou na area da empresa"),(main).
escolheOpcao(4):- halt.
escolheOpcao(_):- opcaoInvalida, main.