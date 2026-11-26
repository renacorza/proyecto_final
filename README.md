Proyecto final Fundamentos de programación

Renato Cortez Zapata y Constanza Pinilla Concha


## Datos

FUENTE:                Servicio Nacional de aduanas, Chile
ARCHIVO:               salida_da_10_2026.csv
ENLACE:                https://www.aduana.cl/aduana/site/docs/20241112/20241112153724/salida_da_10_2026.csv
FECHA DE DESCARGA:     Noviembre 2026
UNIDAD DE OBSERVACIÓN: Cada registro individual de exportación por ítem arancelario 

## Pregunta

¿Cómo varía el peso bruto de las exportaciones chilenas según la vía de transporte
y el país de destino, considerando el tipo de carga exportada, entre enero y 
octubre de 2026?

## Estructura del proyecto

proyecto_final/
├── data/
│    ├── raw/ 
│    └── processed/
├── scripts/
│    ├── 01_limpiar.R 
│    ├── 02_describir.R
│    └── 03_modelar.do
├── output/
│    ├── figuras/
│    └── tablas/
├── informe.tex
├── presentacion.qmd 
└── README.md