#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/sem.h>

#define CACHE_SIZE 50
#define NUM_PROCESSES 4 // Количество дочерних процессов

static int cache[CACHE_SIZE] = {0};
int semid; // Дескриптор семафора

int fib(int n) {
    if (n <= 1) return n;

    // Захватить семафор
    struct sembuf sop = {0, -1, 0};
    semop(semid, &sop, 1);

    if (cache[n] == 0) {
        cache[n] = fib(n - 1) + fib(n - 2);
    }

    // Освободить семафор
    sop.sem_op = 1;
    semop(semid, &sop, 1);

    return cache[n];
}

int main() {
    int i, start, end;
    pid_t pid;

    // Создаем семафор
    semid = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
    if (semid == -1) {
        perror("semget");
        exit(1);
    }

    // Инициализируем семафор значением 1
    semctl(semid, 0, SETVAL, 1);

    // Создаем дочерние процессы
    for (i = 0; i < NUM_PROCESSES; i++) {
        pid = fork();
        if (pid < 0) {
            perror("fork");
            exit(1);
        } else if (pid == 0) {
            // Дочерний процесс
            start = i * (CACHE_SIZE / NUM_PROCESSES);
            end = (i + 1) * (CACHE_SIZE / NUM_PROCESSES);
            for (int j = start; j < end; j++) {
                fib(j);
            }
            exit(0);
        }
    }

    // Родительский процесс
    for (i = 0; i < NUM_PROCESSES; i++) {
        wait(NULL); // Ожидаем завершения дочерних процессов
    }

    // Выводим результаты
    for (i = 1; i < CACHE_SIZE; i++) {
        printf("%d\n", cache[i]);
    }

    // Удаляем семафор
    semctl(semid, 0, IPC_RMID);

    return 0;
}
