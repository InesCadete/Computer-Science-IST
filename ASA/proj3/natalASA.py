from pulp import LpProblem, LpMaximize, LpVariable, lpSum
from pulp import GLPK
import time

start_time = time.time()


def maximizar_lucro(t, p, max_brinquedos, brinquedos, pacotes):
    problema = LpProblem("Maximizar_Lucro_Natal", LpMaximize)

    # decision variables
    x = {i: LpVariable(f"x{i}", lowBound=0, upBound= brinquedos[i][1], cat="Integer") for i in range(1, t + 1)}
    y = {i: LpVariable(f"y{i}", lowBound=0, upBound= pacotes[i][1], cat="Integer") for i in range(1, p + 1)}

    
    # restrictions on production capacity
    for i in range(1, t + 1):        

        numero_pacs = len(brinquedos[i][2])
        problema += x[i] + lpSum(y[brinquedos[i][2][pac]] for pac in range(0, numero_pacs )) <= brinquedos[i][1], f"Capacidade_Brinquedo_{i}"


    # restriction of total capacity of the factory
    max_produzidos = lpSum(x[i] for i in range(1, t + 1)) + 3*lpSum(y[i] for i in range(1, p + 1))
    problema +=  max_produzidos <= max_brinquedos, "Capacidade_Total"

    # objective function
    problema += lpSum(brinquedos[i][0] * x[i] for i in range(1, t + 1)) + \
                lpSum(pacotes[i][0] * y[i] for i in range(1, p + 1)), "Lucro_Total"

    problema.solve(GLPK(msg=0))

    return int(problema.objective.value())

######################################################################################
# INPUT
t, p, max_brinquedos = map(int, input().split())

brinquedos = {}
for i in range(1, t + 1):
    li, ci = map(int, input().split())
    brinquedos[i] = (li, ci, [])
 
pacotes = {}
for pac in range(1, p + 1):

    i, j, k, lucro = map(int, input().split())
    capacidade = min(brinquedos[i][1], brinquedos[j][1], brinquedos[k][1])

    pacotes[pac] = (lucro, capacidade)

    brinquedos[i][2].append(pac)
    brinquedos[j][2].append(pac)
    brinquedos[k][2].append(pac)

resultado = maximizar_lucro(t, p, max_brinquedos, brinquedos, pacotes)

end_time = time.time()

print(resultado)

print("time: ", (end_time - start_time))
