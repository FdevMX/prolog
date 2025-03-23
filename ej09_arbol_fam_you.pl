/* Árbol Genealógico - Sistema de Consultas Familiares
   Basado en el árbol correcto:
     Pareja principal: Diego (1926) e Isabela (1927)
     Hijos: Sebastian (1951), Gilberto (1956), Anita (1963) y Francisco (1969)
     Matrimonios: Sebastian está casado con Lilia (1953), Gilberto con Maria (1955); Anita y Francisco permanecen solteros.
     Nietos: Sergio (2006) es hijo de Sebastian y Lilia; Pedro (1990), Estela (1995) y Alfredo (2003) son hijos de Gilberto y Maria.
     Última generación: Pedro está casado con Argelia (1990) y sus hijos son Rene (2003) y Miriam (2016).
   Autor original: Alfredo Lopez Mendez
   Modificado con nueva información.
*/

% Mensaje inicial
mensaje :- 
    nl,
    write('Ejemplo "Arbol Genealogico" con la nueva informacion cargado.'),
    nl, nl.

% ---------------------------------------------------------------------------
%                      BASE DE HECHOS: PADRES E INFORMACIÓN
% ---------------------------------------------------------------------------
% padres(Hijo, Padre, Madre, AñoNacimiento)
padres('Diego', p1, m1, 1926).
padres('Isabela', p2, m2, 1927).

% Hijos de Diego e Isabela
padres('Sebastian', 'Diego', 'Isabela', 1951).
padres('Gilberto', 'Diego', 'Isabela', 1956).
padres('Anita', 'Diego', 'Isabela', 1963).
padres('Francisco', 'Diego', 'Isabela', 1969).

% Hijos de Sebastian y Lilia
padres('Sergio', 'Sebastian', 'Lilia', 2006).

% Hijos de Gilberto y Maria
padres('Pedro', 'Gilberto', 'Maria', 1990).
padres('Estela', 'Gilberto', 'Maria', 1995).
padres('Alfredo', 'Gilberto', 'Maria', 2003).

% Hijos de Pedro y Argelia
padres('Rene', 'Pedro', 'Argelia', 2003).
padres('Miriam', 'Pedro', 'Argelia', 2016).

% ---------------------------------------------------------------------------
%                              MATRIMONIOS
% ---------------------------------------------------------------------------
casados('Diego', 'Isabela').
casados('Sebastian', 'Lilia').
casados('Gilberto', 'Maria').
casados('Pedro', 'Argelia').

% ---------------------------------------------------------------------------
%                                GÉNERO
% ---------------------------------------------------------------------------
hombre('Diego').
hombre('Sebastian').
hombre('Gilberto').
hombre('Francisco').
hombre('Sergio').
hombre('Pedro').
hombre('Rene').
hombre('Alfredo').

mujer('Isabela').
mujer('Lilia').
mujer('Anita').
mujer('Maria').
mujer('Estela').
mujer('Argelia').
mujer('Miriam').

% ---------------------------------------------------------------------------
%                REGLAS DE RELACIONES FAMILIARES
% ---------------------------------------------------------------------------

% Edad en 2025 (como referencia)
edad(Persona, Edad) :- 
    padres(Persona, _, _, AnoNacimiento),
    Edad is 2025 - AnoNacimiento.

% Regla para determinar quién es mayor
mayor(Persona1, Persona2) :- 
    padres(Persona1, _, _, Ano1),
    padres(Persona2, _, _, Ano2),
    Ano1 < Ano2.

% Clasificación por edades
ninyo(Persona) :- 
    edad(Persona, Edad),
    Edad =< 14.

joven(Persona) :- 
    edad(Persona, Edad),
    Edad > 14,
    Edad =< 25.

adulto(Persona) :- 
    edad(Persona, Edad),
    Edad > 25,
    Edad =< 50.

viejo(Persona) :- 
    edad(Persona, Edad),
    Edad > 50.

% Hermanos: comparten padres
hermanos(Hermano1, Hermano2) :- 
    padres(Hermano1, Padre, Madre, _),
    padres(Hermano2, Padre, Madre, _),
    Hermano1 \= Hermano2.

% Tío: hermano del padre o de la madre o su cónyuge
tio(Tio, Sobrino) :- 
    hombre(Tio),
    (  padres(Sobrino, Padre, _, _), hermanos(Tio, Padre)
    ;  padres(Sobrino, _, Madre, _), hermanos(Tio, Madre)
    ;  padres(Sobrino, Padre, _, _), hermanos(Otro, Padre), casados(Tio, Otro)
    ;  padres(Sobrino, _, Madre, _), hermanos(Otro, Madre), casados(Tio, Otro)
    ).

% Tía: hermana de la madre o del padre o su cónyuge
tia(Tia, Sobrino) :- 
    mujer(Tia),
    (  padres(Sobrino, Padre, _, _), hermanos(Tia, Padre)
    ;  padres(Sobrino, _, Madre, _), hermanos(Tia, Madre)
    ;  padres(Sobrino, Padre, _, _), hermanos(Otro, Padre), casados(Otro, Tia)
    ;  padres(Sobrino, _, Madre, _), hermanos(Otro, Madre), casados(Otro, Tia)
    ).

% Primos: hijos de hermanos
primos(Primo1, Primo2) :- 
    padres(Primo1, Padre1, Madre1, _),
    padres(Primo2, Padre2, Madre2, _),
    (  hermanos(Padre1, Padre2)
    ;  hermanos(Padre1, Madre2)
    ;  hermanos(Madre1, Padre2)
    ;  hermanos(Madre1, Madre2)
    ).

% Abuelo: padre de uno de los padres
abuelo(Abuelo, Nieto) :- 
    padres(Nieto, Padre, _, _),
    padres(Padre, Abuelo, _, _).

abuelo(Abuelo, Nieto) :- 
    padres(Nieto, _, Madre, _),
    padres(Madre, Abuelo, _, _).

% Abuela: madre de uno de los padres
abuela(Abuela, Nieto) :- 
    padres(Nieto, Padre, _, _),
    padres(Padre, _, Abuela, _).

abuela(Abuela, Nieto) :- 
    padres(Nieto, _, Madre, _),
    padres(Madre, _, Abuela, _).

% Antepasado: se recorre la línea de padres
antepasado(Antepasado, Persona) :- 
    padres(Persona, Antepasado, _, _).
antepasado(Antepasado, Persona) :- 
    padres(Persona, _, Antepasado, _).
antepasado(Antepasado, Persona) :- 
    padres(Persona, Padre, _, _),
    antepasado(Antepasado, Padre).
antepasado(Antepasado, Persona) :- 
    padres(Persona, _, Madre, _),
    antepasado(Antepasado, Madre).

% Inicialización
:- mensaje.
