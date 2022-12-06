% 4. В файле хранится база фактов о животных в виде предиката: животное(<название>,<ареал_обитания>,<популяция>). 
% Написать программу, которая бы позволяло править данные файла, вводя количество родившихся или умерших животных, 
% а также формировать список вымирающих животных по заданной границе минимальной популяции.

domains

predicates
	add(string, string, integer)
	del(string, string, integer)
	minimum(integer)
 
facts
animal(string, string, integer).
 
clauses
 add(Name, Habitat, N):-
	animal(Name, Habitat, Population),!,
	Population2 = Population + N, 
	retract(animal(Name, Habitat, Population)), 
	assert(animal(Name, Habitat, Population2)), 
	save("database.txt"). 

del(Name, Habitat, N):-
	animal(Name, Habitat, Population), Population >= N, !,
	Population2 = Population - N, 
	retract(animal(Name, Habitat, Population)), 
	assert(animal(Name, Habitat, Population2)), 
	save("database.txt").
	
minimum(N):-
	animal(Name, Habitat, Population), 
	Population <= N,
	write(Name), write(" ("), write(") - Population: "), write(Population), nl,
	fail.

goal
consult("database.txt"), add("wolf", "forest", 500), del("deer", "land", 100), minimum(100).
