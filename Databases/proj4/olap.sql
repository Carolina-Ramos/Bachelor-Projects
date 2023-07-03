/*1-     */


SELECT d.ano, d.mes, a.especialidade, COUNT(id_analise)
FROM f_analise as a INNER JOIN d_tempo as t on a.id_data_registo = d.id_tempo
WHERE d.ano > 2016 and d.ano < 2021 group by cube(a.especialidade, d.mes, d.ano);

/*2-     */

SELECT i.num_concelho, tabela.mes, tabela.dia_da_semana, COUNT(substancia)
FROM (f_presc_venda as p INNER JOIN d_tempo as t on p.id_data_registo=d.id_tempo) as tabela NATURAL JOIN d_instituicao as i
WHERE i.num_regiao=3 and tabela.trimestre=1 group by rollup (i.num_concelho,  tabela.mes, tabela.dia_da_semana)
