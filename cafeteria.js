const fs = require ('fs');
const codMaquina = process.argv[2];
const tamanhoCafe = process.argv[3];

    const cafeteiras = fs.readFileSync('./cafeteiras.cad', 'utf-8');

    const quebraLinhas = cafeteiras.split('\n'); 
    const encontrarMaquina = quebraLinhas.find(function(item){
        const partes = item.split(' ')
        return partes[0] === codMaquina
    }); 

class cafeteria {
    constructor (numero, local, cargas) {
        this.numero = numero;
        this.local = local;
        this.cargas = cargas; 
        this.tamanhoCargas = {
            p: 1,
            m: 2,
            g: 3
        };
    }
}
   this.tamanhoCargas = function() {
       
}


