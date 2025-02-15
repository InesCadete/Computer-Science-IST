#include <iostream>
#include <map>
#include <vector>

using namespace std;

int paperCutting(int n, int m, int** paper_price);
int main(int argc, char const *argv[]) {

    int width;
    int length;
    int num_p;

    scanf("%d %d \n%d", &width, &length, &num_p);
    int **prices_p = (int**)malloc(sizeof(int*) * (width+1));
    for (int i = 0; i <= width; i++) {
        prices_p[i] = (int*)malloc((length+1) *sizeof(int));
    }

    for (int x = 0; x <= width; x++) {
        for (int y = 0; y <= length; y++ ) {
            prices_p[x][y] = 0;
        }
    }

    for (int i = 0; i < num_p; i++) {
        int w;
        int l;
        int p;

        scanf("%d %d %d", &w, &l, &p);

        if (!(w <= width && l <= length && w >=1 && l >= 1))
            continue;
        
        prices_p[w][l] = p;
        
        if (l <= width && w<= length) {
            prices_p[l][w] = p;
        } 
        
    }

/*    
    for (int i = 0; i <= width; i++) {
        for (int j = 0; j <= length; j++) {
            printf("%d ", prices_p[i][j]);
        }
        puts("\n");
    }
*/


    int result = paperCutting(width, length, prices_p);
    printf("%d\n", result);

    for (int i = 0; i <= width; i++) {
        free(prices_p[i]);
    }
    free(prices_p);

    return 0;
}


int paperCutting(int n, int m, int** paper_price) {
    int **table = (int **)malloc(sizeof(int*)*(n+1));
    for (int i = 0; i <= n; i++) {
        table[i] = (int*)malloc(sizeof(int)*(m+1));
    }

    for (int x = 0; x <= n; x++) {
        for (int y = 0; y <= m; y++) {
            table[x][y] = 0;
        }
    }

    int max = 0;

    for (int width = 1; width <= n; width++) {
        for (int length = 1; length <= m; length++) {
            for (int i = 1; i <= length; i++) {
                int tmp = paper_price[width][i] + table[width][length-i];
                if (tmp > table[width][length]) {
                    max = tmp;
                }
                table[width][length] = max; 
            }

            for (int j = 1; j <= width; j++) {
                int tmp = paper_price[j][length] + table[width-j][length];
                if (tmp > table[width][length]) {
                    max = tmp;
                }
                table[width][length] = max;
            }    
        }
    }
        /*
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                printf("%d ", table[i][j]);
            }

            puts("\n");
        } */

    int result = table[n][m];
    for(int i = 0 ; i <= n; i++)
        free(table[i]);
    free(table);
    return result;
}


