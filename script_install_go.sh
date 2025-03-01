#!/bin/bash

# Verifica se o usuário está executando o script como root
if [ "$EUID" -ne 0 ]; then
    echo "Por favor, execute este script como root ou usando sudo."
    exit 1
fi

# Define a versão do Go a ser instalada
GO_VERSION="1.20.5"  # Altere para a versão desejada
GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://golang.org/dl/${GO_TAR}"

# Verifica se o Go já está instalado
if command -v go &> /dev/null; then
    echo "Go já está instalado. Versão atual:"
    go version
    exit 0
fi

# Atualiza o sistema
echo "Atualizando o sistema..."
apt update && apt upgrade -y

# Instala dependências necessárias
echo "Instalando dependências..."
apt install -y wget tar

# Baixa o arquivo tar.gz do Go
echo "Baixando Go ${GO_VERSION}..."
wget ${GO_URL} -O /tmp/${GO_TAR}

# Extrai o arquivo tar.gz para /usr/local
echo "Instalando Go..."
tar -C /usr/local -xzf /tmp/${GO_TAR}

# Remove o arquivo tar.gz após a instalação
rm /tmp/${GO_TAR}

# Configura o PATH
echo "Configurando o PATH..."
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile.d/go.sh
source /etc/profile.d/go.sh

# Verifica a instalação
echo "Verificando a instalação do Go..."
go version

echo "Instalação do Go concluída com sucesso!"
