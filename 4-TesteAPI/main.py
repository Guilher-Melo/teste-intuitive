from typing import Any, Dict

import pandas as pd
import uvicorn
from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="API de busca de operadoras")

# Configurando CORS para permitir requisições do frontend Vue
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

df = pd.read_csv('csv_file/Relatorio_cadop.csv',
                 delimiter=';')


@app.get('/')
def read_root():
    return {'message': 'API de busca de operadoras está funcionando'}


@app.get('/operadoras')
def get_all_operadoras(limit: int = 100, offset: int = 0):
    """Retorna todas as operadoras com paginação"""
    total = len(df)

    # Primeiro substituir NaN por None no DataFrame
    temp_df = df.iloc[offset:offset+limit].copy()
    temp_df = temp_df.replace({pd.NA: None, float('nan'): None})

    # Converter para dicionário
    results = temp_df.to_dict(orient="records")

    return {
        'total': total,
        'limit': limit,
        'offset': offset,
        'results': results
    }


@app.get('/busca')
def search_operadoras(
    q: str = Query(..., description='Termo de busca'),
    limit: int = 10,
    offset: int = 0
) -> Dict[str, Any]:
    """
    Realiza uma busca textual nos dados das operadoras
    e retorna os registros mais relevantes.
    """
    # Converter o termo de busca para lowercase para busca case-insensitive
    q_lower = q.lower()

    # Função para calcular a relevância de um registro
    def calculate_relevance(row):
        relevance = 0

        # Convertendo todos os valores para string e lowercase
        row_values = {k: str(v).lower() for k, v in row.items() if pd.notna(v)}

        # Verificando cada campo
        for field, value in row_values.items():
            # Correspondência exata (peso mais alto)
            if q_lower == value:
                relevance += 10
            # Correspondência no início do campo (peso médio)
            elif value.startswith(q_lower):
                relevance += 5
            # Correspondência em qualquer parte do campo (peso baixo)
            elif q_lower in value:
                relevance += 3

            # Bônus para campos mais importantes
            if field.lower() in ['Registro_ANS', 'CNPJ',
                                 'Razao_Social', 'Modalidade']:
                relevance *= 1.5

        return relevance

    # Aplicar o cálculo de relevância a cada linha
    df_with_relevance = df.copy()
    df_with_relevance['relevance'] = df.apply(calculate_relevance, axis=1)

    # Filtrar apenas resultados com alguma relevância
    results_df = df_with_relevance[df_with_relevance['relevance'] > 0]

    # Ordenar por relevância (maior para menor)
    results_df = results_df.sort_values(by='relevance', ascending=False)

    # Aplicar paginação
    total = len(results_df)
    temp_df = results_df.iloc[offset:offset+limit].copy()
    temp_df = temp_df.replace({pd.NA: None, float('nan'): None})

    # Converter para dicionário
    results = temp_df.to_dict(orient='records')
    # Remover a coluna de relevância dos resultados finais
    for item in results:
        item.pop('relevance', None)

    return {
        'total': total,
        'limit': limit,
        'offset': offset,
        'query': q,
        'results': results
    }


if __name__ == '__main__':
    uvicorn.run('main:app', host='0.0.0.0', port=8000, reload=True)
