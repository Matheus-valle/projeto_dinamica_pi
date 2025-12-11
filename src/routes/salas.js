var express = require("express")
var router = express.Router();

var salasController = require("../controllers/salasController");

router.get("/obter-salas/:fkEmpresa", function (req, res) {
    salasController.obterSalas(req, res);
});

module.exports = router;
