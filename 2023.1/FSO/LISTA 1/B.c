#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

int main(int argc, char **argv){
    void *openfile;
    
    openfile = dlopen(argv[1], RTLD_NOW);

    if(openfile == NULL){
        printf("nao disponivel\n");
        return 0;
    }

    int (*imprime)(void);
    imprime = dlsym(openfile, "imprime");

    if(dlerror() != NULL)
        printf("nao implementado\n");

    else {
        int rst = (*imprime)();
        printf("%d\n", rst);
    }

    int (*calcula)(int, int);
    calcula = dlsym(openfile, "calcula");

    if(dlerror() != NULL)
        printf("nao implementado\n");

    else {
        int rst = (*calcula)(atoi(argv[2]), atoi(argv[3]));
        printf("%d\n", rst);
    }

    int (*trigo)(double, double*);
    trigo = dlsym(openfile, "trigo");

    if(dlerror() != NULL)
        printf("nao implementado\n");

    else {
        int rst = (*trigo)(atof(argv[4]), NULL);
        printf("%d\n", rst);
    }

    dlclose(openfile);

    return 0;

}