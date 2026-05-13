-- TRATIVA DE ERROS -- 

CORRIGIDO POR: ERICK VINICIUS 

#01 ERRO DE FINAL DE LINHA DO ARQUIVO CAFETEIRAS.CAD

#SOLUÇÃO: 
            FOI SOLUCIONADO O ERRO UTILIZANDO UM FILTRO LOGO APOS O SPLIT. 
              +---------------------------------------+
              |  filter(linha => linha.trim() !== '') |
              +---------------------------------------+
------------------------------------------------------------------------------------
#02 ERRO DE QUEBRA DE LINHAS DO ARQUIVO CAFETEIRAS.CAD

#SOLUÇÃO:
            FOI ADICIONADO UM SPLIT FALANDO QUE QUALQUER ESPAÇO BRANCO ELE VAI QUEBRAR, E O '+' SIGINIFICA QUE NAO IMPORTA SE TEM UM OU MAIS 

              +---------------+
              | split(/\s+/); |
              +---------------+
------------------------------------------------------------------------------------
#3 ERRO DE LOCAIS COM ESPAÇO 

#SOLUÇÃO:
            +----------------------------------------------------------------------------------------------------------+
            | NÃO FAZ SENTIDO PORQUE O ARQUIVO ORIGINAL .CAD INSERIDO PELO PROFESSOR NÃO TEM NOME DE AMBIENTES QUE USA |
            | MAIS DE 1 PALAVRAS                                                                                       |
            +----------------------------------------------------------------------------------------------------------+
------------------------------------------------------------------------------------
#4 ERRO DE POSSIVEL VALOR DE CARGA NEGATIVA 

#SOLUÇÃO: 
            +----------------------------------------------------------------------------------------------------------+
            | NÃO FAZ SENTIDO PORQUE O SISTEMA JA TEM A VALIDAÇÃO ANTES DE CHEGAR EM consumirCargas; Nessa parte aqui: | 
            |                                                                                                          |
            |                               if (maquina.cargas < cargasNec) {                                          |
            |                               registrarLog(`${dt} ${codMaquina} ${tamanhoCafe} erro: Sem pó.`);          |
            |                               process.exit(1);                                                           |
            |                                   }                                                                      |
            | OU SEJA QUANDO O SISTEMA REALIZA A CONDIÇÃO maquina.cargas < cargasNec se não for verdade,               |
            | o codigo ja cai em process.exit(1);>                                                                     |
            +----------------------------------------------------------------------------------------------------------+