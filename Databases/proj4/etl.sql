insert into d_instituicao(nome, tipo, num_regiao, num_concelho)
  select nome, tipo, num_regiao, num_concelho
  from instituicao NATURAL JOIN regiao NATURAL JOIN concelho;

insert into d_tempo(dia,dia_da_semana,semana,mes,trimestre,ano)
  select extract(DAY from data) as dia, extract(DOW from data) as dia_da_semana, extract(WEEK from data) as semana, extract(MONTH from data) as mes, extract(QUARTER from data) as trimestre, extract(YEAR from data) as ano
  from prescricao_venda;

insert into d_tempo(dia,dia_da_semana,semana,mes,trimestre,ano)
  select extract(DAY from data_registo) as dia, extract(DOW from data_registo) as dia_da_semana, extract(WEEK from data_registo) as semana, extract(MONTH from data_registo) as mes, extract(QUARTER from data_registo) as trimestre, extract(YEAR from data_registo) as ano
  from analise;


insert into f_presc_venda(num_cedula,num_doente, id_data_registo, id_inst, substancia, quant)
    select num_cedula,num_doente, id_tempo as id_data_registo, id_inst,nome,quant
    from prescricao NATURAL JOIN d_tempo NATURAL JOIN d_instituicao;

insert into f_analise(num_cedula,num_doente, id_data_registo, id_inst,nome, quant)
    select num_cedula, num_doente, id_data_registo, id_inst, nome, quant
    from analise NATURAL JOIN d_tempo NATURAL JOIN d_instituicao;

insert into fact_table(id_presc_venda, id_analise, id_tempo, id_inst)
      select id_presc_venda, id_analise, id_tempo, id_inst
      from f_presc_venda NATURAL JOIN f_analise NATURAL JOIN d_tempo NATURAL JOIN d_instituicao;
