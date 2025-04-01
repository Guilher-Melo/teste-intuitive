# Desafio intuitive care - Web Scraping, ETL, Banco de Dados e API

## Visão Geral
Este repositório contém a solução para um desafio de estágio envolvendo quatro etapas principais:

1. **Teste de Web Scraping** - Coleta e compactação de PDFs.
2. **Teste de Transformação de Dados** - Extração de dados de um PDF e conversão para CSV.
3. **Teste de Banco de Dados** - Estruturação, carga e análise de dados em um banco MySQL.
4. **Teste de API** - Criação de um backend com FastAPI e frontend com Vue.js para consulta de dados.

---
## Tecnologias Utilizadas
- **Python** (Selenium, Requests, zipfile, Tabula, Pandas, FastAPI)
- **MySQL** (Docker, SQL, LOAD DATA INFILE)
- **Vue.js** (Interface Web)
- **Postman** (Testes de API)

---
## Estrutura do Projeto

```
/
|-- 1-TesteWebScrapping/          # Código para baixar e compactar os PDFs
|-- 2- TesteTransformacaoDados/   # Extração de dados do PDF para CSV
|-- 3-TesteCriacaoBD/             # Scripts SQL para criação e carga de tabelas
|-- 4-TesteAPI/                   # Backend FastAPI, Interface Vue.js, Coleção Postman
|-- README.md                     # Documentação do projeto
```

---
## Como Executar

### 1. Web Scraping
```bash
cd 1-TesteWebScrapping
python scrapper.py
```
Esse script realiza o download dos PDFs e os compacta em um arquivo ZIP.

### 2. Transformação de Dados
```bash
cd 2- TesteTransformacaoDados
python transformation.py
```
Este script extrai dados do PDF, gera um CSV estruturado e o compacta em um arquivo ZIP.

### 3. Banco de Dados
1. **Subir o MySQL via Docker**
```bash
docker-compose up -d
```

### 4. API e Frontend
1. **Rodar o backend FastAPI**
```bash
cd 4-TesteAPI
python main.py
```
2. **Testar o frontend**
 <br>   Execute o arquivo index.html

1. **Testar via Postman**
<br> Importe a coleção `postman_collection.json`.

---

