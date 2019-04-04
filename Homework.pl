%Problema I
direct_train(craiova, bucharest).
direct_train(sibiu, craiova).
direct_train(deva, sibiu).
direct_train(brasov, deva).
direct_train(pitesti, brasov).
direct_train(ploiesti, pitesti).
direct_train(constanta, ploiesti).

route(A, B) :- direct_train(A, B), !. 
route(A, B) :- direct_train(A, X), route(X, B).

/**
 *route(+Location_A : variable, +Location_B : variable).
 *route is True if there is a direct train between locations A and B.
 *So the base case or the stop case is as following: if there is a direct train between A and B we have a route between A and B.
 *! operator is used so the program will not backtrack back behind this operator.
 *
 *route is true if there is a direct train between A and another location X and also a route between X and the final destination B.
 *This represents the recursive case because the route(X,B) will follow the same arboration style as the initial route(A,B) going to the base case situation.
 *
 *
 *Examples:
 *
 *?-route(constanta,bucharest)
 *true
 *
 *?-route(constanta,ploiesti)
 *true
 *
 *?-route(deva,constanta)
 *false
 */

%Problema II
translate(unu, one).
translate(doi, two).
translate(trei, three).
translate(patru, four).
translate(cinci, five).
translate(sase, six).
translate(sapte, seven).
translate(opt, eight).
translate(noua, nine). 

means([], []).  							
means([Head|Tail], [ResHead|ResTail]):-     
             translate(Head, ResHead),		
             means(Tail,ResTail).			

/**
 *The base or the stop case for this recursion represents two empty lists which means we have emptied out the list of words to be translated.
 *
 *means(+List_in : list, -List_result : list).
 *
 *The recursion will go as follows: the head of the input list will be translated with the avalaible predicate if it exists.
 *means will recall itself on the Tail of the remaining list untill the base case which is an empty list so all elements were evaluated.
 *if there is a single element that cannot be translated, there is no predicate translate declare for it, the function will return false.
 *
 *Examples:
 *
 *?-means([unu,doi,trei],Res)
 *Res = [one, two, three]
 *
 *?-means([noua],Res)
 *Res = [nine]
 *
 *?-means([abc,unu,doi],Res)
 *false
 */


%Problema III     
append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- 
	append(Tail, List, Rest).

duplicate_El(Elem, 1, [Elem]).
duplicate_El(Elem, N, [Elem|DupedEl]) :- 
	N > 1, N2 is N-1, 
	duplicate_El(Elem, N2, DupedEl). 

duplicate_NList([], _, []).
duplicate_NList([Head|Tail], N, DupedList) :- 
	duplicate_El(Head, N, DupedH), 
	duplicate_NList(Tail, N, DupedT), 
	append(DupedH, DupedT, DupedList). 

/**
 *append(+List1 : list, +List2 : list, +List3: list).
 *This is an utilitary funtion used to append two lists.
 *
 *duplicate_El(+Elem : variable, +N : Integer, -List : list).
 *This is an utilitary recursive function used to duplicate an element N times, the result is stored in a list.
 *The base case happens when the N iterator is decremented to 1, 
 *then recursively the end list is formed by adding an aditional Element for every iteration that happened.
 *
 *duplicate_NList(+List : list, +N : Integer, -DupedList : list).
 *This is the function used to duplicate every element from List N times and adding the resulting data into DupedList.
 *The base case happens when the list Head is empty ( [] ), after every iteration the function is recalled on Tail, after this is empty we go to stop case.
 *After this at the revursive return every Duped Tail is Appended to its DupedHead, a DupedHead takes the place of DupedTail for its DupedHead predecessor untill the first DupedHead.
 *The end result will be a list will all elements from the input list duped N times.
 *
 *The only fail we can encounter happens when we try tu duplicate something 0 times, then the interogation will return false.
 *
 *Examples:
 *
 *?-append([1,2,3],[4,5,6],Res)
 *Res = [1, 2, 3, 4, 5, 6]
 *
 *?-duplicate_El(x,4,Res)
 *Res = [x, x, x, x]
 *
 *?-duplicate_NList([x,y,z],3,Res)
 *Res = [x, x, x, y, y, y, z, z, z]
 *
 *?duplicate_NList([x,y,z],0,Res)
 *false
 */

%Problema IV
insert_at(Elem, 1, Tail, [Elem|Tail]).
insert_at(Elem, N, [Head|Tail], [Head|Res_tail]) :-
        N1 is N - 1,
        insert_at(Elem, N1, Tail, Res_tail).

/**
 *insert_at(+Elem : variable, +Position : Integer, ?List1 : list, ?List2 : list).
 *
 *base case or stop case happens when the Position decrements to 1, this means the element can pe appended to the tail of the list is his deisred position.
 *after the base case the program will exit recursively adding behind the new tail ( [Element|Tail] ) the initial Head of list thus forming the new list with the Element in the desired position.
 *
 *The only fails we can encounter will happen of we try to add outside of the bounds of our list size.
 *
 *Examples:
 *
 *?-insert_at(x,3,[1,2,3,4,5],Res)
 *Res = [1, 2, x, 3, 4, 5]
 *
 *?-insert_at(x,1,[1,2,3,4,5],Res)
 *Res = [x, 1, 2, 3, 4, 5]
 *
 *?-insert_at(x,6,[1,2,3,4,5],Res)
 *Res = [1, 2, 3, 4, 5, x]
 *
 *?-insert_at(x,0,[1,2,3,4,5],Res)
 *false
 *
 *?-insert_at(x,7,[1,2,3,4,5],Res)
 *false
 * 
 */


%Problema V

range(Same,Same,[Same]) :- !.    
range(Low,High,[Low|List_tail]) :-    
    Low =< High,
    New_Low is Low+1,				
    range(New_Low,High,List_tail).	
/**
 *The base or the stop case for the recursion happens when Low == High == Head so the conting has ended.
 *! operator is used so the program will not backtrack back behind this operator.
 *
 *range(+Low : variable, +High : variable, -List : list).
 *Low and High will be the bounds of the range we want to create.
 *
 *The recursion will go as follows : while Low =< High the new low value will be Low + 1, note that if Low > High the function will fail and return false.
 *the function range will recall itself of (New_Low,High,List_tail) untill New_Low and High have the same value, see abose stop case.
 *after the stop case the Result will form recursively the result list, ranging from every New_Low to the initial Low value.
 *
 *Examples:
 *
 *?-range(1,5,Res)
 *Res = [1, 2, 3, 4, 5]
 *
 *?-range(3,3,Res)
 *Res = [3]
 *
 *?-range(5,3,Res)
 *false
 */

%Problema IV
remove_if(Element,1,[Element|Tail],Tail) :- !.  			
remove_if(Element,Pos,[Head|Tail],[Head|Tail_s]) :-     
	Pos > 1, 
   	Pos_s is Pos - 1, remove_if(Element,Pos_s,Tail,Tail_s).

insert_at(Element,Pos,List,Result) :- remove_if(Element,Pos,Result,List).  

/**
 *The approach used: a remove function that removes recursively an element from a list if it exists in a certain specified position
 *The insert function will call remove for element and position to add on the Result list
 *both the insert and the remove functions have the same predicates: (element,position,list,result).
 *calling remove_if on (element,position,result,list) knowing all but the remove will fake the removal of an element from Result in the position specified
 *thus we will instead add that element to Result.
 *
 *remove_if(+Element : Element, ?Iterator : 1, ?List : [Element|Tail], ?List_tail : Tail).
 *base or stop case when Position reaches 1 and if the Head of the List won't be our element to remove the function will fail.
 *if the head and our element matches the function will return true and recursively remove the element from the list. 
 *! operator is used so the program will not backtrack back behind this operator.
 *
 *remove_if(+Element : Element, ?Position : Pos, ?List : [Head|Tail], ?Result : [Head|Tail_s]) :-
 *Pos >1,
 *Pos_s is Pos - 1 (Pos_s is an iterator that is decremented, Pos_s will be called by the next recursive call).
 *remove_if(+Element : Element, ?Iterator : Pos_s, ?List : Tail, ?Result : Tail_s).
 *the function will call itself untill the stop case, if it doesn't fail untill this point it means the element to be removed is in the corect specified posiiton.
 *We will return then the Tail of the list since the element if the Head now, recursively a new list will result without the said element.
 *
 *Examples:
 *
 *?-remove_if(1,1,[1,2,3,4,5],Res)
 *Res = [2, 3, 4, 5]
 *
 *?-remove_if(x,3,[1,2,x,3,4,5],Res)
 *Res = [1, 2, 3, 4, 5]
 *
 *?-remove_if(x,3,[1,2,3,4,5],Res)
 *false
 *
 *The insertion will basically reverse engineer the remove_if fruntion by calling remove_if on the result as following:
 *insert_at(+Element : Element, ?Position : Pos, ?List : List, ?Result : Result) :-
 *   remove_if(+Element : Element, ?Position : Pos, ?Result : Result, ?List : List).
 *Because we call the remove of element in the position Pos on the result list with the output of list the insert function will return Result which is the list before the removal.
 *The only fails we can encounter will happen of we try to add outside of the bounds of our list size(pos < min_size or pos > max_size + 1).
 *Examples:
 *
 *?-insert_at(x,3,[1,2,3,4,5],Res)
 *Res = [1, 2, x, 3, 4, 5]
 *
 *?-insert_at(x,1,[1,2,3,4,5],Res)
 *Res = [x, 1, 2, 3, 4, 5]
 *
 *?-insert_at(x,6,[1,2,3,4,5],Res)
 *Res = [1, 2, 3, 4, 5, x]
 *
 *?-insert_at(x,0,[1,2,3,4,5],Res)
 *false
 *
 *?-insert_at(x,7,[1,2,3,4,5],Res)
 *false
 */	
