# ☕ Sistema de Controle de Cafeteiras

Sistema automatizado para controlar máquinas de café distribuídas em diferentes locais, registrando cada operação em log.

---

## 📁 Estrutura de Arquivos

```
projeto/
├── cafeteria.js        # Script principal (cérebro do sistema)
├── cafeteiras.cad      # Cadastro das máquinas
├── cafeteiras.log      # Log de operações
└── bats/
    ├── cafeteira01.bat
    ├── cafeteira02.bat
    └── ...
```

---

## 📋 Formato dos Arquivos

### `cafeteiras.cad`
Cadastro de todas as máquinas. Cada linha representa uma máquina:
```
01 Copa 990
02 Sala 100
03 Cozinha 000
04 Cozinha 032
```
> `[código] [local] [cargas disponíveis]`

### `cafeteiras.log`
Registro de todas as operações realizadas:
```
12/03/2026 10:21 01 p ok
12/03/2026 11:15 04 g ok
12/03/2026 12:14 03 p erro: Sem pó.
12/03/2026 11:15 06 p erro: Máquina inexistente.
```
> `[data] [hora] [código] [tamanho] [resultado]`

---

## ⚙️ Como Funciona

Cada cafeteira possui um arquivo `.bat` que chama o sistema central:

```bat
node cafeteria.js 01 p
```

O sistema então:
1. Valida se a máquina existe no cadastro
2. Valida se o tamanho do café é válido (p/m/g)
3. Verifica se há cargas suficientes
4. Desconta as cargas utilizadas
5. Registra o resultado no log

---

## 📏 Tamanhos de Café

| Tamanho | Código | Cargas consumidas |
|---------|--------|-------------------|
| Pequeno | `p`    | 1 carga           |
| Médio   | `m`    | 2 cargas          |
| Grande  | `g`    | 3 cargas          |

---

## ❌ Erros Tratados

| Erro | Descrição |
|------|-----------|
| `Máquina inexistente` | Código não encontrado no `.cad` |
| `Sem pó` | Cargas insuficientes para o tamanho solicitado |
| `Tamanho inválido` | Parâmetro diferente de `p`, `m` ou `g` |

---

## 🚀 Pré-requisitos

- [Node.js](https://nodejs.org/) instalado
- Arquivo `cafeteiras.cad` criado e populado
- Arquivos `.bat` configurados para cada máquina

---

## 👥 Times

| Time | Responsabilidade |
|------|-----------------|
| **Devs** | Script `cafeteria.js` e lógica do sistema |
| **Criação** | Arquivos `.bat` de cada cafeteira e `cafeteiras.cad` |
| **Testes** | Cenários de teste (máquina inválida, sem pó, tamanho inválido, etc.) |
