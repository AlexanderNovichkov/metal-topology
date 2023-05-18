# Metal Topology
Данная программа позволяет вычислять персистентные гомологии на GPU, используя Metal.
Можно подключить ее в виде фреймворка в проект. Также можно использовать консольное приложение, которое расположено по пути cmd/compute.

## Классы
- SparseMatrix - класс для хранения матрицы в разреженном формате.
- PhComputation  - класс для вычиления персистентных гомологий. Метод Compute редуцирует матрицу и возвращает результат. Метод getPersistentPairs позволяет получить устойчивые пары, его можно вызывать только после вызова метода Compute.
- PersistencePairs - класс для работы с  устойчивыми парами. Можно читать из файла и записывать в файл.


## Консольное приложение compute
Читает матрицу из файла, находит устойчивые пары и записывает их в файл.

Аргументы:
- Путь к файлу с матрицей, для которой требуется вычислить устойчивые пары.
- Путь к файлу, в который будут записаны посчитанные устойчивые пары.
- Индекс GPU, который будет использоватсья при вычислениях. Опциональный аргумент, по умолчанию равен 0.
