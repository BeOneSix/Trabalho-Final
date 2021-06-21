let mysql = require('mysql');
let config = require('../../config/express.js');
let connection = mysql.createConnection(config);

routeEmpresa.get('/', (req, res) =>{});

routeEmpresa.get('/', (req, res) =>{});     
routeEmpresa.get('/insert/:email/:cnpj/:razaosocial/:senha/:estado/:cidade/:bairro/:rua/:num/:cep', (req, res)=>{
    let params = req.params;
    console.log("acessado");
    let sqlEndereco = `insert into enderecos(rua, bairro, cep, cidade, numero, estado) values ('${params.rua}', '${params.bairro}', ${params.cep}, '${params.cidade}', ${params.num}, '${params.estado}');`;
    let sqlLastEndereco = `SELECT LAST_INSERT_ID() lastid;`;

    connection.query(sqlEndereco);

    connection.query(sqlLastEndereco, function(err, result, fields){
        let resp = JSON.parse(JSON.stringify(result));
        let lastid = resp[0].lastid;
        let sqlEmpresa = `insert into empresas(cnpj, razao_social, id_endereco) values ( '${params.cnpj}', '${params.razaosocial}', ${lastid});`;
        connection.query(sqlEmpresa);

        let sqlLastEndereco = `SELECT LAST_INSERT_ID() lastid;`;
        connection.query(sqlLastEndereco, function(err, result, field){
          let resp = JSON.parse(JSON.stringify(result));
          let lastid = resp[0].lastid;
          let sqlUsuario = `insert into usuarios(id_empresa, senha, id_tipo_conta, email) values(${lastid}, '${params.senha}', 2, '${params.email}');`;
          connection.query(sqlUsuario);
        });
    });
    res.end();
});

module.exports = routeEmpresa;