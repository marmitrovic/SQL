#include <stdio.h>

typedef struct {
    int  clientId;
    char firstName[50];
    char lastName[50];
    char phone[15];
} Client;

int main(void)
{
    Client clients[3] = {
        {1, "Carlos", "Gomez",  "611000101"},
        {2, "Javier", "Ruiz",   "611000102"},
        {3, "Miguel", "Torres", "611000103"}
    };

    // Otvaramo tekstualni fajl sa ekstenzijom .sql za pisanje ("w")
    FILE *sqlFile = fopen("c_generated_clients.sql", "w");
    if (!sqlFile)
        return 1;

    // 1. Upisujemo SQL komande za kreiranje baze i tabele
    fprintf(sqlFile, "DROP DATABASE IF EXISTS cTestDB;\n");
    fprintf(sqlFile, "CREATE DATABASE cTestDB;\n");
    fprintf(sqlFile, "USE cTestDB;\n\n");

    fprintf(sqlFile, "CREATE TABLE client (\n");
    fprintf(sqlFile, "    clientId INT PRIMARY KEY,\n");
    fprintf(sqlFile, "    firstName VARCHAR(50),\n");
    fprintf(sqlFile, "    lastName VARCHAR(50),\n");
    fprintf(sqlFile, "    phone VARCHAR(15)\n");
    fprintf(sqlFile, ");\n\n");

    // 2. Petljom prolazimo kroz C niz i generisemo INSERT komande za svakog klijenta
    for (int i = 0; i < 3; i++)
    {
        fprintf(sqlFile,
                "INSERT INTO client (clientId, firstName, lastName, phone) "
                "VALUES (%d, '%s', '%s', '%s');\n",
                clients[i].clientId,
                clients[i].firstName,
                clients[i].lastName,
                clients[i].phone);
    }

    // 3. Upisujemo i SELECT upit na kraj da odmah prikaze tabelu u MySQL-u
    fprintf(sqlFile, "\nSELECT * FROM client;\n");

    fclose(sqlFile);
    printf("Gotovo! Napravljen je fajl 'c_generated_clients.sql'.\n");
    return 0;
}