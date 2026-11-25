#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 1. Structure representing one row in our table (119 bytes per client)
typedef struct {
    int  clientId;
    char firstName[50];
    char lastName[50];
    char phone[15];
} Client;

int main(void)
{
    // 2. Create 3 clients in RAM
    Client clients[3] = {
        {1, "Carlos", "Gomez",  "611000101"},
        {2, "Javier", "Ruiz",   "611000102"},
        {3, "Miguel", "Torres", "611000103"}
    };

    // 3. Write raw bytes from RAM to a binary file "clients.db" on disk
    FILE *base = fopen("clients.db", "wb"); // b je za binarno pisanje
    if (!base)
        return 1;
    fwrite(clients, sizeof(Client), 3, base);
    fclose(base);

    // 4. Read raw bytes back from "clients.db" into a new array in RAM
    Client loadedClients[3];
    base = fopen("clients.db", "rb");
    if (!base)
        return 1;
    fread(loadedClients, sizeof(Client), 3, base);
    fclose(base);

    // 5. Display the loaded records in the terminal
    printf("ID | First Name | Last Name | Phone\n");
    printf("---------------------------------------\n");
    for (int i = 0; i < 3; i++)
    {
        printf("%d  | %-10s | %-9s | %s\n",
               loadedClients[i].clientId,
               loadedClients[i].firstName,
               loadedClients[i].lastName,
               loadedClients[i].phone);
    }
    return 0;
}