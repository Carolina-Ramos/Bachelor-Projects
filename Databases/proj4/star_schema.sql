drop table d_tempo CASCADE;
drop table d_instituicao CASCADE;
drop table f_prescr_venda CASCADE;
drop table f_analise CASCADE;
drop table fact_table CASCADE;

create table d_tempo(
id_tempo serial not null unique,
dia integer check (dia >=1 and dia <=31),
dia_da_semana integer check (dia_da_semana >=1 and dia_da_semana <=7),
semana integer check (semana >=1) ,
mes integer chech (mes >=1 and mes <= 12),
trimestre integer check (trimestre >=1 and trimestre <=4),
ano integer,
constraint pk_d_tempo primary key(id_tempo)
);

create table d_instituicao(
	id_inst serial not null unique,
	nome char(100),
	tipo char(100),
	num_regiao integer,
	num_concelho integer,
	constraint pk_d_instituicao primary key(id_inst) ,
	constraint fk_d_instituicao_instituicao foreign key(nome) references instituicao(nome),
	constraint fk_d_instituicao_regiao foreign key(num_regiao) references região(num_regiao),
	constraint fk_d_instituicao_concelho foreign key(num_concelho) references concelho(num_concelho)
);


create table f_presc_venda(
    id_presc_venda integer unique,
    id_medico integer,
    num_doente integer,
    id_data_registo integer,
    id_inst integer,
    substancia char(50),
    quant integer check(quant>0),
    constraint pk_f_presc_venda primary key(id_presc_venda),
    constraint fk_f_presc_venda_prescricao_venda foreign key(id_presc_venda) references prescricao_venda(num_venda),
    constraint fk_f_presc_venda_medico foreign key (id_medico) references medico(num_cedula),
    constraint fk_f_presc_venda_d_tempo foreign key (id_data_registo) references d_tempo(id_tempo),
    constraint fk_f_presc_venda_d_instituicao foreign key(id_inst) references d_instituicao(id_inst)
);

create table f_analise(
	id_analise integer unique,
	id_medico integer,
	num_doente integer,
	id_data_registo integer,
	id_inst integer,
	nome char(100),
	quant integer,
	constraint pk_f_analise primary key(id_analise),
  constraint fk_f_analise_analise foreign key (id_analise) references analise(num_analise),
  constraint fk_f_analise_medico foreign key (id_medico) references medico(num_cedula),
  constraint fk_f_analise_d_tempo foreign key (id_data_registo) references d_tempo(id_tempo),
  constraint fk_f_analise_d_instituicao foreign key (id_inst) references d_instituicao(id_inst)
);

create table fact_table(
	id_presc_venda integer unique,
	id_analise integer unique,
	id_tempo serial not null unique,
	id_inst serial not null unique
	constraint pk_fact_table primary key(	id_presc_venda, id_analise, id_tempo, id_inst),
	constraint fk_fact_table_f_presc_venda foreign key (id_presc_venda) references f_presc_venda(id_presc_venda) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_fact_table_f_analise foreign key (id_analise) references f_analise(id_analise) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_fact_table_d_tempo foreign key (id_tempo) references d_tempo(id_tempo) ON DELETE CASCADE ON UPDATE CASCADE,
	constraint fk_fact_table_d_instituicao foreign key (id_inst) references d_instituicao(id_inst) ON DELETE CASCADE ON UPDATE CASCADE
)
