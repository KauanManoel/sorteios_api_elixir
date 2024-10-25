# Sorteios API

Este é um projeto de API desenvolvido em Elixir utilizando o framework Phoenix. A aplicação é responsável por gerenciar sorteios e permitir que usuários participem deles. Para gerar sorteios automaticamente, utilizamos a biblioteca Oban.

## Tecnologias Utilizadas

- **Erlang/OTP**: 27 [erts-15.1.2] [64-bit]
- **Elixir**: 1.17.3 (compilado com Erlang/OTP 27)
- **Phoenix**: v1.7.14
- **PostgreSQL**: Sistema de gerenciamento de banco de dados.
- **VS Code**: Editor de código utilizado para desenvolvimento.
- **Postman**: Executar testes e validações.
- **Oban**: Biblioteca para gerenciamento de tarefas em segundo plano.

## Pré-requisitos

Antes de começar, você precisa ter os seguintes itens instalados no seu sistema:

1. **Erlang/OTP**: Versão 27 ou superior.
2. **Elixir**: Versão 1.17.3 ou superior.
3. **PostgreSQL**: Versão 13 ou superior.
4. **Node.js**: Para gerenciar as dependências do frontend.
5. **Phoenix Installer**: Para criar novas aplicações Phoenix.
6. **Postman**: Executar testes e validações.

Estrutura do Projeto
lib/sorteios_api: Contém a lógica principal da API.
lib/sorteios_api_web: Contém a lógica relacionada à interface web da API.
lib/sorteios_api_web/controllers: Contém os controladores da API.
lib/sorteios_api_web/views: Contém as visualizações da API.
lib/sorteios_api_web/schemas: Contém os esquemas Ecto.
lib/sorteios_api_web/jobs: Contém os trabalhos que são agendados usando o Oban.
### Instalando Erlang e Elixir

Se você estiver usando Ubuntu, siga os passos abaixo para instalar o Erlang e o Elixir:

```bash
# Adicione o repositório Erlang Solutions
sudo apt-get install -y curl
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
sudo dpkg -i erlang-solutions_2.0_all.deb

# Instale Erlang
sudo apt-get update
sudo apt-get install -y esl-erlang

# Instale Elixir
sudo apt-get install -y elixir
sudo apt-get install -y postgresql postgresql-contrib

# Instale o NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# Após a instalação, carregue o nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Instale a versão mais recente do Node.js
nvm install node

#Instalando o Phoenix Installer
mix archive.install hex phx_new

Configurando o Projeto
1. Clonando o Repositório
Clone o repositório do projeto:

git clone <URL_DO_SEU_REPOSITORIO>
cd sorteios_api

2. Instalando Dependências
Instale as dependências do projeto:

mix deps.get

3. Configurando o Banco de Dados
Criar o banco de dados:

Edite o arquivo config/dev.exs para configurar suas credenciais do PostgreSQL.
Depois, crie o banco de dados executando:

mix ecto.create
Rodar as migrações:

mix ecto.migrate
4. Executando a Aplicação
Para iniciar o servidor Phoenix, execute:

mix phx.server
A aplicação estará disponível em http://localhost:4000.
