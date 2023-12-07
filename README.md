# Laboratorio_robotica

**Por Nicolas Guio**

El objetivo principal de esta práctica fue la familiarización con el robot SCARA T6 de Epson y el software Epson RC +7.0, entre las habilidades a conseguir estuvieron: la comprensión de los comandos Move, Jump, Pallet y Pallet Outside, en el simulador y con el Robot.


## Codigo

La primero parte del codigo consta de la declaración de las variables "i,j" las cuales serviran para hacer unos ciclos mas adelante. Seguido se crea la función main en la cual se configura algunos parametros del robot tales como la velocidad y accerelaciones, y se mueve a la posición home. Por ultimo se crea unos ifs los cuales dependiendo de que señal se encuentre activa esta ejecutara ciertas rutinas. 

```C++
Global Integer i, j
Function main
	Motor On
	Power High
	Accel 30, 30
	Speed 50
	Home
	#define estado_activo 15
	On estado_activo
	If Sw(8) Then
		Call paletizado_base
	EndIf
	If Sw(9) Then
		Call paletizado_z
	EndIf
	If Sw(10) Then
		Call paletizado_S
	EndIf
	If Sw(11) Then
		Call paletizado_externo
	EndIf
	Off estado_activo
	Home
Fend
```

Seguido se definieron las funciones de movimiento tales como paletizado base, la cual mueve la maquina del origen al punto definido como ejex para terminar en el del ejey. Tambien se creo la funcioón paletizado z, en esta se divide el plano formado por los dos ejes en 6, a los cuales se mueve la maquina usando la función jump, la cual es un movimiento en forma de n. El paletizado S mueve al robot en lineas pararelas a los ejes, formando asi unas s. Por ultimo en el externo se llegan a puntos externos al plano definido pero dentro de los limites de trabajo. 

```C++
Function paletizado_base
	Go Origen
	Wait 0.5
	Jump Ejex
	Wait 0.5
	Move Ejey
	Wait 0.5
Fend

Function paletizado_z
	Pallet 1, Origen, Ejey, Ejex, 2, 3
	#define estado_paletizado_z 11
	On estado_paletizado_z
	For i = 1 To 6
		Jump Pallet(1, i)
	Next
	Off estado_paletizado_z
Fend

Function paletizado_S
	Pallet 1, Origen, Ejey, Ejex, 2, 3
	#define estado_paletizado_S 12
	On estado_paletizado_S
	Jump Pallet(1, 1)
	Jump Pallet(1, 2)
	Jump Pallet(1, 4)
	Jump Pallet(1, 3)
	Jump Pallet(1, 5)
	Jump Pallet(1, 6)
	Off estado_paletizado_S
Fend

Function paletizado_externo
	Pallet Outside, 2, Origen, Ejey, Ejex, 2, 3
	#define estado_paletizado_ex 13
	For i = 1 To 3
		For j = 1 To 4
			Jump Pallet(2, i, j)
		Next
	Next
Fend
```

## Desarrollo

Al momento de realizar la practica lo primero fue conectar el computador al robot para de esa manera cargar el codigo, seguido de definir los limites de movimiento para evitar choques con la paredes y la mesa. Usando el Jog&Teach se movia el robot a la posición deseada y se guardaban en las variables origen, ejex y ejey, basicamente definiendo el work object en terminos de ABB. Finalmente se provo la rutina a baja velocidad, para que al comprobar que esta funcionace se operara a las velocidades definidas en el codigo, siendo el resultado el siguiente video:

[![Linea](https://img.youtube.com/vi/lM5uDYcZrE8/maxresdefault.jpg)](https://youtu.be/lM5uDYcZrE8)
