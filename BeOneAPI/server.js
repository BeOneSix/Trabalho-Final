const express = require('express');

const app = express();

const port = '8081';

routePessoa = express.Router();
var pessoa = require('./api/routes/pessoa.js');

routeUsuario = express.Router();
var usuario = require('./api/routes/usuario.js');

routeEmpresa = express.Router();
var empresa = require('./api/routes/empresa.js');


app.get('/', (req, res) =>{

});

app.post('/', (req, res) =>{

});

app.use('/pessoa', pessoa);
app.use('/usuario', usuario);
app.use('/empresa', empresa);

app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});