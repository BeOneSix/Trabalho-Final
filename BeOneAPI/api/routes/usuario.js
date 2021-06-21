let mysql = require('mysql');
const express = require('express');
let config = require('../../config/express.js');
let connection = mysql.createConnection(config);
app = express();
var cors = require('cors');
app.use(cors());

routeUsuario.get('/', (req, res) =>{
});

routeUsuario.post('/', (req, res) =>{
});

routeUsuario.get('/login/:email/:senha', cors(), (req, res) =>{
    let sql = `select * from usuarios where email = '${req.params.email}' and senha = '${req.params.senha}';`;
    connection.query(sql, function(err, result, field){
        if (err) throw err;
        res.send(JSON.stringify(result));
    });
});

  module.exports = routeUsuario;