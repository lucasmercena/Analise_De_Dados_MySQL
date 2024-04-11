# --- ANÁLISES DE DADOS COM SQL --- #

-- Agrupamentos
-- Filtragem em agrupamentos
-- Subqueries
-- Criação de Views

-- Lembrando das tabelas do banco de dados...
-- AQUI estou visualizando todas as tabelas do banco de dados para ter noção de qual tabela eu vou precisar para resolver os cases
USE HASHTAGMOVIE;
SELECT * FROM alugueis;
SELECT * FROM atores;
SELECT * FROM atuacoes;
SELECT * FROM clientes;
SELECT * FROM filmes;

# =======        PARTE 1:        =======#
# =======  CRIANDO AGRUPAMENTOS  =======#

-- CASE 1. Você deverá começar fazendo uma análise para descobrir o preço médio de aluguel dos filmes.
# No primeiro select, selecionei o nome dos filmes e o valor de todos eles
# No segundo selecionei a media dos valores, como solicitado no CASE 1.
SELECT TITULO, PRECO_ALUGUEL FROM FILMES;
SELECT AVG(preco_aluguel) AS preco_medio 
FROM filmes;

-- CASE 2. Agora que você sabe o preço médio para se alugar filmes na hashtagmovie, você deverá ir além na sua análise e 
-- descobrir qual é o preço médio para cada gênero de filme.
/*
genero                   | preco_medio
______________________________________
Comédia                  | X
Drama                    | Y
Ficção e Fantasia        | Z
Mistério e Suspense      | A
Arte                     | B
Animação                 | C
Ação e Aventura          | D
*/
SELECT 
	genero, 
	ROUND(AVG(preco_aluguel), 2) AS preco_medio,
    COUNT(*) AS qntd_generos
FROM filmes
GROUP BY genero;

# =======              PARTE 2:               =======#
# =======       FILTROS EM AGRUPAMENTOS       =======#

-- CASE 3: Fazer a mesma análise, mas considerando apenas os filmes com ANO_LANCAMENTO igual a 2011.

SELECT 
	GENERO,
    ROUND(AVG(PRECO_ALUGUEL), 2) AS PRECO_MEDIO,
    COUNT(*) AS QNTD_GENEROS
FROM FILMES
WHERE ANO_LANCAMENTO = 2011
GROUP BY GENERO;

# =======                         PARTE 3:                           =======#
# =======  SUBQUERIES: UTILIZANDO UM SELECT DENTRO DE OUTRO SELECT   =======#

-- CASE 4. Você precisará fazer uma análise de desempenho dos alugueis. 
-- Para isso, uma análise comum é identificar quais aluguéis tiveram nota acima da média. Você seria capaz de fazer isso?

SELECT ROUND(AVG(nota), 2) AS media_nota FROM alugueis;
SELECT 
	id_filme AS filme,
    nota
FROM alugueis
WHERE
	nota >= (SELECT ROUND(AVG(nota), 2) AS media_nota FROM alugueis);

# =======           PARTE 4:             =======#
# =======  Criando Views - CREATE VIEW   =======#

-- CASE 5. Crie uma view para guardar o resultado do SELECT abaixo.

CREATE VIEW resultado AS
SELECT
	genero,
	ROUND(AVG(preco_aluguel), 2) AS media_preco,
    COUNT(*) AS qtd_filmes
FROM filmes
GROUP BY genero;

SELECT * FROM resultado;

