/*1-RI-100: um médico não pode dar mais de 100 consultas por semana na mesma instituição*/
  create or replace function  RI_100() returns trigger as $$
  begin
    if new.num_cedula not in (
        SELECT num_cedula
        FROM( SELECT num_cedula, week, count(week)
              FROM ( SELECT num_cedula, extract(week from data) as week, extract(year from data) as year
                     FROM consulta) AS tabela1 group by num_cedula, week ) as tabela2
        WHERE tabela2.count <101 and extract(week from new.data) = tabela2.week)
       then
            raise exception 'O Médico % excedeu o número de consultas.',new.num_cedula;
    end if;
    return new;
  End;
  $$ Language plpgsql;

  create trigger RI_100_trigger before insert on consulta for each row execute procedure RI_100();

/*2-RI-análise: numa análise, a consulta associada pode estar omissa; não estando, a especialidade
da consulta tem de ser igual à do médico.*/
  create or replace function  RI_analise() returns trigger as $$
    declare especialidadeMedico varchar(100);
    begin
      if new.num_cedula is not null then
    		  SELECT especialidade into especialidadeMedico
    		  FROM medico as m
      		WHERE new.num_cedula = m.num_cedula;
    		  if new.especialidade != especialidadeMedico then
         		 raise exception 'O Médico % não tem a mesma especialidade que a analise.',new.num_cedula;
      		end if;
      end if;
    return new;
  End;
  $$ Language plpgsql;

  create trigger RI_analise_trigger before insert on analise for each row execute procedure RI_analise();
