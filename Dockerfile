# definir imagem base para o contêiner
FROM python:3.13.4-alpine3.22

# Define variáveis de ambiente para otimizar a execução em contêineres
# Impede o Python de gerar arquivos .pyc
ENV PYTHONDONTWRITEBYTECODE 1
# Garante que a saída do Python seja enviada diretamente para o terminal sem buffer
ENV PYTHONUNBUFFERED 1

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências e instala as dependências
# Fazer isso em um passo separado aproveita o cache de camadas do Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta que a aplicação usará
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
