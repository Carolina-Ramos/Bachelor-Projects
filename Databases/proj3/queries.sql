/* 1- Qual o concelho onde se fez o maior volume de vendas hoje?*/
SELECT concelho
FROM (SELECT conc.nome AS concelho, vf.preco * vf.quant AS preco_total
		  FROM(( instituicao AS i
		         INNER JOIN venda_farmacia AS vf on vf.inst = i.nome)
		         INNER JOIN concelho AS conc on i.num_concelho = conc.num_concelho and i.num_regiao = conc.num_regiao)
   		WHERE vf.data_registo = CURRENT_DATE) AS nome GROUP BY concelho
HAVING SUM(nome.preco_total) >= all(
	 SELECT SUM(total.preco_total)
   FROM(
		   SELECT conc.nome AS concelho, vf.preco * vf.quant AS preco_total
		   FROM(( instituicao AS i
		          INNER JOIN venda_farmacia AS vf on vf.inst = i.nome)
		          INNER JOIN concelho AS conc on i.num_concelho = conc.num_concelho and i.num_regiao = conc.num_regiao)
   		 WHERE vf.data_registo = CURRENT_DATE) AS total GROUP BY concelho);

/* 2- Qual o médico que mais prescreveu no 1º semestre de 2019 em cada região? */
SELECT medico, regiao
FROM( SELECT nome_data.nome AS medico, r.nome AS regiao
			FROM( SELECT nome, nome_instituicao
    				FROM consulta
	  						 NATURAL JOIN medico
	  					   NATURAL JOIN prescricao
     			  WHERE data>= '2019-01-01' and data<='2019-06-30') AS nome_data, instituicao AS i, regiao AS r
			WHERE nome_data.nome_instituicao = i.nome and i.num_regiao = r.num_regiao) AS tab GROUP BY medico, regiao
HAVING COUNT(medico)>=all (
 SELECT COUNT(medico)
 FROM( SELECT nome_data.nome AS medico, r.nome AS regiao
			 FROM( SELECT nome, nome_instituicao
     				 FROM consulta
	  			 				NATURAL JOIN medico
	  							NATURAL JOIN prescricao
       WHERE data>= '2019-01-01' and data<='2019-06-30') AS nome_data, instituicao AS i, regiao AS r
	WHERE nome_data.nome_instituicao = i.nome and i.num_regiao = r.num_regiao) AS tab GROUP BY medico, regiao);
	
/* 3- Quais são os médicos que já prescreveram aspirina em receitas aviadas em todas as farmácias
do concelho de Arouca este ano?*/
SELECT m.nome
FROM medico AS m
WHERE NOT EXISTS(
	SELECT i.nome AS instituicao
	FROM (( instituicao AS i
			    INNER JOIN concelho AS conc on i.num_concelho = conc.num_concelho and i.num_regiao = conc.num_regiao))
	WHERE i.tipo ='farmacia' and conc.nome = 'Arouca'
EXCEPT
	(SELECT tab.instituicao
	FROM ( SELECT vf.num_venda AS num_venda, vf.inst AS instituicao, conc.nome AS concelho
		     FROM (( instituicao AS i
				 				 INNER JOIN venda_farmacia AS vf on vf.inst = i.nome)
				         INNER JOIN concelho AS conc on i.num_concelho = conc.num_concelho and i.num_regiao = conc.num_regiao)
		     WHERE conc.nome = 'Arouca' and EXTRACT(YEAR FROM vf.data_registo) = EXTRACT(YEAR FROM CURRENT_DATE)) AS tab NATURAL JOIN prescricao_venda AS pV
	WHERE m.num_cedula = pV.num_cedula));

/* 4- Quais são os doentes que já fizeram análises mas ainda não aviaram prescrições este mês? */
SELECT DISTINCT num_doente
FROM( SELECT num_doente
	    FROM analise
      WHERE EXTRACT(MONTH FROM data_registo) = EXTRACT(MONTH FROM CURRENT_DATE)) AS doentes
WHERE num_doente NOT IN (
	SELECT num_doente
	FROM prescricao_venda
	WHERE EXTRACT(MONTH FROM data) = EXTRACT(MONTH FROM CURRENT_DATE));
