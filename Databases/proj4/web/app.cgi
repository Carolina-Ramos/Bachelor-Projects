#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request

## Libs postgres
import psycopg2
import psycopg2.extras

app = Flask(__name__)

## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist190118"
DB_DATABASE=DB_USER
DB_PASSWORD="qtcy6843"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)

###############################################################################
##MENU PRINCIPAL
###############################################################################
@app.route('/')
def list_accounts():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    return render_template("menu.html", cursor=cursor)
  except Exception as e:
    return str(e) #Renders a page with the error.
  finally:
    cursor.close()
    dbConn.close()


###############################################################################
##Inserir Instituicao
###############################################################################
@app.route('/inputInserirInstituicao')
def input_instituicao():
  try:
    return render_template("inputInserirInstituicao.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/insertI', methods=["POST"])
def inserir_instituicao():
    dbConn=None
    cursor=None
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "INSERT INTO instituicao(nome, tipo, num_regiao, num_concelho) VALUES (%s, %s, %s, %s);"
      input = (request.form["nome"], request.form["tipo"], request.form["regiao"], request.form["concelho"])
      cursor.execute(query, input)
      return query
    except Exception as e:
      return str(e)
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()

###############################################################################
##Inserir Medico
###############################################################################
@app.route('/inputInserirMedico')
def input_medico():
  try:
    return render_template("inputInserirMedico.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/insertM', methods=["POST"])
def inserir_medico():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "INSERT INTO medico(num_cedula, nome, especialidade) VALUES (%s, %s, %s);"
    input = (request.form["num_cedula"], request.form["nome"], request.form["especialidade"])
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

###############################################################################
##Inserir Prescricao
###############################################################################
@app.route('/inputInserirPrescricao')
def input_prescricao():
  try:
    return render_template("inputInserirPrescricao.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/insertP', methods=["POST"])
def inserir_prescricao():
    dbConn=None
    cursor=None
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "INSERT INTO prescricao(num_cedula, num_doente, data, substancia, quant) VALUES (%s, %s, %s, %s, %s);"
      input = (request.form["num_cedula"], request.form["num_doente"], request.form["data"], request.form["substancia"], request.form["quant"])
      cursor.execute(query, input)
      return query
    except Exception as e:
      return str(e)
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()

###############################################################################
##Inserir Analise
###############################################################################
@app.route('/inputInserirAnalise')
def input_analise():
  try:
    return render_template("inputInserirAnalise.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/insertA', methods=["POST"])
def inserir_analise():
    dbConn=None
    cursor=None
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "INSERT INTO analise(num_analise, especialidade, num_cedula, num_doente, data, data_registo, nome, quant, inst) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);"
      input = (request.form["num_analise"], request.form["especialidade"], request.form["num_cedula"], request.form["num_doente"], request.form["data"], request.form["data_registo"], request.form["nome"], request.form["quant"], request.form["inst"])
      cursor.execute(query, input)
      return query
    except Exception as e:
      return str(e)
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()

###############################################################################
##Remover Instituicao
###############################################################################
@app.route('/inputRemoverInstituicao')
def input_instituicaoRemove():
  try:
    return render_template("inputRemoverInstituicao.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/removeI', methods=["POST"])
def remover_instituicao():
    dbConn=None
    cursor=None
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "DELETE FROM instituicao WHERE nome = %s;"
      input = (request.form["nome"], )
      cursor.execute(query, input)
      return query
    except Exception as e:
      return str(e)
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()

###############################################################################
##Remover Medico
###############################################################################
@app.route('/inputRemoverMedico')
def input_medicoRemove():
  try:
    return render_template("inputRemoverMedico.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/removeM', methods=["POST"])
def remover_medico():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "DELETE FROM medico WHERE num_cedula = %s;"
    input = (request.form["num_cedula"], )
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

###############################################################################
##Remover Prescricao
###############################################################################
@app.route('/inputRemoverPrescricao')
def input_prescricaoRemove():
  try:
    return render_template("inputRemoverPrescricao.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/removeP', methods=["POST"])
def remover_prescricao():
    dbConn=None
    cursor=None
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "DELETE FROM prescricao WHERE num_cedula = %s and num_doente = %s and data = %s and substancia = %s;"
      input = (request.form["num_cedula"], request.form["num_doente"], request.form["data"], request.form["substancia"])
      cursor.execute(query, input)
      return query
    except Exception as e:
      return str(e)
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()

###############################################################################
##Remover Analise
###############################################################################
@app.route('/inputRemoverAnalise')
def input_analiseRemove():
  try:
    return render_template("inputRemoverAnalise.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/removeA', methods=["POST"])
def remover_analise():
    dbConn=None
    cursor=None
    try:
      dbConn = psycopg2.connect(DB_CONNECTION_STRING)
      cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
      query = "DELETE FROM analise WHERE num_analise = %s;"
      input = (request.form["num_analise"], )
      cursor.execute(query, input)
      return query
    except Exception as e:
      return str(e)
    finally:
      dbConn.commit()
      cursor.close()
      dbConn.close()

###############################################################################
##Editar Instituicao
###############################################################################
@app.route('/inputEditarInstituicao')
def input_instituicaoEdita():
  try:
    return render_template("inputEditarInstituicao.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/updateI', methods=["POST"])
def update_instituicao():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "UPDATE instituicao SET nome = %s, tipo = %s, num_regiao = %s, num_concelho = %s WHERE nome = %s;"
    input = (request.form["nome_novo"], request.form["tipo"], request.form["regiao"], request.form["concelho"], request.form["nome_antigo"])
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

###############################################################################
##Editar Medico
###############################################################################
@app.route('/inputEditarMedico')
def input_medicoEdita():
  try:
    return render_template("inputEditarMedico.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/updateM', methods=["POST"])
def update_medico():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "UPDATE medico SET nome = %s, especialidade = %s WHERE num_cedula = %s;"
    input = (request.form["nome"], request.form["especialidade"], request.form["num_cedula"])
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

###############################################################################
##Editar Prescricao
###############################################################################
@app.route('/inputEditarPrescricao')
def input_prescricaoEdita():
  try:
    return render_template("inputEditarPrescricao.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/updateP', methods=["POST"])
def update_prescricao():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "UPDATE prescricao SET substancia = %s, quant = %s WHERE substancia = %s AND num_cedula = %s AND num_doente = %s AND data = %s;"
    input = (request.form["substancia_nova"], request.form["quant"], request.form["substancia_antiga"], request.form["num_cedula"], request.form["num_doente"], request.form["data"])
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

###############################################################################
##Editar Analise
###############################################################################
@app.route('/inputEditarAnalise')
def input_analiseEdita():
  try:
    return render_template("inputEditarAnalise.html", params=request.args)
  except Exception as e:
    return str(e)

@app.route('/updateA', methods=["POST"])
def update_analise():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "UPDATE analise SET data_registo = %s, nome = %s, quant = %s, inst = %s WHERE num_analise = %s;"
    input = (request.form["data_registo"], request.form["nome"], request.form["quant"], request.form["inst"], request.form["num_analise"])
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

###############################################################################
##Realizar venda com prescricao
###############################################################################
@app.route('/vendaComPrescricao', methods=["POST"])
def venda_comPrescricao():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = """INSERT INTO venda_farmacia(num_venda, data_registo, substancia, quant, preco, inst) VALUES (%s, %s, %s, %s, %s, %s);
               INSERT INTO prescricao_venda(num_cedula, num_doente, data, substancia, num_venda) VALUES (%s, %s, %s, %s, %s);"""
    input = (request.form["num_venda"], request.form["data_venda"], request.form["substancia"], request.form["quant"], request.form["preco"], request.form["inst"], request.form["num_cedula"], request.form["num_doente"], request.form["data"], request.form["substancia"], request.form["num_venda"])
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

@app.route('/inputVendaComPrescricao')
def input_vendaComPrescricao():
    try:
      return render_template("inputVendaComPrescricao.html", params=request.args)
    except Exception as e:
      return str(e)

###############################################################################
##Realizar venda sem prescricao
###############################################################################
@app.route('/vendaSemPrescricao', methods=["POST"])
def venda_semPrescricao():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "INSERT INTO venda_farmacia(data_registo, substancia, quant, preco, inst) VALUES (%s, %s, %s, %s, %s);"
    input = (request.form["data"], request.form["substancia"], request.form["quantidade"], request.form["preco"], request.form["instituicao"])
    cursor.execute(query, input)
    return query
  except Exception as e:
    return str(e)
  finally:
    dbConn.commit() #MODIFICAR BASES DE DADOS
    cursor.close()
    dbConn.close()

@app.route('/inputVendaSemPrescricao')
def input_vendaSemPrescricao():
    try:
      return render_template("inputVendaSemPrescricao.html", params=request.args)
    except Exception as e:
      return str(e)

###############################################################################
##Listar as substancia prescritas por um medico num dado mes do ano
###############################################################################
@app.route('/listarSubstancias', methods=["POST"])
def list_accounts_edit():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT num_cedula, substancia FROM prescricao WHERE EXTRACT(YEAR FROM data) = %s and EXTRACT(MONTH FROM data)= %s and num_cedula = %s;"
    input = (request.form["ano"], request.form["month"], request.form["num_cedula"])
    cursor.execute(query, input)
    return render_template("listarSubstancias.html", cursor=cursor)
  except Exception as e:
    return str(e)
  finally:
    cursor.close()
    dbConn.close()

@app.route('/listarSubstancias_input')
def input_listarSubstancias():
  try:
    return render_template("listarSubstancias_input.html", params=request.args)
  except Exception as e:
    return str(e)

############################################################################################
##Listar os valores de glicémia mais alto e mais baixo em cada concelho e respectivo doente
############################################################################################
@app.route('/listarMaxGlicemia')
def list_Max_glicemia():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT c.nome, num_doente, quant FROM analise as a INNER JOIN (SELECT max(quant) as maximo, inst FROM analise WHERE nome = 'glicemia' group by inst) as m on a.quant = m.maximo and a.inst = m.inst, concelho as c, instituicao as i WHERE a.inst = i.nome and i.num_regiao = c.num_regiao and i.num_concelho = c.num_concelho;"
    cursor.execute(query)
    return render_template("listarMaxGlicemia.html", cursor=cursor)
  except Exception as e:
    return str(e)
  finally:
    cursor.close()
    dbConn.close()

@app.route('/listarMinGlicemia')
def list_Min_glicemia():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT c.nome, num_doente, quant FROM analise as a INNER JOIN (SELECT min(quant) as minimo, inst FROM analise WHERE nome = 'glicemia' group by inst) as m on a.quant = m.minimo and a.inst = m.inst, concelho as c, instituicao as i WHERE a.inst = i.nome and i.num_regiao = c.num_regiao and i.num_concelho = c.num_concelho;"
    cursor.execute(query)
    return render_template("listarMinGlicemia.html", cursor=cursor)
  except Exception as e:
    return str(e)
  finally:
    cursor.close()
    dbConn.close()
###############################################################################
###############################################################################
CGIHandler().run(app)
