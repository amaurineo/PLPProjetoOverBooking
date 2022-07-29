:-use_module(library(csv)).
:- include('mensagens.pl').
:- include('utilEmp.pl').

verificaLoginEmpresa(Menu):-
        loginEmpresa,
        read(Login),

        loginEmpresa02,
        read(Senha),

        lerArquivoCsv('empresa.csv',Resultado),
        contemMember(Senha,Resultado,Resp),
        (Resp -> menuEmpresa(Menu) ; senhaInvalida, Menu).

menuEmpresa(Menu):-
        menuEmpresaa,
        read(Opcao),
        escolhaDeOpcao(Opcao,Menu),
        halt.

escolhaDeOpcao(1,Menu):- cadastroDeFuncionario(Menu), menuEmpresa(Menu).
escolhaDeOpcao(3,Menu):- excluirFuncionario(Menu), menuEmpresa(Menu).
escolhaDeOpcao(4,Menu):- listaTodosFuncionarios(), menuEmpresa(Menu).
escolhaDeOpcao(6,Menu):- listaValoresDeCadaTipo(), menuEmpresa(Menu).
escolhaDeOpcao(7,Menu):- cadastraDesconto(Menu), menuEmpresa(Menu).
escolhaDeOpcao(9,Menu):- excluirDescontos(Menu), menuEmpresa(Menu).


cadastroDeFuncionario(Menu):-
      cadastrarNome,
      read(Nome),

      getCpf,
      read(Cpf),

      lerArquivoCsv('funcionarios.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> usuarioCadastrado, menuEmpresa(Menu) ; write("")),

      cadastrarFuncionario(Nome, Cpf),
      cadastroEfetuado.

cadastraDesconto(Menu):-
      cadastrarDesconto,
      read(Tipo),

      getValorDoDesconto,
      read(Valor),

      lerArquivoCsv('descontos.csv',Resultado),
      contemMember(Tipo,Resultado,Resultado2),
      (Resultado2 -> descontoJaCadastrado, menuEmpresa(Menu) ; write("")),

      cadastrarDesconto(Tipo,Valor),
      cadastroEfetuado.


excluirFuncionario(Menu):-
      writeln("Informe o CPF do funcionario que deseja excluir: "),
      read(Cpf),

      lerArquivoCsv('funcionarios.csv',Resultado),
      contemMember(Cpf, Resultado, Resultado2),
      (Resultado2 -> writeln(""); usuarioNaoCadastrado, menuEmpresa(Menu)),

      removegg(Cpf,Resultado,Respost),
      remove(Respost,Resultado,FuncionariosExcluidos),

      limpaCsv('funcionarios.csv'),
      reescreveFuncionario(FuncionariosExcluidos),
      funcionarioExcluido.

/* Exclui, mas reescreve errado */
excluirDescontos(Menu):-
      writeln("Informe o TIPO da poltrona relacionado ao desconto que deseja excluir: "),
      read(Tipo),

      lerArquivoCsv('descontos.csv',Resultadoo),
      contemMember(Tipo, Resultadoo, Resultadoo2),
      (Resultadoo2 -> writeln(""); descontoNaoCadastrado, menuEmpresa(Menu)),

      removegg(Tipo,Resultadoo,Respostt),
      remove(Respostt,Resultadoo,DescontosExcluidos),
      
      limpaCsv('descontos.csv'),
      reescreveDesconto(DescontosExcluidos),
      descontoExcluido.

listaTodosFuncionarios:-
      writeln("\n       -----TODOS OS FUNCINÁRIOS ATIVOS NO SISTEMA!-----\n"),
      lerArquivoCsv('funcionarios.csv',Resultado),
      writeln(Resultado).

listaValoresDeCadaTipo:-
      writeln("\n  Atualmente temos os seguintes valores relacionados aos tipos de assentos no sistema:      \n"),
      lerArquivoCsv('valoresDeCadaTipo.csv',Resultado),
      writeln(Resultado).

