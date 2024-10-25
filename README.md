# Sorteios API

Este é um projeto de API desenvolvido em Elixir utilizando o framework Phoenix. A aplicação é responsável por gerenciar sorteios e permitir que usuários participem deles. Para gerar sorteios automaticamente, utilizamos a biblioteca Oban.

## Tecnologias Utilizadas

- **Erlang/OTP**: 27 [erts-15.1.2] [64-bit]
- **Elixir**: 1.17.3 (compilado com Erlang/OTP 27)
- **Phoenix**: v1.7.14
- **PostgreSQL**: Sistema de gerenciamento de banco de dados.
- **Oban**: Biblioteca para gerenciamento de tarefas em segundo plano.
- **VS Code**: Editor de código utilizado para desenvolvimento.

## Pré-requisitos

Antes de começar, você precisa ter os seguintes itens instalados no seu sistema:

1. **Erlang/OTP**: Versão 27 ou superior.
2. **Elixir**: Versão 1.17.3 ou superior.
3. **PostgreSQL**: Versão 13 ou superior.
4. **Node.js**: Para gerenciar as dependências do frontend.
5. **Phoenix Installer**: Para criar novas aplicações Phoenix.

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