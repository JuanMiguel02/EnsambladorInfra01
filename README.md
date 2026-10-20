# Solución del primer parcial de Fundamentos de Infraestructura

Repositorio de apoyo y solución del primer parcial de ensamblador x86-64 con NASM, para el curso de Fundamentos de Infraestructura de Ingeniería de Sistemas y Computación.

## Solución general

La solución desarrolla, paso a paso, un programa de consola llamado **La Leyenda del Registro**. Cada clase agrega una capacidad y sirve como base para la siguiente:

1. **Clase 1 — El héroe habla:** muestra mensajes en la terminal mediante la llamada al sistema `write` y finaliza con `exit`.
2. **Clase 2 — El héroe escucha:** recibe el nombre escrito por el usuario con `read` y lo muestra en pantalla.
3. **Clase 3 — Los atributos del héroe:** lee y valida los valores de Fuerza (FUE) y Agilidad (AGI), calcula los puntos usados y la Vida (VID), determina el nivel del héroe y presenta los resultados.

Los programas están escritos para **Linux x86-64** en sintaxis NASM y usan llamadas al sistema directamente, sin libc. En conjunto, los ejercicios practican las secciones `.data`, `.bss` y `.text`, el uso de registros, entrada y salida, validación, operaciones aritméticas y saltos condicionales.

Cada clase se puede ensamblar y enlazar de forma independiente con el script `compilar.sh` de su carpeta. Se requiere un entorno Linux con NASM y `ld` instalados; por ejemplo, una VM de Ubuntu.

## Compilar una clase

Desde Linux, entra en la carpeta de la clase que quieras ejecutar y corre su script. Por ejemplo:

```bash
cd clase-01
bash compilar.sh
```

Repite el procedimiento desde `clase-02/` o `clase-03/` para las demás clases.


## Trabajo del examen

La carpeta `examen/` reúne las evidencias y respuestas de las partes práctica y teórica. También contiene las modificaciones realizadas sobre las clases: `clase02m.asm` personaliza el saludo y la despedida, mientras que `clase03m.asm` agrega un mensaje cuando la fuerza del héroe es cero y continúa con el flujo normal del programa. El archivo `heroe.asm` es un ejercicio independiente que solicita y muestra un nombre sin usar libc.

## Estructura del repositorio

```text
.
├── README.md                 # Descripción del repositorio y de la solución
├── examen.md                 # Enunciado del parcial
├── clase-01/
│   ├── clase01.asm           # Código fuente de la clase 1
│   ├── clase01.md            # Guía y explicación de la clase 1
│   ├── compilar.sh           # Ensambla, enlaza y ejecuta la clase 1
│   └── trace1.txt            # Traza de llamadas al sistema
├── clase-02/
│   ├── clase02.asm           # Código fuente de la clase 2
│   ├── clase02.md            # Guía y explicación de la clase 2
│   └── compilar.sh           # Ensambla, enlaza y ejecuta la clase 2
├── clase-03/
│   ├── clase03.asm           # Código fuente principal de la clase 3
│   ├── clase03m.asm          # Variante del código de la clase 3
│   ├── README.md             # Explicación de reglas y conceptos de la clase 3
│   ├── GUION.md              # Guion didáctico para presentar la clase 3
│   └── compilar.sh           # Ensambla y enlaza clase03.asm
└── examen/
    ├── entrega.md            # Respuestas, explicaciones, salidas y evidencias
    ├── trace1.txt            # Traza de syscalls de la clase 1
    ├── clase01.asm           # Código de la clase 1 usado en el examen
    ├── clase02m.asm          # Clase 2 con saludo y despedida personalizados
    ├── clase03m.asm          # Clase 3 con el mensaje adicional para FUE = 0
    ├── heroe.asm             # Programa independiente que lee e imprime un nombre
    ├── clase01, clase02m,
    │   clase03m, heroe       # Ejecutables generados
    └── clase01.o, clase02m.o,
        clase03m.o, heroe.o   # Archivos objeto generados por NASM
```

En `examen/entrega.md` se documentan la compilación y ejecución de las clases, las pruebas de entrada, las trazas con `strace`, las modificaciones solicitadas y las respuestas conceptuales. Los archivos objeto (`.o`) y ejecutables son productos de compilación y pueden regenerarse con NASM y `ld`.
