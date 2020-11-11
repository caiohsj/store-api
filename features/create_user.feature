Feature: Cadastro com nome email e senha
  Para conseguir ter acesso ao aplicativo
  Como um usuario

  Scenario: Usuario fornece credenciais validas
    Given os dados de um usuario que quer se cadastrar
    When ele clica no botão para fazer o cadastro na aplicação
    Then o usuario deve ter sido cadastrado na aplicação com os valores que ele inserius

  Scenario: Usuario tenta se cadastar mas ja existe um outro usuario com o mesmo email na aplicação
    Given um usuario ja cadastrado na aplicação
    And os dados de um usuario que quer se cadastrar
    When ele clica no botão para fazer o cadastro na aplicação
    Then só deve existir um usuario cadastrado
    And a reposta deve ter um erro de Email já existe

  Scenario: Usuario fornece email inválido
    Given dados de um usuario com um email inválido
    When ele clica no botão para fazer o cadastro na aplicação
    Then não deve ter nenhum usuario na aplicação
    And a responsta deve ter um erro de E-mail Inválido

  Scenario: Usuario fornece uma senha com menos de 6 caracters
    Given dados de um usuario com uma senha com menos de 6 caracters
    When ele clica no botão para fazer o cadastro na aplicação
    Then não deve ter nenhum usuario na aplicação
    And a responsta deve ter um erro de Senha muito pequena, minimo é 6
