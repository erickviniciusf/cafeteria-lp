const fs = require('fs');
const codMaquina = process.argv[2];
const tamanhoCafe = process.argv[3];

const cafeteiras = fs.readFileSync('./cafeteiras.cad', 'utf-8');
const quebraLinhas = cafeteiras.split('\n').filter(linha => linha.trim() !== '')
const encontrarMaquina = quebraLinhas.find(function(item) {
    const partes = item.split(/\s+/);
    return partes[0] === codMaquina;
});

class Cafeteira {
    constructor(numero, local, cargas) {
        this.numero = numero;
        this.local  = local;
        this.cargas = parseInt(cargas); 
        this.tamanhoCargas = {
            p: 1,
            m: 2,
            g: 3
        };
    }

    cargasNecessarias(tamanho) {
        return this.tamanhoCargas[tamanho] || null;
    }

    consumirCargas(qtd) {
        this.cargas -= qtd;

        const linhasAtualizadas = quebraLinhas.map(function(linha) {
            const partes = linha.split(' ');
            if (partes[0] === codMaquina) {
                const novasCargas = String(parseInt(partes[2]) - qtd).padStart(3, '0');
                return `${partes[0]} ${partes[1]} ${novasCargas}`;
            }
            return linha;
        });

        fs.writeFileSync('./cafeteiras.cad', linhasAtualizadas.join('\n'), 'utf-8');
    }
}

    function dataHoraAtual() {
    const agora = new Date();
    const dia   = String(agora.getDate()).padStart(2, '0');
    const mes   = String(agora.getMonth() + 1).padStart(2, '0');
    const ano   = agora.getFullYear();
    const hora  = String(agora.getHours()).padStart(2, '0');
    const min   = String(agora.getMinutes()).padStart(2, '0');
    return `${dia}/${mes}/${ano} ${hora}:${min}`;
}

function registrarLog(mensagem) {
    fs.appendFileSync('./cafeteiras.log', mensagem + '\n', 'utf-8');
    console.log(mensagem);
}

const dt = dataHoraAtual();

if (!encontrarMaquina) {
    registrarLog(`${dt} ${codMaquina} ${tamanhoCafe} erro: Máquina inexistente.`);
    process.exit(1);
}

const partes   = encontrarMaquina.split(' ');   
const maquina  = new Cafeteira(partes[0], partes[1], partes[2]);

const cargasNec = maquina.cargasNecessarias(tamanhoCafe);
if (cargasNec === null) {
    registrarLog(`${dt} ${codMaquina} ${tamanhoCafe} erro: Tamanho inválido.`);
    process.exit(1);
}

if (maquina.cargas < cargasNec) {
    registrarLog(`${dt} ${codMaquina} ${tamanhoCafe} erro: Sem pó.`);
    process.exit(1);
}

maquina.consumirCargas(cargasNec);
registrarLog(`${dt} ${codMaquina} ${tamanhoCafe} ok`);