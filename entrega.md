# Examen — La Leyenda del Registro

**Asignatura:** Fundamentos de Infraestructura
**Unidad:** Ensamblador x86-64 (NASM) — Clases 1, 2 y 3
**Duración:** 90 minutos
**Modalidad:** individual, en la VM de Ubuntu con NASM instalado
**Material permitido:** las carpetas `clase-01/`, `clase-02/`, `clase-03/` y la documentación de syscalls de Linux. **No** se permite internet, IA generativa ni copiar entre estudiantes.

---

## Instrucciones generales

1. Trabaja dentro de tu propia carpeta de examen. Copia las tres clases a `examen/clase-01`, `examen/clase-02`, `examen/clase-03`.
2. **Cada entrega es un archivo.** Donde se pide "muestra", pega la salida real entre bloques de código. No inventes salidas: el profesor puede re-ejecutar tu binario.
3. **Parte práctica:** los artefactos (salidas, `strace`, código modificado, binarios) van en `examen/entrega.md` (creas tú este archivo).
4. **Preguntas conceptuales** (tanto de la Parte A como de la B) se responden directamente en este documento, dentro de los bloques `[RESOLVER AQUÍ]`.
5. Al final, entrega: tu carpeta `examen/` con los `.asm`, los binarios, `entrega.md` y este `examen.md` con las respuestas.

**Criterio de aprobación:** ≥ 70% de la nota total. Cada sección indica su puntaje.

---

# PARTE A — PRÁCTICA: seguir y ejecutar las clases (60 pts)

> Regla de oro: si algo no compila, no pasa a la siguiente. **No se acepta "no compiló" como respuesta.**
> Documenta el error completo y el intento de solución.

---

## A.1 — El despertar (Clase 1) — 10 pts

### A.1.1 (4 pts)
Compila y ejecuta la clase 1. Documenta en `entrega.md`:

- El comando exacto de compilación y el de enlazado.
- La salida completa del programa.
- El código de salida (`echo $?`).

### A.1.2 (6 pts)
Ejecuta `strace -e trace=write,exit_group ./clase01 2> trace1.txt` y responde (pega también el
`strace` en `entrega.md`):

1. ¿Cuántas llamadas `write` hay en total?
2. ¿Cuál es el código de salida que devuelve `exit_group`?
3. ¿Qué número de syscall usa `write`? (pista: mira la columna `syscall` o el `strace` completo).

[RESOLVER AQUÍ: A.1 — El despertar (Clase 1)

## A.1.1. Compilación, enlazado y ejecucion



### 1. Comando de compilación o ensamblado

Desde el directorio `clase-01`, se ejecutó el siguiente comando:

```bash
nasm -f elf64 clase01.asm -o clase01.o
```

**Explicación:**

- `nasm`: ejecuta el ensamblador NASM.
- `-f elf64`: indica que el archivo objeto debe utilizar el formato ELF de 64 bits.
- `clase01.asm`: es el archivo que contiene el código fuente en ensamblador.
- `-o clase01.o`: establece el nombre del archivo objeto generado.

La operación finalizó sin mostrar errores. Posteriormente, se verificó la existencia del archivo objeto:

```bash
ls -l clase01.o
```

Resultado obtenido:

```text
-rw-rw-r-- 1 ubuntu ubuntu 1248 Oct 14 21:16 clase01.o
```

Esto confirma que se generó el archivo `clase01.o`, con un tamaño de 1248 bytes.

### 2. Comando de enlazado

Después del ensamblado, se ejecutó:

```bash
ld clase01.o -o clase01
```

**Explicación:**

- `ld`: ejecuta el enlazador.
- `clase01.o`: es el archivo objeto que se va a enlazar.
- `-o clase01`: indica que el ejecutable resultante se llamará `clase01`.

El comando terminó sin mostrar errores. Para comprobar la generación del ejecutable, se utilizó:

```bash
ls -l clase01
```

Resultado obtenido:

```text
-rwxrwxr-x 1 ubuntu ubuntu 9112 Oct 14 21:17 clase01
```

El archivo se generó correctamente y cuenta con permisos de ejecución.

### 3. Ejecución del programa

Para ejecutar el programa se utilizó:

```bash
./clase01
```

**Salida completa obtenida:**

```text
LA LEYENDA DEL REGISTRO v0.1
Bienvenido, heroe. Tu aventura empieza aqui.
El sistema operativo te despidio con elegancia (código 0).
```

**Análisis de la salida:**

El programa muestra tres mensajes consecutivos: el título de la aventura, el mensaje de bienvenida y la despedida. Estos textos están almacenados en la sección `.data` del código fuente y se imprimen mediante llamadas al sistema `write`.

### 4. Verificación del código de salida

Inmediatamente después de ejecutar el programa, se ejecutó:

```bash
echo $?
```

Resultado obtenido:

```text
0
```

**Explicación:**

En Bash, `$?` contiene el código de salida del último comando ejecutado. El valor `0` indica que el programa terminó correctamente. Este resultado coincide con el código `0` que el programa establece en el registro `RDI` antes de ejecutar la llamada al sistema de terminación.

Por lo tanto, se confirma que el ensamblado, el enlazado y la ejecución del programa fueron exitosos.

---

## A.1.2. Análisis de llamadas al sistema con `strace`

### 1. Comando ejecutado

Se ejecutó el siguiente comando, indicado en el enunciado:

```bash
strace -e trace=write,exit_group ./clase01 2> trace1.txt
```

**Explicación:**

- `strace`: permite observar las llamadas al sistema realizadas por un proceso.
- `-e trace=write,exit_group`: limita el seguimiento a las llamadas `write` y `exit_group`.
- `./clase01`: ejecuta el programa que se va a analizar.
- `2> trace1.txt`: redirige la salida de error estándar, donde `strace` escribe el seguimiento, al archivo `trace1.txt`.

Los mensajes del programa continuaron apareciendo en la terminal, mientras que el seguimiento de las llamadas al sistema quedó almacenado en el archivo indicado.

### 2. Salida obtenida en `trace1.txt`

Para consultar el archivo se ejecutó:

```bash
cat trace1.txt
```

Salida obtenida:

```text
write(1, "LA LEYENDA DEL REGISTRO v0.1\n", 29) = 29
write(1, "Bienvenido, heroe. Tu aventura e"..., 45) = 45
write(1, "El sistema operativo te despidio"..., 60) = 60
+++ exited with 0 +++
```

La versión de `strace` utilizada abrevia parte de los mensajes largos mediante puntos suspensivos. Sin embargo, conserva la información necesaria para identificar las llamadas y comprobar cuántos bytes se escribieron.

### 3. Respuestas a las preguntas

**Pregunta 1. ¿Cuántas llamadas `write` hay en total?**

Hay **3 llamadas `write`**. Cada una corresponde a la impresión de uno de los tres mensajes del programa: el título, la bienvenida y la despedida.

En las tres llamadas se utiliza el descriptor de archivo `1`, que corresponde a la salida estándar (`stdout`).

**Pregunta 2. ¿Cuál es el código de salida que devuelve `exit_group`?**

El código de salida es **0**.

En el archivo de seguimiento aparece:

```text
+++ exited with 0 +++
```

Esta línea indica que el proceso terminó con código de salida `0`. Aunque esta versión de `strace` no muestra explícitamente `exit_group(0) = 0`, el resultado confirma la terminación exitosa del programa.

**Pregunta 3. ¿Qué número de syscall utiliza `write`?**

El número de syscall de `write` es **1** en Linux x86-64.

Esto se comprueba en el código fuente `clase01.asm`, donde se carga el valor `1` en el registro `RAX` antes de cada llamada `syscall` destinada a escribir un mensaje:

```asm
mov rax, 1
mov rdi, 1
mov rsi, titulo
mov rdx, len_titulo
syscall
```

En este fragmento, `RAX` contiene el número de la llamada al sistema; `RDI` indica el descriptor de salida; `RSI` contiene la dirección del texto y `RDX` indica la cantidad de bytes que se deben escribir. ]

---

## A.2 — El nombre del héroe (Clase 2) — 15 pts

### A.2.1 (5 pts)
Compila y ejecuta la clase 2 con **tres** nombres distintos:

1. Un nombre corto (≤ 5 letras).
2. Un nombre de **exactamente 31** letras.
3. Un nombre de **40** letras.

Documenta la salida de cada caso en `entrega.md`.

[RESOLVER AQUÍ: ¿Qué ocurre en el caso 3? Explica por qué, citando qué línea del `.asm` lo provoca.]

### A.2.2 (5 pts)
Ejecuta `strace -e trace=read,write ./clase02` con un nombre de 10 letras (pega el `strace` en `entrega.md`) y responde:

1. ¿Cuántos bytes devuelve la llamada `read`?
2. ¿Por qué ese número y no 32 (el tamaño del buffer)?
3. ¿En qué variable del código se guarda ese valor de retorno?

[RESOLVER AQUÍ: ]

### A.2.3 (5 pts) — Modificación obligatoria
En tu copia de `clase02.asm`, cambia **dos** cosas y haz que siga compilando y ejecutando:

1. Cambia el saludo (`saludo`) a una frase tuya (debe incluir "reino" o "heroe").
2. Cambia la despedida (`despedida`) a una frase tuya.

Pega en `entrega.md` el bloque `.data` modificado y la salida de tu programa con el nombre `Gandalf`.

---

## A.3 — Los atributos del héroe (Clase 3) — 20 pts

### A.3.1 (8 pts)
Compila la clase 3 y ejecútala con las **cinco** combinaciones de (FUE, AGI) de la tabla. Completa la tabla con la salida real (ELITE / NOVATO / ERROR) y el código de salida:

| Caso | FUE | AGI | ¿ELITE o NOVATO o ERROR? | Código salida (`$?`) |
|------|-----|-----|--------------------------|----------------------|
| 1    | 3   | 5   |          Elite           |            0         |
| 2    | 0   | 9   |          Elite           |            0         |
| 3    | 9   | 9   |          Error           |            1         |
| 4    | 0   | 0   |          Novato          |            0         |
| 5    | `x` | 5   |          Novato          |            0         |

> Caso 5: en lugar de un dígito, escribe la letra `x`.

[RESOLVER AQUÍ: ¿Qué hace el programa con la letra `x`? ¿Por qué no se rompe?]

Si se analiza el código de la clase03.asm, podemos observar que el siguiente fragmento de código
se encarga de validar el registro de **FUEGO**:

```nasm
   ; ---------- Accion 4: LEER y validar FUE (0 a 9) ----------
   ; Si no es un digito, FUE queda en 0 (el heroe no se rompe).
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 2
    syscall
    cmp rax, 0
    je .fue_vacio
    cmp byte [buf], 48
    jb .fue_vacio
    cmp byte [buf], 57
    ja .fue_vacio
    mov al, byte [buf]
    sub al, 48
    mov [v_fue], al
    jmp .fue_leido
.fue_vacio:
    mov byte [v_fue], 0
.fue_leido:
```

### ¿Cómo funciona?
Estas instrucciones controlan el flujo de ejecución del programa. En lugar de ejecutar el código línea por línea en orden secuencial, permiten saltar a distintas etiquetas del código. En este caso, se usan después de una instrucción de comparación **(cmp)**, básicamente funcionan como las estructuras if, else y else if de los lenguajes de alto nivel.

El próposito de cada instrucción se muestra en la siguiente tabla:

| Instrucción | Significado     | Condición en cmp A, B       | 
|------       |-----            |-----                        |
| cmp A, B    | Compara A con B | Configura las banderas      | 
| je etiqueta | Jump if Equal   | A == B                      | 
| ja etiqueta | Jump if Above   | A > B                       |
| jb etiqueta | Jump ifBelow    | A < B                       |
| jmp etiqueta| Jump            | Salto directo sin condición |

**Nota:** En ensamblador no existe el concepto de tiós de datos. El procesador solo maneja números binarios y bytes almacenados en memoria o registros. Cuando se lee una entrada desde la terminal, el kernel guarda el código ASCII del carácter que se presionó.

Teniendo esto en cuenta, lo que pasa al escribir la letra `x` es lo siguiente:

1. Se lee la entrada del usuario **(sys_read)**, en este caso se guarda en la variable reservada **buf** que guarda 2 bytes. **buf[0]** guarda el cáracter `x` (cuyo código ASCII es 120), **buf[1]** guarda el salto de línea \n y **rax** recibe 2 (el número de bytes leídos)
2. Se evalua la llamada **cmp rax, 0**, la cual compara si se leyeron 0 bytes, pero como **rax** vale 2, no es igual a 0. No salta en **je .fue_vacio**
3. Se evalua el límite inferior **cmp byte [buf], 48**. Compara el primer byte de **buf** (120) con 48 (ASCII DE '0'). Como 120 no es menor que 49, la condición **jb. fue_vacio** es falsa y el programa no salta aquí.
4. Se evalua el límite superior **cmp byte [buf], 57**. Compara el primer byte de **buf** (120) con 57 (ASCII de '9'). Como 120 sí es mayor que 57, la condición **ja** es verdadera, por lo tanto el programa salta a **.fue_vacio**
5. Al saltar a **.fue_vacio**, se ejecuta **mov byte [v_fue], 0**. Esta línea le asigna por defecto el valor de 0 a la variable que guarda el valor de fuego ingresado, en consecuancia, cualquier carácter no numérico fuera del rango ASCII 48 - 57 resulta en **v_fue = 0**

Gracias a este uso de condicionales, el programa no falla en caso de que el usuario ingrese un valor no númerico o que se encuentre fuera del rango establecido.


### A.3.2 (6 pts)
Con `strace -e trace=write,read,exit_group ./clase03`, usando FUE=8, AGI=2 (pega el `strace` en `entrega.md`), responde:

1. ¿Cuántas llamadas `write` hay? Enuméralas (qué texto escribe cada una).
2. ¿Cuántas llamadas `read` hay?
3. ¿Por qué `read` devuelve siempre `2` y no `1`?

[RESOLVER AQUÍ: ]

### Salida del comando strace 

```nasm
strace -e trace=write,read,exit_group ./clase03

write(1, "LA LEYENDA DEL REGISTRO v0.3\n", 29LA LEYENDA DEL REGISTRO v0.3
) = 29
write(1, "Tienes 9 puntos para repartir. E"..., 62Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
) = 62
write(1, "FUE (fuerza, 0 a 9): ", 21FUE (fuerza, 0 a 9): )   = 21
read(08
, "8\n", 2)                       = 2
write(1, "AGI (agilidad, 0 a 9): ", 23AGI (agilidad, 0 a 9): ) = 23
read(02
, "2\n", 2)                       = 2
write(1, "Error: no te alcanzan los 9 punt"..., 36Error: no te alcanzan los 9 puntos.
) = 36
+++ exited with 1 +++
```
1. Se realizan **5** llamadas `write` en el programa
    * Llamada 1: **write(1, "LA LEYENDA DEL REGISTRO v0.3\n", 29) escr**ibe en pantalla el texto `"LA LEYENDA DEL REGISTRO v0.3"`
    * LLamada 2: **write(1, "Tienes 9 puntos para repartir. E"..., 62)** escribe en pantalla el texto `"Tienes 9 puntos para repartir. El resto se vuelve vida (VID)."`
    * Llamada 3: **write(1, "FUE (fuerza, 0 a 9): ", 21)** escribe en pantalla el texto `"FUE (fuerza, 0 a 9):"`
    * LLamada 4: **write(1, "AGI (agilidad, 0 a 9): ", 23)** escribe en pantalla el texto `"AGI (agilidad, 0 a 9):"`
    * LLamada 5. **write(1, "Error: no te alcanzan los 9 punt"..., 36)** escribe eb pantalla el texto de error, ya que que sobrepasamos el límite de puntos permitidos: `"Error: no te alcanzan los 9 puntos."`


2. Se realizan **2** llamadas `read` en el programa, encargadas de leer los valores de Fuego y Agilidad
3. La razón por la que `read` devuelve **2** es porque cuando se presiona una tecla y luego Enter, la terminal le envía al programa dos caracteres consecutivos:
    * El carácter que se escribió, por ejemplo 8
    * La tecla Enter envía el salto de línea

    Entonces el valor que devuelve `read` indica la cantidad de bytes leídos, en este caso es **2**


### A.3.3 (6 pts) — Modificación obligatoria
Implementa el **Ejercicio 1** de la clase 3 ("El heroe se enfada"): si FUE es 0, muestra la frase
`"Un heroe sin fuerza no es heroe."` y sigue el flujo normal.

Requisitos:

- Usa `cmp byte [v_fue], 0` y un salto `je` a un bloque nuevo `.sin_fuerza`.
- El programa debe seguir imprimiendo el bloque de atributos y terminar con código 0.
- Pega en `entrega.md` las líneas que agregaste y la salida completa con FUE=0, AGI=3.

### Modificaciones

```nasm
    ;en section.data
 sin_fuerza db "Un heroe sin fuerza no es heroe", 10 ;mensaje nuevo
 len_sin_fuerza equ $ - sin_fuerza ;longitud de bytes

  ; ---------- Accion 4: LEER y validar FUE (0 a 9) ----------
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 2
    syscall
    cmp rax, 0
    je .fue_vacio
    cmp byte [buf], 48
    jb .fue_vacio
    cmp byte [buf], 57
    ja .fue_vacio
    mov al, byte [buf]
    sub al, 48
    mov [v_fue], al
    jmp .fue_leido
.fue_vacio:
    mov byte [v_fue], 0
.fue_leido:
    ;bloque de instrucciones nuevo
    cmp byte [v_fue], 0
    je .sin_fuerza
.sin_fuerza:
    mov rax, 1
    mov rdi, 1
    mov rsi, sin_fuerza
    mov rdx, len_sin_fuerza
    syscall
```
### Salida del programa
```nasm
LA LEYENDA DEL REGISTRO v0.3
Tienes 9 puntos para repartir. El resto se vuelve vida (VID).
FUE (fuerza, 0 a 9): 0
Un heroe sin fuerza no es heroe
AGI (agilidad, 0 a 9): 3
El heroe sigue siendo NOVATO: hay margen para crecer.
FUE: 0
AGI: 3
VID: 6
Puntos gastados: 3
Nivel: 1
Los atributos quedaron grabados en los registros del heroe.
```
**Código de salida: 0**

---

## A.4 — Crear desde cero (15 pts)

Escribe un programa **nuevo** (`examen/heroe.asm`) **sin usar libc** que:

1. Imprima `"Nombre: "` (sin salto de línea).
2. Lea el nombre desde el teclado (buffer de 16 bytes en `.bss`).
3. Imprima el nombre.
4. Imprima un salto de línea.
5. Termine con código de salida 0.

Compílalo con `nasm -f elf64` y `ld`. Pega en `entrega.md` el código completo y la salida al ejecutarlo con el nombre `Sauron`.

> No copies la clase 2: el programa debe ser más corto (solo 4 `write`/`read` + `exit`).
[RESOLVER AQUÍ: ## A.4 — Crear un programa desde cero.

### 1. Código fuente: `heroe.asm`

```nasm
default rel

section .data
    mensaje db "Nombre: "
    len_mensaje equ $ - mensaje
    salto db 10

section .bss
    nombre resb 16

section .text
    global _start

_start:
    ; 1. Mostrar "Nombre: "
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel mensaje]
    mov rdx, len_mensaje
    syscall

    ; 2. Leer hasta 16 bytes del teclado
    mov rax, 0
    mov rdi, 0
    lea rsi, [rel nombre]
    mov rdx, 16
    syscall

    ; Quitar el salto de linea que introduce Enter
    test rax, rax
    jle .sin_nombre
    cmp byte [rsi + rax - 1], 10
    jne .longitud_lista
    dec rax

.longitud_lista:
    mov rdx, rax
    jmp .mostrar_nombre

.sin_nombre:
    xor edx, edx

.mostrar_nombre:
    ; 3. Imprimir el nombre leido
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel nombre]
    syscall

    ; 4. Imprimir un salto de linea
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel salto]
    mov rdx, 1
    syscall

    ; 5. Terminar con codigo de salida 0
    mov rax, 60
    mov rdi, 0
    syscall
```

### 2. Compilación y enlazado

Desde el directorio raíz del repositorio se ejecutaron los siguientes comandos:

```bash
nasm -f elf64 heroe.asm -o heroe.o
ld heroe.o -o heroe
```

El primer comando ensambla el código fuente y genera el archivo objeto `heroe.o`. El segundo enlaza el archivo objeto para producir el ejecutable `heroe`.

La comprobación de los archivos generados fue:

```text
-rwxrwxr-x 1 ubuntu ubuntu 9128 Oct 16 21:18 heroe
-rw-rw-r-- 1 ubuntu ubuntu  769 Oct 16 21:18 heroe.asm
-rw-rw-r-- 1 ubuntu ubuntu 1328 Oct 16 21:18 heroe.o
```

La compilación y el enlazado finalizaron sin mostrar errores.

### 3. Ejecución y resultado

Se ejecutó el programa con:

```bash
./heroe
```

Se introdujo `Sauron` por teclado y se pulsó Enter. El resultado observado fue:

```text
Nombre: Sauron
Sauron
```

La primera línea incluye el mensaje `Nombre: ` y el nombre que el terminal muestra al escribirlo. La segunda línea corresponde al nombre que imprime el propio programa.

### 4. Verificación del código de salida

Después de la ejecución se utilizó:

```bash
echo $?
```

Resultado:

```text
0
```

El resultado confirma que el programa terminó con código de salida `0`.

### 5. Explicación del funcionamiento

- **Sección `.data`:** contiene el mensaje `Nombre: ` y el carácter de salto de línea, representado por el byte `10`.
- **Sección `.bss`:** reserva 16 bytes para almacenar el nombre mediante `resb 16`.
- **Llamada `write`:** utiliza el número de sistema `1` para mostrar información en la salida estándar.
- **Llamada `read`:** utiliza el número `0` para leer la entrada estándar y guardar los bytes en el buffer.
- **Tratamiento del salto de línea:** se comprueba si el último byte leído es `10`. Si corresponde al Enter, se reduce la longitud para no imprimir ese carácter como parte del nombre.
- **Finalización:** la llamada al sistema `exit`, identificada por el número `60`, termina el programa con código `0`.
]
---

# PARTE B — TEORÍA: preguntas (40 pts)

> Responde dentro de los bloques `[RESOLVER AQUÍ]`.
> Se valora **explicar con tus palabras**, no solo la respuesta correcta.

---

## B.1 — Selección múltiple (5 pts, 1 pt c/u)

**1.** ¿Cuál es el número de syscall de `sys_write` en Linux x86-64?

- a) 0
- b) 1
- c) 60
- d) 2

[RESOLVER AQUÍ:**Respuesta: b) 1.** En Linux x86-64, la syscall `write` tiene el número 1 y se utiliza
 para escribir información en la terminal. En la clase 1 se observa cuando se ejecuta `mov rax, 1` antes de `syscall`. ]

---

**2.** ¿En qué registro se pone el **número de syscall** antes de ejecutar `syscall`?

- a) `rdi`
- b) `rsi`
- c) `rax`
- d) `rdx`

[RESOLVER AQUÍ:**Respuesta: c) `rax`.** Antes de ejecutar `syscall`, se coloca en `rax` el número
 de la operación que se quiere solicitar al sistema operativo, como `1` para escribir o `60` para terminar el programa.
 ]

---

**3.** ¿Qué sección usa `resb` para reservar memoria sin ocuparla en el binario?

- a) `.data`
- b) `.text`
- c) `.bss`
- d) `.rodata`

[RESOLVER AQUÍ:**Respuesta: c) `.bss`.** Esta sección permite reservar espacio en memoria para variables sin
 inicializar, usando instrucciones como `resb`. Por ejemplo, `resb 32` reserva 32 bytes para almacenar información. ]

---

**4.** ¿Qué valor de retorno trae `rax` después de un `sys_read`?

- a) 0 siempre
- b) La cantidad de bytes leídos realmente
- c) El tamaño del buffer
- d) El código de error

[RESOLVER AQUÍ:**Respuesta: b) La cantidad de bytes leídos realmente.** Después de ejecutar `sys_read`, `rax` indica cuántos bytes recibió el programa.
 Este valor puede ser menor que la capacidad del buffer, porque no siempre se llena por completo. ]

---

**5.** En clase 3, ¿qué instrucción decide entre ELITE y NOVATO?

- a) `add`
- b) `inc`
- c) `cmp` + `jge`
- d) `sub`

[RESOLVER AQUÍ:**Respuesta: c) `cmp` + `jge`.** La instrucción `cmp` compara los valores y `jge` permite saltar
 a otra parte del programa cuando se cumple la condición de que el primer valor es mayor o igual que el segundo. Así se decide entre ELITE y NOVATO según la lógica implementada. ]

---

## B.2 — Verdadero o Falso con justificación (10 pts, 2 pts c/u)
> Marca V o F. Si es F, escribe la corrección. Una respuesta correcta sin justificación vale 1 pt.

**1.** `db` declara 8 bits (1 byte) por elemento de datos.
[RESOLVER AQUÍ: ]

---

**2.** `mov rax, 60` seguido de `syscall` es la forma estándar de terminar un programa en este curso.
[RESOLVER AQUÍ: ]

---

**3.** `resb 32` escribe 32 bytes de ceros en el binario.
[RESOLVER AQUÍ: ]

---

**4.** En clase 2, el valor de `lon` (la longitud leída) viene de un `equ` fijo calculado por el ensamblador.
[RESOLVER AQUÍ: ]

---

**5.** `add al, 48` convierte un dígito numérico (0–9) en su carácter ASCII imprimible.
[RESOLVER AQUÍ: ]

---

## B.3 — Lectura de código: predice la salida (6 pts)

Dado este fragmento (un programa mínimo y completo):

```asm
section .data
    msg db "HOLA", 10
    len equ $ - msg

section .text
    global _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall
    mov rax, 60
    mov rdi, 3
    syscall
```

1. ¿Qué imprime el programa? (2 pts)
2. ¿Con qué código de salida termina? ¿Qué significa ese código? (2 pts)
3. ¿Cuántas llamadas al kernel (`syscall`) hay? (2 pts)

[RESOLVER AQUÍ: ]

1. El programa imprimirá en pantalla el texto `"HOLA"`. En este caso, despues del texto habrá un salto de línea "\n".
2. El código termina con el código de salida **3**. Este valor realmente no tiene un significado particular para sistema operativo, es simplemente un valor arbitrario que se decidió retornar.
3. El programa realiza 2 llamadas al kernel (`syscall`), una para imprimir en pantalla (`sys_write`) y otra para finalizarlo (`sys_exit`).

---

## B.4 — Encuentra el error (4 pts)

El siguiente código **debería** imprimir `7` pero **no lo hace**. Encuentra el error, explícalo y escribe la línea corregida.

```asm
section .bss
    d resb 1

section .text
    global _start
_start:
    mov al, 7          ; el número a imprimir
    mov [d], al        ; guardar el carácter
    mov rax, 1
    mov rdi, 1
    mov rsi, d
    mov rdx, 1
    syscall
    mov rax, 60
    mov rdi, 0
    syscall
```

> Pista: el programa **debería** imprimir el carácter `7` en pantalla.
> ¿Qué byte está guardando realmente en `d`? ¿Qué instrucción de la
> clase 3 está ausente para que un número (0–9) se vuelva un carácter
> imprimible?

[RESOLVER AQUÍ: ]
### Solución
```asm
section .bss
    d resb 1

section .text
    global _start
_start:
    mov al, 7          ; el número a imprimir
    add al, '0'        ; faltaba convertir el numero a ASCII
    mov [rel d], al    ; guardar el carácter
    mov rax, 1         ; sys_write
    mov rdi, 1         ; std_out
    mov rsi, d         ; direccion del byte
    mov rdx, 1         ; longitud: 1 byte
    syscall
    mov rax, 60        ; sys_exit
    mov rdi, 0         ; codigo de salida
    syscall
```
Para que el código imprimiera el `7`, faltaba convertir el número a `ASCII`, esto de puede hacer sumando el código ASCII de `0` (que es `48`). Ensamblador traduce automáticamente '0' a su carácter ASCII.

**NOTA:** En este caso se usa **rel**, que solicita direccionamiento relativo a RIP, que es una forma apropiada para código x86-64, si no se usa NASM genera una advertencia sobre DEFAULT ABS y de este modo la evitamos.

---

## B.5 — Respuesta corta (10 pts, 2.5 pts c/u)

**1.** ¿Por qué en clase 2 se reserva `resb 32` para un nombre de "máximo 31 letras"?

[RESOLVER AQUÍ: ]

---

**2.** ¿Por qué la clase 2 quita el último byte (LF) del nombre antes de imprimirlo, usando `dec rax`?

[RESOLVER AQUÍ: ]

---

**3.** En clase 3, ¿por qué el programa valida FUE y AGI por separado (0–9) **y además** valida que la suma sea ≤ 9?

[RESOLVER AQUÍ: ]

---

**4.** ¿Qué significa `equ $ - etiqueta` y por qué es útil en vez de contar los bytes a mano?

[RESOLVER AQUÍ: ]

---

## B.6 — Escribe el código (5 pts)

**1. (2 pts)** Escribe el bloque exacto (registros + `syscall`) para **imprimir la cadena**
`"FIN\n"` (con salto de línea) usando `sys_write`. Supón que la cadena está en la etiqueta `fin` y su longitud en `len_fin`.

[RESOLVER AQUÍ: ]

---

**2. (3 pts)** Escribe las líneas de ensamblador para:

- Leer hasta **2 bytes** (1 dígito + el LF del Enter) desde el teclado en un buffer `b` (de `.bss`), usando `sys_read` — igual que la clase 3.
- Validar que sea un dígito entre `'0'` (48) y `'9'` (57); si no lo es, saltar a una etiqueta `.mal`.
- Si es dígito, convertirlo a número (restando 48) y guardarlo en la variable numérica `n` (1 byte, de `.bss`).

[RESOLVER AQUÍ: ]

---

# RÚBRICA DE CALIFICACIÓN

| Sección | Tema | Puntos |
|---------|------|--------|
| A.1 | Clase 1: compilar, ejecutar, strace | 10 |
| A.2 | Clase 2: leer, buffer, modificación | 15 |
| A.3 | Clase 3: atributos, validación, modif. | 20 |
| A.4 | Crear desde cero | 15 |
| **Parte A** | **Práctica** | **60** |
| B.1 | Selección múltiple | 5 |
| B.2 | Verdadero/Falso (5 × 2) | 10 |
| B.3 | Predicción de salida (3 × 2) | 6 |
| B.4 | Encontrar el error (1 pregunta) | 4 |
| B.5 | Respuesta corta (4 × 2.5) | 10 |
| B.6 | Escribir código (2 + 3) | 5 |
| **Parte B** | **Teoría** | **40** |
| **TOTAL** | | **100** |

> **Nota final = (puntos obtenidos / 100) × 20.**
> Aprobación: ≥ 14/20 (es decir, ≥ 70% = 70 pts).

---

# CHECKLIST DE ENTREGA

Antes de entregar, verifica que tu carpeta `examen/` contenga:

- [ ] `clase-01/clase01.asm`, `clase-01/clase01` (binario), `clase-01/trace1.txt`
- [ ] `clase-02/clase02.asm` (modificado), `clase-02/clase02` (binario)
- [ ] `clase-03/clase03.asm` (modificado), `clase-03/clase03` (binario)
- [ ] `heroe.asm` y `heroe` (binario)
- [ ] `entrega.md` con todas las salidas y modificaciones pegadas
- [ ] Este `examen.md` con todos los bloques `[RESOLVER AQUÍ]` respondidos
- [ ] `strace` guardados donde se pidieron

**Recuerda:** el héroe del examen no es el que más rápido termina, sino el que
puede explicar cada línea que escribió.
