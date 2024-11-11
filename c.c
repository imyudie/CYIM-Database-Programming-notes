#include <stdio.h>

int main(int argc, char *argv[])
{   
    char name[20] = "Jerry";
    for(int i = 1; i < 5; i++){
        printf("%d : Hello, World! my name is %s <here>\n", i,name);
    }
    
    return 0;
}