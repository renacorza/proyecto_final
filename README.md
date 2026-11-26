Proyecto final Fundamentos de programación

Renato Cortez Zapata
Constanza Pinilla Concha


## Datos

FUENTE:                Servicio Nacional de aduanas, Chile
ARCHIVO:               salida_da_10_2026.csv
ENLACE:                https://www.aduana.cl/base-de-datos-operaciones-de-salida/aduana/2024-11-12/153724.html
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