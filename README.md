# Laboratorio_robotica

**Por Nicolas Guio y Andrés Serna**

El objetivo principal de esta práctica de laboratorio era aprender a programar un robot industrial ABB IRB140 utilizando RAPID y controlar sus acciones mediante señales digitales de entrada y salida. Además, debíamos desarrollar la habilidad de manejar bucles, condicionales y estructuras de control en RAPID, así como comprender cómo configurar y utilizar el módulo de entradas y salidas digitales en el controlador IRC5.
## Contenido
- [Resumen](#1)
- [Parámetros DH](#2)
- [Descripción del código de programación](#3)
- [Resultados](#4)

<br>

<a id='1'></a>

## Resumen

En el presente informe se detallan las actividades realizadas en el laboratorio, que incluyeron el uso de Linux, ROS (Robotic Operating System), Python y MATLAB para llevar a cabo la simulación y control de una tortuga (turtle) en el simulador TurtleSim.

## Parámetros DH

El esquema que ilustra el robot pinza se presenta a continuación.

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/0152fa04-4d3e-4274-8ec5-c85c60c39608)

Los marcos de referencia para caracterizar el robot a través de los parámetros DH, basándose en el esquema del robot pinza y las distancias de las articulaciones ya medidas, son los siguientes:

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/731b688f-3f34-480b-b2a8-f7c407236a21)

La siguiente tabla muestra los parámetros DH.

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/5f5d274b-6c6e-4146-8a7f-dbb9296170c2)

Utilizando los parámetros DH, es posible generar las matrices que describen cada enlace con respecto al otro. A continuación se presentan las matrices correspondientes a cada enlace.

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/1ccee768-ad4b-4013-9e50-9a9d3f3bd2a8)

La matriz de la herramienta se describe así. La distancia medida entre el centro del gripper y el eslabón es de 1 cm.

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/b073e563-0419-4c28-9aa5-e82d988433bf)

La matriz de transformación homogénea desde la base hasta el efector final, obtenida mediante la multiplicación consecutiva de las matrices mencionadas anteriormente, se expresa como:

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/44db06d8-2327-40d9-a415-fcff1e0f7951)

donde:

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/40b33c73-c4a9-443c-9bf0-2d33f9819de7)

El robot construido con las herramientas SerialLink de Matlab se visualiza de la siguiente manera.

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/1349a62b-0397-46d2-8588-1f9726b18450)

No obstante, la posición de Home ahora tiene la siguiente configuración, ya que la pose Home se refiere a cuando el robot está completamente vertical.

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/f18165a0-0b9b-4327-a83f-e336a9b9a461)

Considerando las diversas poses requeridas, según se detalla en la siguiente tabla.

![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/dddb1708-a9eb-42a1-bd61-87e941f422f9)

## Descripción del código de programación

En primer lugar, se ajusta la configuración de los motores mediante el archivo de configuración de Dynamixel, que se encuentra en la página del curso. Dentro de este archivo, se establecen los ajustes para los cinco motores que conforman el pincher. Una vez creado este archivo, se procede al código de Python, donde se importan las siguientes dependencias.
![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/2f8b221b-abc6-4936-8c93-300ef1769ec0)

El módulo rospy se utiliza para el funcionamiento general de ROS en Python, numpy se emplea para realizar operaciones matemáticas en el código, y diversos tópicos y mensajes propios de ROS son importados. La función Join_publisher se encarga de inicializar un objeto publisher con el tema de joint_trajectory, el cual se utiliza dentro del objeto de la clase Publisher creado posteriormente. Se inicia un bucle siempre que rospy no se haya apagado, y luego se envían los puntos guardados al motor. Es importante señalar que esta función es un remanente de pruebas anteriores y no se utiliza en el código principal del programa.
![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/6bf5efa2-98bb-45d7-bfb9-0d439b0312dd)

Las funciones callback y listener se encargan de recibir y procesar datos obtenidos de los servomotores del manipulador. En el caso de listener, se inicializa el nodo que representa el código de Python dentro del entorno de ROS, además de suscribirlo al tópico que transmite los estados de las articulaciones del robot. Por otro lado, la función de callback crea una variable global que puede ser utilizada fuera de la función. Esta variable se define como la multiplicación de un dato recibido por 180/pi, lo que convierte una entrada en radianes a grados.
![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/271a3500-5e58-40e6-8559-ea302ea9e758)

La función jointCommand espera a que el servicio de transmitir al motor esté disponible. En cuanto esto sucede, intenta enviar un comando de Dynamixel definido como un servicio del entorno de Dynamixel. Este comando incluye un número de comando, un identificador para el motor al que se refiere, el nombre de la dirección de memoria que debe modificar el comando y, finalmente, el valor nuevo que tomará esta posición de la memoria. Una vez enviado, se espera un tiempo para ROS y se devuelve el resultado de la instrucción enviada al manipulador.
![image](https://github.com/Nguiom/Laboratorio_robotica/assets/72366982/ada8221b-ca7d-4278-aa6c-b05d456e884c)

En la parte del código que se ejecuta al llamar al archivo desde la consola de comandos, se ejecuta la función de listener para inicializar el nodo de ROS y la recepción de datos enviados por los motores. Los datos del grupo se imprimen en la consola y se almacenan en varias listas las posiciones disponibles para enviar, tanto en sus valores de bits como en sus valores en grados. Luego, se crea una lista de listas con las posiciones disponibles y se muestran al usuario estas posiciones en sus valores en grados.

## Resultados

1. **Selección de Repositorios Específicos:** La elección de Dynamixel One Motor como repositorio principal destaca la importancia de identificar fuentes confiables y especializadas para optimizar el desarrollo del proyecto. La decisión de enfocarse en archivos específicos enriqueció el proceso y aceleró la implementación del laboratorio.

2. **Acceso Directo a Códigos Relevantes:** La decisión de utilizar los códigos de la carpeta de scripts dentro del repositorio seleccionado subraya la importancia de acceder a recursos que aborden directamente los aspectos necesarios para el proyecto. Esta elección no solo simplificó la programación, sino que también facilitó una comprensión más profunda de los conceptos clave asociados con el control de los motores Dynamixel.

3. **Experiencia Positiva en Colaboración:** La experiencia positiva al emplear los repositorios de referencia resalta la importancia de la colaboración y el intercambio de conocimientos en comunidades especializadas. Aprovechar los recursos existentes condujo a una eficiencia y comprensión superiores en comparación con la consideración de otros trabajos, enfatizando la relevancia de la colaboración y el aprendizaje compartido en entornos tecnológicos.
