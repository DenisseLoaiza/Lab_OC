#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void set_bit(unsigned char *value, unsigned char bit);
extern unsigned char get_bit(unsigned char value, unsigned char bit);

void update_temp(int *temps);
void update_flags(int *temps, int *last_temps, unsigned char *flags);
void mostrar_sensor(int temp, unsigned char flags, int sensor);

int main()
{
    unsigned char banderas[2] = {1, 1};
    int ultima_lectura[2] = {25, 25};
    int tem_sensores[2] = {25, 25};
    int opcion;

    srand(time(NULL));

    do
    {
        mostrar_sensor(tem_sensores[0], banderas[0], 1);
        mostrar_sensor(tem_sensores[1], banderas[1], 2);

        printf("\n[1] Actualizar\n");
        printf("[2] Salir\n");
        printf("\nSeleccionar opcion: ");

        if (scanf("%d", &opcion) != 1)
            return 1;

        switch(opcion)
        {
            case 1:
                update_temp(tem_sensores);
                update_flags(tem_sensores, ultima_lectura, banderas);
                break;

            case 2:
                printf("Fin del programa\n");
                break;

            default:
                printf("Opcion incorrecta\n");
        }

        printf("\n");

    } while(opcion != 2);

    return 0;
}

// Actualizar temperatura de los sensores
void update_temp(int *temps)
{
    int i;

    for(i = 0; i < 2; i++)
    {
        temps[i] += rand() % 11 - 5;
    }
}

// Actualizar las banderas de cada sensor
void update_flags(int *temps, int *last_temps, unsigned char *flags)
{
    int i, diferencia;

    for(i = 0; i < 2; i++)
    {
        flags[i] = 0;
        diferencia = temps[i] - last_temps[i];

        if(diferencia > 0)
            set_bit(&flags[i], 5);

        else if(diferencia < 0)
            set_bit(&flags[i], 4);

        diferencia = abs(diferencia);

        if(diferencia > 2)
            set_bit(&flags[i], 3);

        else if(diferencia == 2)
            set_bit(&flags[i], 2);

        else if(diferencia == 1)
            set_bit(&flags[i], 1);

        else
            set_bit(&flags[i], 0);

        last_temps[i] = temps[i];
    }
}

// Mostrar temperatura y cambio del sensor
void mostrar_sensor(int temp, unsigned char flags, int sensor)
{
    printf("SENSOR %d: ~ %d °C ", sensor, temp);

    if(get_bit(flags, 0))
        printf("-");

    else if(get_bit(flags, 5))
    {
        if(get_bit(flags, 3))
            printf(">>>");

        else if(get_bit(flags, 2))
            printf(">>");

        else if(get_bit(flags, 1))
            printf(">");
    }

    else if(get_bit(flags, 4))
    {
        if(get_bit(flags, 3))
            printf("<<<");

        else if(get_bit(flags, 2))
            printf("<<");

        else if(get_bit(flags, 1))
            printf("<");
    }

    printf("\n");
}

