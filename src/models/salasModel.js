var database = require("../database/config");

function obterSalas(fk_empresa) {
    var instrucaoSql = `
        SELECT d.descricao, (
            SELECT luminosidade FROM medida WHERE fk_dark_room = d.id ORDER BY medida.id DESC LIMIT 1
        ) AS 'ultimo_registro', m.momento FROM medida m
            JOIN dark_room d ON fk_dark_room = d.id
            WHERE d.fk_empresa = ${fk_empresa}
            GROUP BY d.id
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    obterSalas
}