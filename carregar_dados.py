# Importa bibliotecas
import sqlite3
import pandas as pd

# Conectar ao banco de dados (Cria um único arquivo de banco)
conn = sqlite3.connect('data/banco_vacinacao.db')

# Carrega e grava a tabela de vacinação
df_vacinacao = pd.read_csv('data/vacinacao.csv')
df_vacinacao.to_sql('vacinacao', conn, if_exists='replace', index=False)

# Carrega e grava a tabela de municípios no MESMO banco
df_municipios = pd.read_csv('data/municipios.csv')
df_municipios.to_sql('municipios', conn, if_exists='replace', index=False)

# Carrega e grava a tabela de UF no MESMO banco
df_uf = pd.read_csv('data/uf.csv')
df_uf.to_sql('uf', conn, if_exists='replace', index=False)

# Encerra a conexão com o banco
conn.close()

print("Dados carregados com sucesso no banco_vacinacao.db!")