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

