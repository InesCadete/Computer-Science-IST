#include <cstdio>
#include <vector>
#include <unordered_set>
#include <stack>
#include <iostream>

using namespace std;


// global variables
int numVertices;
int numEdges;
int sccCounter = 1;
int *sccArray;
vector<vector<int>> adjList, transposed, dag;
vector<bool> visited;

/*-------------------------------------------------------------------------*/
void addEdge(int v, int w) {
    adjList[v].push_back(w);
}

void dfs1(int i, stack<int>& mystack) {

    visited[i] = true;
    for(int j:adjList[i]) {
        if(visited[j] == false) 
            dfs1(j, mystack);
    
    }
    mystack.push(i);

}

// makes a transposed
void reverse() {
    for(int i = 1; i <= numVertices; i++) {
        for(int j: adjList[i]) {

            //printf("valor do j= %d\n", j);
            transposed[j].push_back(i);
        }
            
    }
    /* 
    puts("TRANSPOSED graph:");
     for(int i = 1; i <= numVertices; i++) {
        printf("%d ->", i);
        for(size_t j = 0; j < transposed[i].size(); j++) {
            printf("%d-", transposed[i][j]);
        }
        puts("\n");
    }
    */

}

//1,3,5    2,3  4  5  7,8
//0 0 0    1 1  2  3  4 4

void dfs2(int i) {

    //cout<<i<<" ";
    
    sccArray[i] = sccCounter;
    visited[i] = true;
    for(int j: transposed[i]) {
        if(visited[j] == false)
            dfs2(j);
    }
}

void transformToDAG() {

    // kosaraju algorithm (DFS(grafo) + DFS(grafo transposto))-> to find SCC's
    stack<int> mystack;

    for(int i = 1; i <= numVertices; i++) {
        if(!visited[i])
            dfs1(i, mystack);
    }

    reverse();
    // clear the visited array to reuse
    for(int i = 1; i <= numVertices; i++) {
        visited[i] = false;
    }
    while(!mystack.empty()) {
        int current = mystack.top();
        //printf("current1: %d\n", current);
        mystack.pop();
        if(visited[current] == false) {
            //printf("current2: %d\n",current );

            dfs2(current);

            sccCounter++;
            //cout<<"\n";
        }
        
    }

    //FALTA TRANSFORMAR CADA SCC num vertice
    //we find all the SCC’s ,
    //then iterate over all the edges of the graph and if both the vertex of any edge falls in the same SCC then ignore this edge else consider that edge .
    //The resulting graph will be DAG .

    dag.resize(sccCounter + 1);
    //printf("scc counter: %d\n", sccCounter);
    for(int i = 1; i < sccCounter; i++) {
          //puts("CHEGOU AQUI");
        //printf("valor do i: %d\n", i);
        for(size_t j = 0; j < adjList[i].size(); j++) {
            
            if(sccArray[i] != sccArray[adjList[i][j]]) {
                //puts("ENTROU NO IF");
                dag[i].push_back(adjList[i][j]);
               // printf("elemento added ao dag: %d | %d\n", i, dag[i][j]);
            }
            
        }
    }
    //puts("DAG: ");
    /* 
    for(int i = 1; i < sccCounter; i++) {
        printf("%d ->", i);
        for(size_t j = 0; j < dag[i].size(); j++) {
            printf("%d-", dag[i][j]);
        }
        puts("\n");
    }
    */
    //puts("chegou ao fim transformDAG!");

}
/*--------------------------------------------------------------------------------------*/
void dfs(int dp[], int vertex, bool visitedSCC[]) {
    
    visitedSCC[vertex] = true;
    size_t vectorSize = dag[vertex].size();
    for(size_t j = 0; j < vectorSize; j++) {
        int nei = dag[vertex][j];
        if(visitedSCC[nei] == false){
            //printf("nei %d faz call dfs\n", nei);
            dfs(dp, nei, visitedSCC);
        }

        dp[vertex] = max(dp[vertex], dp[nei] + 1);
        //printf("valor dp added: %d\n", dp[vertex]);
    }
}

int findLongestPath() {
    int dp[sccCounter + 1] = {0};
    //printf("isto deve ser um 0-> %d\n", dp[2]);
    bool visitedSCC[sccCounter + 1] = {false};

    // find the longest path for every unvisited vertex
    for(int vertex = 1; vertex < sccCounter; vertex++) {
            //printf("start vertex: %d\n", vertex);

        if(visitedSCC[vertex] == false) {
            //printf("counter: %d\n", counter++);
            dfs(dp, vertex, visitedSCC);
        }
        //puts("\n");
    }
    int longestPath = 0;

    for(int d: dp) {

        if(d > longestPath) {
            longestPath = d;
        }
    }

    return longestPath;
}

///////////////////////////////////////////////////////////////////////////////////

int main() {
    std::ios::sync_with_stdio(0);

    int numIndividuals, numRelations;

    if(scanf("%d %d", &numIndividuals, &numRelations)!= 2){
        fprintf(stderr, "erro no scanf\n");
    }

    numVertices = numIndividuals;
    numEdges = numRelations;

    adjList.resize(numVertices + 1);
    transposed.resize(numVertices + 1);
    visited.resize(numVertices + 1, false);

    sccArray = (int *)calloc(numVertices + 1, sizeof(int));

    visited = {false};

    // build the graph structure
    for (int i = 0; i < numRelations; ++i) {
        int individual1, individual2;
        
        if(scanf("%d %d", &individual1, &individual2)!=2) {
           fprintf(stderr, "erro no scanf\n");
        }
        addEdge(individual1, individual2);
    }
/* 
    for(int i = 1; i <= numVertices; i++) {
        printf("%d ->", i);
        for(size_t j = 0; j < adjList[i].size(); j++) {
            printf("%d-", adjList[i][j]);
        }
        puts("\n");
    }
*/
    // transform the graph into a DAG
    transformToDAG();

    printf("%d\n", findLongestPath());
    free(sccArray);

    return 0;
}
