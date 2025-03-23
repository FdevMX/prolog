# Ejemplo de consultas para el árbol genealógico

Este programa permite realizar consultas sobre relaciones familiares. Aquí algunos ejemplos:

## Consultas básicas

```prolog
% Consultar la edad de una persona (referencia año 1998)
?- edad('Diego', Edad).

% Verificar si una persona es mayor que otra
?- mayor('Diego', 'Sebastian').
```

## Consultas de relaciones familiares

```prolog
% Encontrar hermanos de una persona
?- hermanos('Sebastian', Hermano).

% Encontrar tíos de una persona
?- tio(Tio, 'Sergio').
?- tia(Tia, 'Estela').

% Identificar a los primos de Alfredo
?- primos('Alfredo', Primo).

% Buscar los abuelos de una persona
?- abuelo(Abuelo, 'Sergio').
?- abuela(Abuela, 'Estela').

% Buscar antepasados de una persona
?- antepasado(Antepasado, 'Rene').
```

Para ejecutar estas consultas, carga el archivo `ej09_arbol_fam_you.pl` en tu intérprete de Prolog.


