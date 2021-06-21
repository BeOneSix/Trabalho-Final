let mysql = require('mysql');
let config = require('../../config/express.js');
let connection = mysql.createConnection(config);

routePessoa.get('/', (req, res) =>{
    console.log("pessoa/get");
});

routePessoa.get('/', (req, res) =>{
    console.log("pessoa/post");
});     

routePessoa.get('/insert/:email/:cpf/:dataNascimento/:nome/:sexo/:senha/:estado/:cidade/:bairro/:rua/:cep/:num', (req, res) => {

  let params = req.params;
  var sexo = "";

  if(params.sexo == "Masculino"){
    sexo = "m";
  }else if(params.sexo == "Feminino"){
    sexo = "f";
  }else{
    sexo = "n";
  }

  let sqlEndereco = `insert into enderecos(rua, bairro, cep, cidade, numero, estado) values ('${params.rua}', '${params.bairro}', ${params.cep}, '${params.cidade}', ${params.num}, '${params.estado}');`;
  let sqlLastEndereco = `SELECT LAST_INSERT_ID() lastid;`;

  connection.query(sqlEndereco);
  connection.query(sqlLastEndereco, function(err, result, fields){
    let resp = JSON.parse(JSON.stringify(result));
    let lastid = resp[0].lastid;
    let sqlPessoa = `insert into pessoas(cpf, data_nascimento, nome, sexo, id_endereco) values ('${params.cpf}', '${params.data_nascimento}', '${params.nome}', '${sexo}', ${lastid}); `;
    console.log(`${params.data_nascimento}`);
    connection.query(sqlPessoa);

    let sqlLastEndereco = `SELECT LAST_INSERT_ID() lastid;`;
    connection.query(sqlLastEndereco, function(err, result, field){
      let resp = JSON.parse(JSON.stringify(result));
      let lastid = resp[0].lastid;
      let sqlUsuario = `insert into usuarios(id_pessoa, senha, id_tipo_conta, email) values(${lastid}, '${params.senha}', 1, '${params.email}');`;
      connection.query(sqlUsuario);
    });
 
  });
  res.end();
});

module.exports = routePessoa;