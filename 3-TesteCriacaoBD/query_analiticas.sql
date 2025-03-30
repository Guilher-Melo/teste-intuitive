SELECT c.registro_ans, rel.razao_social,
SUM(CASE 
               WHEN vl_saldo_final < vl_saldo_inicial 
               THEN ABS(vl_saldo_final - vl_saldo_inicial) 
               ELSE 0 
           END) AS total_despesas
FROM detalhes_contas c
JOIN relatorio_cadop rel
ON c.registro_ans = rel.registro_ans
WHERE c.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR ' AND 
c.data = '2024-10-01'
GROUP BY c.registro_ans, rel.razao_social
ORDER BY total_despesas DESC
LIMIT 10;


SELECT c.registro_ans, rel.razao_social,
SUM(CASE 
               WHEN vl_saldo_final < vl_saldo_inicial 
               THEN ABS(vl_saldo_final - vl_saldo_inicial) 
               ELSE 0 
           END) AS total_despesas
FROM detalhes_contas c
JOIN relatorio_cadop rel
ON c.registro_ans = rel.registro_ans
WHERE c.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR ' AND 
YEAR (c.data) = '2024'
GROUP BY c.registro_ans, rel.razao_social
ORDER BY total_despesas DESC
LIMIT 10;