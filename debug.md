✅ O QUE ESTÁ FUNCIONANDO

O sistema já faz corretamente:

leitura do cafeteiras.cad
identificação da máquina
validação de tamanho
validação de carga
atualização do .cad
gravação no .log
testes automatizados
tratamento de:
máquina inexistente
tamanho inválido
sem pó

Tudo isso aparece funcionando no log.

🚨 ERROS E PROBLEMAS ENCONTRADOS
1. PROBLEMA GRAVE — split(' ')

No cafeteria.js vocês fazem:

const partes = item.split(' ');

e também:

const partes = linha.split(' ');

Problema

Isso quebra se houver:

múltiplos espaços
tabs
espaços extras

Exemplo:

01   Copa   990

vira:

["01", "", "", "Copa", "", "", "990"]

Aí:

partes[1] deixa de ser o local
partes[2] deixa de ser a carga
SOLUÇÃO

Trocar TODOS os:

split(' ')

por:

split(/\s+/)
2. RISCO DE LINHA VAZIA NO .cad

Se o arquivo terminar com linha vazia:

04 Cozinha 032


o split('\n') cria uma linha vazia.

Aí:

const partes = item.split(/\s+/)

vira:

[""]
Problema

Pode gerar:

undefined
NaN
erro silencioso
SOLUÇÃO

Filtrar linhas vazias:

const quebraLinhas = cafeteiras
    .split('\n')
    .filter(linha => linha.trim() !== '');
3. PROBLEMA DE LOCAL COM ESPAÇO

Hoje o sistema assume:

01 Copa 990

Mas se existir:

01 Sala Principal 990

vai quebrar tudo.

Porque

O código assume:

partes[1]

como local.

SOLUÇÃO IDEAL

Padronizar:

locais SEM espaço

OU

usar delimitador:

01;Sala Principal;990

e:

split(';')
4. POSSÍVEL CARGA NEGATIVA

Hoje:

this.cargas -= qtd;

Mas o valor nunca é limitado.

Cenário perigoso

Se dois processos rodarem ao mesmo tempo:

cargas = 1

Dois cafés pequenos:

ambos validam
ambos descontam

Resultado:

-1
SOLUÇÃO

Antes de salvar:

if (this.cargas - qtd < 0)
5. PROBLEMA DE CONCORRÊNCIA (MUITO IMPORTANTE)

Esse é o maior problema arquitetural do sistema.

Hoje:

readFileSync()

depois:

writeFileSync()

Se dois BATs executarem juntos:

ambos leem o mesmo valor
ambos gravam
um sobrescreve o outro
Exemplo

Máquina:

01 Copa 001

Dois cafés pequenos ao mesmo tempo:

Processo A lê 1
Processo B lê 1
ambos validam
ambos gravam 0

Resultado:

deveriam ter dado erro no segundo
SOLUÇÃO

Pra faculdade:

só mencionar no README como limitação conhecida já basta.
6. O LOG ESTÁ DUPLICANDO

Vocês gravam log:

no JS
e alguns BATs também estavam gravando

Isso gera duplicação.

O CERTO

SOMENTE:

registrarLog()

deve escrever no log.

Os BATs:

apenas chamam o sistema.
7. FALTA TRATAR ARGUMENTOS AUSENTES

Hoje:

const codMaquina = process.argv[2];
const tamanhoCafe = process.argv[3];

Mas não valida se eles existem.

Problema

Isso:

node cafeteria.js

gera:

undefined undefined
SOLUÇÃO

Adicionar:

if (!codMaquina || !tamanhoCafe) {
    console.log("Erro: parâmetros ausentes.");
    process.exit(1);
}
8. O .cad NÃO É VALIDADO

Hoje vocês assumem que:

01 Copa 990

sempre está correto.

Problema

Se alguém escrever:

01 Copa abc

vai virar:

parseInt("abc")

Resultado:

NaN
SOLUÇÃO

Validar:

if (isNaN(this.cargas))
9. PROBLEMA NO TESTE AUTOMATIZADO

No teste.bat vocês usam:

call cafeteira05.bat

mas o arquivo não existe.

Então:

o Windows falha antes do JS validar.
O CERTO

Pra testar máquina inexistente:

node cafeteria.js 05 p
10. INCONSISTÊNCIA NO README

No README:

bats/

Mas os arquivos parecem estar na raiz.

11. PROBLEMA DE ENCODING

O log usa:

Máquina inexistente

Se CMD estiver em ANSI:

pode virar caractere quebrado.
SOLUÇÃO

No início dos BATs:

chcp 65001 > nul
12. FALTA TRATAR TAMANHO MAIÚSCULO

Hoje:

P
M
G

dão erro.

SOLUÇÃO
const tamanhoCafe = process.argv[3].toLowerCase();

13. POSSÍVEL BUG NO find

Hoje:

return partes[0] === codMaquina;

Se tiver espaços:

01 

pode falhar.

SOLUÇÃO
return partes[0].trim() === codMaquina.trim();
