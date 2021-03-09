
# Api template v1.0.0 - Web

### Índice de conteúdo
--- 

* [Setup do Projeto](#setup-do-projeto)
* [Dependências](#dependências)
* [Versionamento](#versionamento)
* [Changelog](#changelog)
* [Documentação da API](#documentação-da-api)


## Setup do Projeto
------------------------

### Dependências

 - Ruby v3.0.0
     - Caso não tenha Ruby intalado em sua máquina, recomendamos o uso do [RVM](https://rvm.io/) para a instalação do mesmo.
 - Rails v6.0.3
 - MySQL >= 5.6 
 - Git e Git Flow

### Importante, LEIA POR FAVOR e remova essa parte do seu readme depois que não for mais utilizar essas informações. 


#### Não se esqueça que você ainda precisa configurar o Sentry e o NewRelic para sua aplicacao.

Se sua aplicação **não** for só API e tiver uma parte WEB execute os seguintes passos:
  - Primerio la em `application.rb` troque a linha `config.api_only = true` por `config.api_only = false`;
  - Então descomente as gems de `Assets` la no Gemfile e rode um `bundle install` para instalar as dependencias necessarias;
  - Entao rode o comando `rails webpacker:install` que vai fazer todo o setup necessario pra seu front.
  - Para funcionar no ambiente de staging, você vai precisar criar na pasta do webpack um arquivo de `staging.js`, você pode se basear no `production.js` para fazer isso. 
  - Leia mais sobre o Webpacker aqui https://github.com/rails/webpacker

- Você deve gerar a `master.key` do seu projeto e colocar ela no Git (fazer um commit) e depois adicionar no `.gitignore` de novo.

- Mudar o nome do projeto em `application.rb` la está `ProjectName`.

- O credentials do projeto esta no gitignore, então adiciona ele apenas no servidor.

- Na hora de fazer o setup do banco, não esqueça de mudar o nome para o nome do seu projeto.

- Na migration que cria o User foram criadas as seguintes linhas:

```ruby
# Omniauth
# t.string :provider, :null => false, :default => "email"
# t.string :uid, :null => false, :default => ""
```

- Elas são ciradas pelo devise pra usar facebook ou algum outro provider de login (ex. google, apple). Para entender melhor como funciona https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

**** remover até aqui *****

**************************

**Download**

Acesse via terminal o local dos seus projetos e faça o download do repositório.
```bash
$ git clone git@gitlab.com:jera-software/api-template.git
```

Para utilização do ambiente de desenvolvimento configure o Git Flow.
```bash
$ sudo apt-get install git-flow
$ git flow init
```

Pressione Enter para todas as opções que serão exibidas. Depois disso você já estara na branch de development.

Caso opte por não utilizar Git Flow, é necessário fazer o download da branch `develop` remota.

**Configuração do database.yml: PRECISA SER FEITO PARA USAR MANUALMENTE OU COM DOCKER!**

Primeiramente é necessário criar o arquivo de setup de banco: `config/database.yml`.
```bash
$ cp config/database.example.yml config/database.yml
```

**Configuração do Gemset: CASO QUEIRA USAR MANUALMENTE**

Dentro da pasta do projeto, crie os arquivos `.ruby-version` e `.ruby-gemset` e depois entre novamente na pasta para carregar as novas configurações.
```bash
$ echo "<RUBY-VERSION>" > .ruby-version && echo "<APP_NAME>" > .ruby-gemset
$ cd .
```

**Instalação das dependências: CASO QUEIRA USAR MANUALMENTE**

A ferramenta `bundle` instalará todas as gems que foram definidas no Gemset do projeto.
```bash
$ gem install bundle
$ bundle install
```

Por fim, crie o banco de dados, rode as migrations e popule o mesmo.

```bash
$ rails db:create db:migrate db:seed
```

**Start do servidor manual**
```bash
$ rails s
```

**Start do servidor com docker**

```bash
$ docker build .
$ docker-compose up
$ docker-compose run application rake db:create db:migrate db:seed
```

**Testes**

Utilizamos o framework de testes Rspec e cucumber para execução de testes.

Manualmente: 
```bash
$ rake rspec
$ rake cucumber
```

Com Docker
```bash
$ docker-compose up
$ docker-compose run application rake db:create db:migrate db:seed RAILS_ENV=test
$ docker-compose run application spring rspec
```

**Documentação no Postman**
Todo projeto de API deve ser documentado.
Durante o setup, é importante criar uma conta no Postman para o projeto.
- Não esqueça de editar os Merge Request Templates com o link da documentação :D

## Documentação da API

- Coloque a documentação da API aqui, ex: postman e informações importantes sobre o projeto. 
