var database = require("../database/config");

function buscarUltimasMedidas(id, limite_linhas) {

    var instrucaoSql = `SELECT 
        luminosidade, 
        momento,
        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
            FROM medida
                WHERE fk_dark_room = ${id}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



function buscarMedidasEmTempoReal(id) {

    var instrucaoSql = `SELECT 
        luminosidade, 
        momento,
            DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                fk_dark_room
                    FROM medida WHERE fk_dark_room = ${id} 
                ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
