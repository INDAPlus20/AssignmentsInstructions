%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prolog Task 10
%   - template file
%
%   Author: Viola Söderlund <violaso@kth.se>
%   Created: 2020-11-13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Common helper predicates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Is true if the last list equals the concatination of the first two lists
append([],L,L).
append([H|T],L,[H|R]) :- append(T,L,R).

% Is true if the second list equals the first list with the element added to its end
append_el(X,[],[X]).
append_el(X,[H|T],[H|Y]) :-
    append_el(X,T,Y).

% Is true if element equalts the n:th element in list
nth(N,L,E) :- nth(1,N,L,E).
nth(N,N,[H|_],H).
nth(K,N,[_|T],H) :- K1 is K+1, nth(K1,N,T,H).

% Is true if second list equals first list without element
select(X,[X|T],T).
select(X,[Y|T],[Y|R]) :- select(X,T,R).

% Is true if element is in list
member(X,L) :- select(X,L,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Assignment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sequence(From, To, List).

shuffled(InList, OutList).

sum(List, Sum).