#versao final
import os
from logging.config import dictConfig
from flask import Flask, jsonify, request
from psycopg.rows import namedtuple_row
from psycopg_pool import ConnectionPool
from datetime import datetime

# Use a variável de ambiente DATABASE_URL se existir, caso contrário, use a predefinição.
DATABASE_URL = os.environ.get("DATABASE_URL", "postgres://saude:saude@postgres/saude")

pool = ConnectionPool(
    conninfo=DATABASE_URL,
    kwargs={
        "autocommit": True,
        "row_factory": namedtuple_row,
    },
    min_size=4,
    max_size=10,
    open=True,
    name="postgres_pool",
    timeout=5,
)

dictConfig(
    {
        "version": 1,
        "formatters": {
            "default": {
                "format": "[%(asctime)s] %(levelname)s em %(module)s:%(lineno)s - %(funcName)20s(): %(message)s",
            }
        },
        "handlers": {
            "wsgi": {
                "class": "logging.StreamHandler",
                "stream": "ext://flask.logging.wsgi_errors_stream",
                "formatter": "default",
            }
        },
        "root": {"level": "INFO", "handlers": ["wsgi"]},
    }
)

app = Flask(__name__)
app.config.from_prefixed_env()
log = app.logger

def is_decimal(n):
    try:
        int(n)
        return True
    except ValueError:
        return False
    
def consulta_verifica_hora(data, hora) :

    nova_data = datetime.strptime(data, '%Y-%m-%d')
    nova_hora = datetime.strptime(hora, '%H:%M:%S')
    testar = datetime.combine(nova_data, nova_hora)

    return testar > datetime.now()


@app.route("/", methods=["GET"])
def listar_clinicas():
    """Listar todas as clínicas (nome e morada)."""
    with pool.connection() as conn:
        with conn.cursor() as cur:
            clinicas = cur.execute(
                """
                SELECT nome, morada
                FROM clinica
                ORDER BY nome;
                """
            ).fetchall()
            log.debug(f"Encontradas {cur.rowcount} linhas.")

    return jsonify(clinicas), 200

@app.route("/c/<clinica>", methods=["GET"])
def listar_especialidades(clinica):
    """Listar todas as especialidades oferecidas numa clínica."""
    with pool.connection() as conn:
        with conn.cursor() as cur:
            especialidades = cur.execute(
                """
                SELECT DISTINCT especialidade
                FROM trabalha
                JOIN medico USING (nif)
                WHERE trabalha.nome = %(clinica)s
                ORDER BY especialidade;
                """,
                {"clinica": clinica},
            ).fetchall()
            log.debug(f"Encontradas {cur.rowcount} linhas.")

    if not especialidades:
        return jsonify({"message": "Clínica não encontrada ou nenhuma especialidade disponível.", "status": "error"}), 404

    return jsonify(especialidades), 200

@app.route("/c/<clinica>/<especialidade>", methods=["GET"])
def listar_medicos(clinica, especialidade):
    """Listar todos os médicos de uma especialidade numa clínica e os seus três primeiros horários de consulta disponíveis (data e hora)."""
    with pool.connection() as conn:
        with conn.cursor() as cur:
            medicos = cur.execute(
                """
                SELECT m.nome
                FROM medico m
                JOIN trabalha t USING (nif)
                WHERE t.nome = %(clinica)s 
                AND m.especialidade = %(especialidade)s
                ORDER BY nome_medico;
                """,
                {"clinica": clinica, "especialidade": especialidade},
            ).fetchall()

            if not medicos:
                return jsonify({"message": "Nenhum médico encontrado na clínica com essa especialidade.", "status": "error"}), 404

            disponibilidade_medicos = []
            for medico in medicos:
                disponibilidade = cur.execute(
                    """
                    SELECT data_consulta, hora_consulta
                    FROM consulta
                    WHERE nome_medico = %(medico)s AND nome_clinica = %(clinica)s
                    AND especialidade = %(especialidade)s AND data_consulta > %(agora)s
                    ORDER BY data_consulta, hora_consulta
                    LIMIT 3;
                    """,
                    {
                        "medico": medico.nome_medico,
                        "clinica": clinica,
                        "especialidade": especialidade,
                        "agora": datetime.now(),
                    },
                ).fetchall()
                disponibilidade_medicos.append({
                    "nome_medico": medico.nome_medico,
                    "disponibilidade": disponibilidade
                })
            log.debug(f"Encontradas {cur.rowcount} linhas.")

    return jsonify(disponibilidade_medicos), 200


# @app.route("/accounts/<account_number>/update", methods=("GET",))
# def registar_consulta_ver(account_number):
#     """Show the page to update the account balance."""
#     with pool.connection() as conn:
#         with conn.cursor() as cur:        
#             account = cur.execute(
#             """
#             SELECT COUNT(*)
#             FROM consulta;
#             """,
#         ).fetchone()
#         log.debug(f"Found {cur.rowcount} rows.")
    
#     return jsonify(account)


@app.route("/a/<clinica>/registar", methods=["POST"])
def registar_consulta_inserir(clinica):
    """Registar uma consulta numa clínica."""
    paciente = request.args.get("paciente")
    medico = request.args.get("medico")
    data_consulta = request.args.get("data_consulta")
    hora_consulta = request.args.get("hora_consulta")


    if not paciente or not medico or not data_consulta or not hora_consulta:
        return jsonify({"message": "Todos os campos (paciente, medico, data_consulta, hora_consulta) são obrigatórios.", "status": "error"}), 400 

    error = None

    if not paciente or not medico or not data_consulta or not hora_consulta:
        error = "Todos os campos (paciente, medico, data_consulta, hora_consulta) são obrigatórios."
    if not is_decimal(paciente) or not is_decimal(medico):
        error = f"ssn do paciente e nif do medico tem de ser um número. Tipo de paciente: {type(paciente)}, Tipo de medico: {type(medico)}"
    print(type(paciente), medico)
    # if len(paciente) != 11 or len(medico) != 9:
    #     error = "o ssn do paciente tem de ter 11 digitos, e o nif do medico tem de ter 9"
    

    if error is not None:
        return error, 400
    else:
        with pool.connection() as conn:
            with conn.cursor() as cur:
                try:
                    with conn.transaction():
                        cur.execute(
                            """
                            INSERT INTO consulta (ssn, nif, nome, data, hora)
                            VALUES (%(clinica)s, %(paciente)s, %(medico)s, %(data_consulta)s, %(hora_consulta)s);
                            """,
                            {
                            
                                "clinica": clinica,
                                "paciente": paciente,
                                "medico": medico,
                                "data_consulta": data_consulta,
                                "hora_consulta": hora_consulta,
                            },
                        )
                except Exception as e:
                    return jsonify({"message": str(e), "status": "error"}), 500

    return jsonify({"message": "Consulta registada com sucesso.", "status": "success"}), 201

@app.route("/a/<clinica>/cancelar", methods=["POST"])
def cancelar_consulta(clinica):
    """Cancelar uma consulta numa clínica."""
    paciente = request.args.get("paciente")
    medico = request.args.get("medico")
    data_consulta = request.args.get("data_consulta")
    hora_consulta = request.args.get("hora_consulta")

    error = None
    if not paciente or not medico or not data_consulta or not hora_consulta:
        return jsonify({"message": "Todos os campos (paciente, medico, data_consulta, hora_consulta) são obrigatórios.", "status": "error"}), 400
    
    # consulta_verifica_hora= data_consulta + hora_consulta
    # if datetime.strptime(consulta_verifica_hora, '%Y-%m-%d') < datetime.now():
    #     error = "Nao se pode cancelar consultas passadas."

    if not consulta_verifica_hora(data_consulta, hora_consulta):
         error = "Nao se pode cancelar consultas passadas."


    if error is not None:
        return error, 400
    with pool.connection() as conn:
        with conn.cursor() as cur:
            try:
                with conn.transaction():
                    resultado = cur.execute(
                        """
                        DELETE FROM consulta
                        WHERE nome = %(clinica)s AND ssn = %(paciente)s
                        AND nif = %(medico)s AND data = %(data_consulta)s
                        AND hora = %(hora_consulta)s;
                        """,
                        {
                            "clinica": clinica,
                            "paciente": paciente,
                            "medico": medico,
                            "data_consulta": data_consulta,
                            "hora_consulta": hora_consulta,
                        },
                    )
            except Exception as e:
                return jsonify({"message": str(e), "status": "error"}), 500

    if resultado.rowcount == 0:
        return jsonify({"message": "Consulta não encontrada.", "status": "error"}), 404

    return jsonify({"message": "Consulta cancelada com sucesso.", "status": "success"}), 200

@app.route("/ping", methods=["GET"])
def ping():
    log.debug("ping!")
    return jsonify({"message": "pong!", "status": "success"})

if __name__ == "__main__":
    app.run()
