:- consult('data.pl').
is_friend(X, Y) :-
    friend(X, Y).
is_friend(X, Y) :-
    friend(Y, X).
memberr(X,[X|_]).
memberr(X,[_|T]) :-
    memberr(X,T).
lengthh([],0).
lengthh([_|T],N) :-
    lengthh(T,NEWN),
    N is NEWN + 1.

%task1
is_friend(X,Y) :- friend(X,Y);friend(Y,X).
%_______________________________________________%
%task2

friendList(Person1, Friends) :-
    friendList(Person1, [], Friends).

friendList(Person1, Acc, Friends) :-
    is_friend(Person1, Friend),
    \+memberr(Friend, Acc),
    friendList(Person1, [Friend|Acc], Friends).

friendList(_, Friends, Friends).

%_______________________________________________%
%task3

findall_(X, Goal, []) :-
    \+ (Goal, X = _).
findall_(X, Goal, [X|Xs]) :-
    Goal, X = _,
    findall_(X, Goal, Xs).

findall(Term, Goal, List) :-
    findall_(Term, Goal, Xs),
    reverse(Xs, List).

friendList(Person, Friends) :-
    findall(X, friend(Person, X), Friends).

friendListCount(Person,N):-
    friendList(Person,L),
    lengthh(L,N).

%______________________________________________%
%task4

is_friend(X, Y) :-
    (friend(X, Y); friend(Y, X)).

peopleYouMayKnow(X,A):-
    is_friend(X,Z),
    is_friend(Z,Y),
    \+is_friend(X,Y),
    \+X=Y,
    A=Y.
%______________________________________________%
%task5

mutualFriends(_, _, MutualFriends, MutualFriends).


mutualFriends(Person1, Person2, Acc, MutualFriends) :-
    is_friend(Person1, Person3),
    is_friend(Person2, Person3),
    \+ memberr(Person3, Acc),
    mutualFriends(Person1, Person2, [Person3|Acc], MutualFriends).


countMutualFriends(Person1, Person2, Counter) :-
    mutualFriends(Person1, Person2, [], MutualFriends),
    lengthh(MutualFriends, Counter).



peopleYouMayKnow(Person1, Num, SuggestedFriend) :-
    is_friend(Person1, MutualFriend),
    is_friend(MutualFriend, SuggestedFriend),
    not(is_friend(Person1, SuggestedFriend)),
    SuggestedFriend \= Person1,
    countMutualFriends(Person1, SuggestedFriend, Counter),
    Counter >= Num.


%_______________________________________________%
%task6

peopleYouMayKnowList(Person,ListMutual) :-
    peopleYouMayKnowList(Person, [], ListMutual).

peopleYouMayKnowList(Person, List,ListMutual) :-
   mutualFriend(Person,L),
    \+memberr(L, List),
    peopleYouMayKnowList(Person, [L|List],ListMutual).
peopleYouMayKnowList(_,List, List).

mutualFriend(X,Y):-
 friend(X,Z),
 is_friend(Y,Z),
 Y\==X.
%____________________________________________________________%
%task7
people(X, W) :-
    is_friend(X, Y),
    is_friend(Y, Z),
    is_friend(Z, W),
    \+ is_friend(X, W),
    \+ is_friend(Y, W),
    \+ is_friend(X, Z),
    \+ is_friend(W, X),
    \+ is_friend(W, Y),
    \+ is_friend(Z, X),
    Z \= W,
    Y \= W,
    W \= X,
    \+ (is_friend(X, Z), is_friend(Y, W), is_friend(Z, X)).
