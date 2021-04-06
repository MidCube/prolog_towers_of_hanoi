/*This is a bad representation because you have to store
empty lists when you don't have a peg there whereas if you
have a list of the ring and peg it's on then you'll always
have a size 3 list rather than size 5.

So my representation is ([ring,peg],[ring,peg],[ring,peg])
and the rings at the earlier in the list are the ones on top of the peg

The start state is then ([1,left],[2,left],[3,left])
End state is ([1,right],[2,right],[3,right])

Actually better idea. The problem with the previous two designs is
you need to account for the possible lower combinations but that can
be cut out because valid moves only care about the top thing on
each pole so new rep is (TopOfFirstPeg,TopOfSecondPeg,TopOfThirdPeg)

Start state is (1,none,none)
End is (none,none,1)

I can make all the moves reflexive with edge(A,B) :- edge(B,A) but
worried about loops there*/

next((A,B,C),(D,B,C)):-between(1,3,D),A=\=D.
next((A,B,C),(A,D,C)):-between(1,3,D),A=\=B,A=\=D,B=\=D.
next((A,B,C),(A,B,D)):-between(1,3,D),
    A=\=C,A=\=D,
    B=\=C,B=\=D,
    C=\=D.

giveMove((A,B,C),(D,B,C),move(A,D)).
giveMove((A,B,C),(A,D,C),move(B,D)).
giveMove((A,B,C),(A,B,D),move(C,D)).

start((1,1,1)).
finish((3,3,3)).

search(EndState,EndState,_,[]).
search(A,B,PreviouslyVisited,[Move|Moves]):-
    next(A,C),
    \+member(C,PreviouslyVisited),
    giveMove(A,C,Move),
    search(C,B,[C|PreviouslyVisited],Moves),!.

hanoi(Moves) :- start(A),finish(B),search(A,B,[A|[]],Moves).

