
# README

## Dependências

- PHP 5.6
- Apache 2.2
- MySQL client 5.7

## Bibliotecas PHP
- php-xml
- php-pdo
- php-mysql
- php-gd

## Como usar

Para usar esse container você precisa primeiro criar um fork ou clonar esse repositório.

Em seguida vá até o arquivo .gitignore na raiz do projeto e remova as linhas seguintes do comentário:

`## Remove this lines when using your project`

Remova esse Readme e faça as alterações necessárias para o seu projeto.

## Instalação

Crie um arquivo .env baseado no example.env.txt

Em seguida rode o docker-compose:

`$ docker-compose up`

> Use o parametro -d para rodar o comando acima sem log

Durante esse processo ele ira criar a imagem, o container e configurar os arquivos baseados nas variaveis do .env criado

### Drupal

### Instalando via interface

1. Acesse o site através da porta escolhida

2. Siga com os passos de instalação e defina os valores para a parte de banco de dados usando as variáveis MYSQL definidas no seu .env

3. O array database será gerado no arquivo *settings.php*

4. o site devera estar funcionando corretamente

### Importando banco de dados

Depois de configurado o site, importe um dump recente do banco para o seu ambiente para pegar os conteúdos cadastrados.

Para fazer a importação descompacte o sql.

#### Usando o mysql do container:

1. Rode `docker exec -it [PROJECT_NAME]-app` para entrar no container

2. `vendor/bin/drush sqlc < [PATH]/[NAME].sql`

#### Usando o mysql local

1. `mysql -u[USER] -p[PASSWORD] [DATABASE_NAME] < [PATH]/[NAME].sql`

2. Altere os dados no arquivo settings localizado em:
`/docroot/sites/default/settings.php`

```php
$databases['default']['default'] = array (
  'database' => '[PROJECT_NAME]',
  'username' => '[USER_DO_BANCO]',
  'password' => '[SENHA_DO_BANCO]',
  'prefix' => '',
  'host' => '[SEU_HOST_LOCAL]',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
```

## Referencias

[Using Composer with Drupal](https://www.drupal.org/docs/develop/using-composer/using-composer-with-drupal)

[Drupal 7 with composer](http://cambrico.net/drupal/using-composer-to-build-your-drupal-7-projects)

[Drupal Composer](https://github.com/drupal-composer)

[Wodby - Docker-based Drupal stack](https://github.com/wodby/docker4drupal)
