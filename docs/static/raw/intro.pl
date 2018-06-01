isMexican(carnitas).
isDelicious(X) :- isMexican(X).

























hasType(t,bool).
hasType(f,bool).
hasType(num, int).
hasType(add(X,Y),int) :- hasType(X,int), hasType(Y, int).














parent(kim, holly).  
parent(margaret, kim).  
parent(herbert, margaret).
parent(john, kim).
parent(felix, john).  
parent(albert, felix).
parent(albert, dana).
parent(felix, maya).