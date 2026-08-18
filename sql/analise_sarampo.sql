-- ============================================================
-- PROJETO: Análise de Cobertura Vacinal contra o Sarampo (DATASUS)
-- OBJETIVO: Identificar a queda vacinal, avaliar a taxa de abandono
--           e direcionar campanhas prioritárias para o MS.
-- AUTOR(A): Núbia cantalixto de Melo Alves
-- ============================================================


-- ============================================================
-- 1. VISÃO GERAL BRASIL: EVOLUÇÃO TEMPORAL (2013 - 2021)
-- Tratamento aplicado: Teto de 100% para coberturas inconsistentes
--                      e remoção de inconsistências de registro.
-- ============================================================
SELECT 
    ano,
    -- Média da D1 com teto em 100%
    ROUND(AVG(
        CASE 
            WHEN cobertura_triplice_viral_d1 > 100 THEN 100
            ELSE cobertura_triplice_viral_d1 
        END
    ), 2) AS media_nacional_d1_tratada,

    -- Média da D2 com teto em 100%
    ROUND(AVG(
        CASE 
            WHEN cobertura_triplice_viral_d2 > 100 THEN 100
            ELSE cobertura_triplice_viral_d2 
        END
    ), 2) AS media_nacional_d2_tratada
FROM vacinacao
WHERE ano >= 2013 -- Iniciamos em 2013 pois 2012 não possui dados válidos para a D2
GROUP BY ano
ORDER BY ano ASC;

-- ============================================================
-- 2. COMPARATIVO NACIONAL POR ESTADOS / UF (2018 - 2021)
-- Pergunta de Negócio: Qual é a posição de SP no ranking nacional 
--                      de cobertura vacinal média nos anos recentes?
-- Meta do Ministério da Saúde: >= 95%
-- ============================================================
SELECT 
    v.sigla_uf,
    ROUND(AVG(
        CASE 
            WHEN v.cobertura_triplice_viral_d1 > 100 THEN 100.0
            ELSE v.cobertura_triplice_viral_d1 
        END
    ), 2) AS media_d1_tratada,
    ROUND(AVG(
        CASE 
            WHEN v.cobertura_triplice_viral_d2 > 100 THEN 100.0
            ELSE v.cobertura_triplice_viral_d2 
        END
    ), 2) AS media_d2_tratada
FROM vacinacao v
WHERE v.ano >= 2018
  AND v.cobertura_triplice_viral_d1 IS NOT NULL
GROUP BY v.sigla_uf
ORDER BY media_d1_tratada ASC;