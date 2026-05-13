# 🐞 DEBUG - Sistema de Controle de Cafeteiras

Documentação de erros encontrados, riscos identificados e melhorias recomendadas no sistema de controle de cafeteiras.

---

## 📁 Arquivos Envolvidos

```txt
projeto/
├── cafeteria.js
├── cafeteiras.cad
├── cafeteiras.log
├── teste.bat
├── testefinal.bat
├── cafeteira01.bat
├── cafeteira02.bat
├── cafeteira03.bat
└── cafeteira04.bat
```

---

# 🚨 Problemas Encontrados

## 1️⃣ Problema com `split(' ')`

O sistema utiliza:

```js
split(' ')
```

para separar os dados do arquivo `.cad`.

### ❌ Problema

Se houver múltiplos espaços:

```txt
01   Copa   990
```

o array gerado pode ficar incorreto:

```js
["01", "", "", "Copa", "", "", "990"]
```

Isso pode quebrar:

* leitura do local;
* leitura das cargas;
* validações.

### ✅ Solução recomendada

```js
split(/\s+/)
```

---

## 2️⃣ Linhas vazias no `cafeteiras.cad`

Se existir uma linha vazia no final do arquivo:

```txt
04 Cozinha 032

```

o sistema pode tentar processar uma máquina inexistente.

### ✅ Solução recomendada

```js
const quebraLinhas = cafeteiras
    .split('\n')
    .filter(linha => linha.trim() !== '');
```

---

## 3️⃣ Locais com espaço quebram o sistema

Formato atual:

```txt
01 Copa 990
```

Formato problemático:

```txt
01 Sala Principal 990
```

### ❌ Problema

O sistema assume que:

```js
partes[1]
```

é sempre o local.

### ✅ Soluções possíveis

#### Opção 1 — usar `_`

```txt
01 Sala_Principal 990
```

#### Opção 2 — usar delimitador `;`

```txt
01;Sala Principal;990
```

---

## 4️⃣ Possível carga negativa

O sistema faz:

```js
this.cargas -= qtd;
```

### ❌ Problema

Em execuções simultâneas, a carga pode ficar negativa.

Exemplo:

* dois processos lendo a mesma carga ao mesmo tempo.

### ✅ Solução recomendada

```js
if (this.cargas - qtd < 0)
```

---

## 5️⃣ Problema de concorrência

O sistema usa:

```js
readFileSync()
```

e depois:

```js
writeFileSync()
```

### ❌ Problema

Se dois processos executarem ao mesmo tempo:

* ambos leem o mesmo valor;
* ambos validam;
* ambos escrevem;
* um sobrescreve o outro.

### 📌 Observação

Essa é uma limitação conhecida da arquitetura atual.

---

## 6️⃣ Duplicação de log

Em algumas versões:

* os `.bat` escreviam no log;
* o `cafeteria.js` também escrevia.

### ❌ Problema

Isso gera logs duplicados.

### ✅ Correto

Somente:

```js
registrarLog()
```

deve escrever no log.

Os `.bat` devem apenas chamar:

```bat
node cafeteria.js 01 p
```

---

## 7️⃣ Falta tratamento para parâmetros ausentes

Hoje o sistema usa:

```js
const codMaquina = process.argv[2];
const tamanhoCafe = process.argv[3];
```

### ❌ Problema

Se executar:

```bash
node cafeteria.js
```

o sistema recebe:

```txt
undefined undefined
```

### ✅ Solução recomendada

```js
if (!codMaquina || !tamanhoCafe) {
    console.log("Erro: parâmetros ausentes.");
    process.exit(1);
}
```

---

## 8️⃣ Falta validação de carga inválida

Exemplo problemático no `.cad`:

```txt
01 Copa abc
```

### ❌ Problema

```js
parseInt("abc")
```

retorna:

```js
NaN
```

### ✅ Solução recomendada

```js
if (isNaN(maquina.cargas))
```

---

## 9️⃣ Teste incorreto de máquina inexistente

Exemplo incorreto:

```bat
call cafeteira05.bat 1
```

### ❌ Problema

O erro será do Windows, não do sistema.

### ✅ Forma correta

```bash
node cafeteria.js 05 p
```

---

## 🔟 Inconsistência no README

O README mostra:

```txt
bats/
```

mas os arquivos podem estar na raiz do projeto.

### ✅ Solução recomendada

Atualizar a documentação conforme a estrutura real do projeto.

---

## 1️⃣1️⃣ Problema de encoding

Mensagens com acento:

```txt
Máquina inexistente
```

podem aparecer quebradas no CMD.

### ✅ Solução recomendada

Adicionar nos `.bat`:

```bat
chcp 65001 > nul
```

---

## 1️⃣2️⃣ Falta tratar letras maiúsculas

Hoje:

```bash
node cafeteria.js 01 P
```

pode gerar erro.

### ✅ Solução recomendada

```js
const tamanhoCafe = process.argv[3].toLowerCase();
```

---

## 1️⃣3️⃣ Possível falha no `find`

Hoje o sistema compara:

```js
return partes[0] === codMaquina;
```

### ❌ Problema

Espaços extras podem causar falha.

### ✅ Solução recomendada

```js
return partes[0].trim() === codMaquina.trim();
```

---

# 🧪 Testes Recomendados

## ✅ Testes válidos

```bash
node cafeteria.js 01 p
node cafeteria.js 01 m
node cafeteria.js 01 g

node cafeteria.js 02 p
node cafeteria.js 03 g
node cafeteria.js 04 m
```

---

## ❌ Máquina inexistente

```bash
node cafeteria.js 05 p
node cafeteria.js 08 m
node cafeteria.js 99 g
```

---

## ❌ Tamanho inválido

```bash
node cafeteria.js 01 x
node cafeteria.js 02 4
node cafeteria.js 03 grande
```

---

## ❌ Sem pó

Exemplo:

* configurar uma máquina com poucas cargas;
* solicitar um café maior que o disponível.

---

# 📌 Conclusão

O sistema está funcional e atende aos principais requisitos do projeto:

* controle de cafeteiras;
* atualização automática de cargas;
* registro de logs;
* tratamento de erros;
* testes automatizados.

Os principais pontos de melhoria são:

* melhorar a leitura do `.cad`;
* evitar problemas com espaços extras;
* validar argumentos ausentes;
* validar cargas inválidas;
* documentar limitações de concorrência;
* padronizar a gravação de logs;
* melhorar compatibilidade do terminal com acentos.
