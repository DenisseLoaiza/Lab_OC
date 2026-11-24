#include <stdio.h>

extern int maximo(int *arr, int len);
extern int minimo(int *arr, int len);
extern int sumatoria(int *arr, int len);

int main()
{
    int arr[5];
    int len, i;

    // Capturar cantidad de elementos
    do
    {
        printf("Cantidad de elementos (1-5): ");
        if (scanf("%d", &len) != 1)
            return 1;

    } while (len < 1 || len > 5);

    // Capturar numeros
    for (i = 0; i < len; i++)
    {
        printf("Elemento %d: ", i + 1);
        if (scanf("%d", &arr[i]) != 1)
            return 1;
    }

    // Mostrar arreglo
    printf("\nElementos del arreglo:\n");

    for (i = 0; i < len; i++)
    {
        printf("%d ", arr[i]);
    }

    // Llamadas a funciones de ensamblador
    printf("\n\nMaximo: %d", maximo(arr, len));
    printf("\nMinimo: %d", minimo(arr, len));
    printf("\nSumatoria: %d\n", sumatoria(arr, len));

    return 0;
}
