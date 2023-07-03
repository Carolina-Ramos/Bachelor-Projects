drop table prescricao_venda cascade;
drop table venda_farmacia cascade;
drop table analise cascade;
drop table prescricao cascade;
drop table consulta cascade;
drop table medico cascade;
drop table instituicao cascade;
drop table concelho cascade;
drop table regiao cascade;


create table regiao(
  num_regiao serial not null unique,
  nome char(100) not null,
  num_habitantes serial,
  constraint pk_regiao primary key(num_regiao)
);

create table concelho(
  num_concelho serial not null,
  num_regiao serial not null,
  nome char(100) not null,
  num_habitantes serial,
  constraint pk_concelho primary key(num_concelho, num_regiao),
  constraint fk_concelho_regiao foreign key(num_regiao) references regiao(num_regiao)
);

create table instituicao(
  nome char(100) not null unique,
  tipo char(100) not null,
  num_regiao serial not null,
  num_concelho serial not null,
  constraint pk_instituicao primary key(nome)
);

create table medico(
  num_cedula serial not null unique,
  nome char(100) not null,
  especialidade char(50) not null,
  constraint pk_medico primary key(num_cedula)
);

create table consulta(
  num_cedula serial not null,
  num_doente serial not null,
  data date not null,
  nome_instituicao char(100) not null,
  constraint pk_consulta primary key(num_cedula, num_doente, data),
  constraint fk_consulta_instituicao foreign key(nome_instituicao) references instituicao(nome),
  constraint fk_consulta_medico foreign key(num_cedula) references medico(num_cedula),
  constraint sunday check(extract(dow from data) > 0),
  constraint saturday check(extract(dow from data) < 6)
);

create table prescricao(
  num_cedula serial not null,
  num_doente serial not null,
  data date not null,
  substancia char(50) not null,
  quant serial not null,
  constraint pk_prescricao primary key(num_cedula, num_doente, data, substancia),
  constraint fk_prescricao_consulta foreign key(num_cedula, num_doente, data) references consulta(num_cedula, num_doente, data)
);

create table analise(
  num_analise serial not null unique,
  especialidade char(50) not null,
  num_cedula serial not null,
  num_doente serial not null,
  data date not null,
  data_registo date not null,
  nome char(100),
  quant serial not null,
  inst char(100),
  constraint pk_analise primary key(num_analise),
  constraint fk_analise_consulta foreign key(num_cedula, num_doente, data) references consulta(num_cedula, num_doente, data),
  constraint fk_analise_instituicao foreign key(inst) references instituicao(nome)
);

create table venda_farmacia(
  num_venda serial not null unique,
  data_registo date not null,
  substancia char(50) not null,
  quant serial not null,
  preco serial not null,
  inst char(100) not null,
  constraint pk_farmacia primary key(num_venda),
  constraint fk_venda_farmacia_instituicao foreign key(inst) references instituicao(nome)
);

create table prescricao_venda(
  num_cedula serial not null,
  num_doente serial not null,
  data date not null,
  substancia char(50) not null,
  num_venda serial not null,
  constraint pk_prescricao_venda primary key(num_cedula, num_doente, data, substancia, num_venda),
  constraint fk_prescricao_venda_prescricao foreign key(num_cedula, num_doente, data, substancia) references prescricao(num_cedula, num_doente, data, substancia),
  constraint fk_prescricao_venda_venda_farmacia foreign key(num_venda) references venda_farmacia(num_venda)
);
