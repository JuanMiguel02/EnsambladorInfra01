# Solución del primer parcial de Fundamentos de Infraestructura

Repositorio de apoyo y solución del primer parcial de ensamblador x86-64 con NASM, para el curso de Fundamentos de Infraestructura de Ingeniería de Sistemas y Computación.

## Solución general

La solución desarrolla, paso a paso, un programa de consola llamado **La Leyenda del Registro**. Cada clase agrega una capacidad y sirve como base para la siguiente:

1. **Clase 1 — El héroe habla:** muestra mensajes en la terminal mediante la llamada al sistema `write` y finaliza con `exit`.
2. **Clase 2 — El héroe escucha:** recibe el nombre escrito por el usuario con `read` y lo muestra en pantalla.
3. **Clase 3 — Los atributos del héroe:** lee y valida los valores de Fuerza (FUE) y Agilidad (AGI), calcula los puntos usados y la Vida (VID), determina el nivel del héroe y presenta los resultados.

Los programas están escritos para **Linux x86-64** en sintaxis NASM y usan llamadas al sistema directamente, sin libc. En conjunto, los ejercicios practican las secciones `.data`, `.bss` y `.text`, el uso de registros, entrada y salida, validación, operaciones aritméticas y saltos condicionales.

Cada clase se puede ensamblar y enlazar de forma independiente con el script `compilar.sh` de su carpeta. Se requiere un entorno Linux con NASM y `ld` instalados; por ejemplo, una VM de Ubuntu.

## Estructura del repositorio

```text
.
├── README.md                 # Descripción del repositorio y de la solución
├── heroe.asm                 # Ejemplo independiente: solicita y muestra un nombre
├── examen.md                 # Enunciado y respuestas del examen
├── entrega.md                # Evidencias y respuestas de la entrega actual
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
└── examen/                   # Carpeta prevista para organizar la entrega del parcial
    ├── entrega.md            # Evidencias, salidas y respuestas de la entrega
    ├── clase-01/             # Clases copiadas con las modificaciones del examen
    ├── clase-02/
    └── clase-03/
```

Los archivos objeto (`.o`) y ejecutables que aparecen en las carpetas de clase son productos de compilación; pueden regenerarse con los scripts correspondientes. La carpeta `examen/` se usará para reunir `entrega.md` y las clases modificadas para el parcial.

## Compilar una clase

Desde Linux, entra en la carpeta de la clase que quieras ejecutar y corre su script. Por ejemplo:

```bash
cd clase-01
bash compilar.sh
```

Repite el procedimiento desde `clase-02/` o `clase-03/` para las demás clases.
# Fundamentos de Infraestructura - Ensamblador

Curso de ensamblador x86-64 (NASM) para "Fundamentos de Infraestructura",
Ingenieria de Sistemas.

Cada clase es una carpeta con:

- **`clase-XX.asm`** - el codigo ensamblado (sin libc, syscalls crudos).
- **`compilar.sh`** - compila y ejecuta la clase.
- **`claseXX.md`** - la explicacion pedagogica de la clase.

Las clases:

- **`clase-01/`** - "El heroe habla" - el heroe imprime su nombre con `write` (syscall 1) y se despide con `exit` (syscall 60).
- **`clase-02/`** - "El heroe escucha" - el heroe aprende `read` (syscall 0) y valida entradas del usuario.
- **`clase-03/`** - "Los atributos del heroe" - el heroe valida FUE/AGI, calcula Vida y Nivel con `add`/`sub`/`inc`, decide ELITE vs NOVATO con `cmp`/`jge` e imprime numeros.

Cada carpeta es independiente. Compila la clase 1 primero, luego la clase 2, y asi sucesivamente.
