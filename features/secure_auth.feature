Feature: Usuarios conseguirem acessar a plataforma
  Para manter o acesso a aplicacao segura
  Como um usuario da aplicacao eu quero acessar a plataforma por credenciais seguras

  Scenario: Usuario fornece credenciais validas
    Given um usuario da aplicacao
    When ele fornece as credencias validas
    Then ele deve estar autorizado a acessar a aplicacao

  Scenario: Usuario fornece credenciais invalidas
    Given um usuario da aplicacao
    When ele fornece as credencias invalidas
    Then ele nao deve estar autorizado a acessar a aplicacao

  Scenario: Usuario tenta fazer login na aplicação
    Given um usuario da aplicacao
    When ele fornece as credencias validas
    And ele clica no botão para fazer o login
    Then o usuario deve ter um HTTP_USER_TOKEN e um HTTP_USER_EMAIL validos
