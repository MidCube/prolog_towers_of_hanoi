append([],A,A).
append([H|T],A,[H|R]) :- append(T,A,R).

%hiddenApp(A,B,C) :- append(A,B,C).

moveTower(0, _, _, _, A-A).
moveTower(N, StartPeg, TargetPeg, OtherPeg, StartToOther-OtherToTarget) :-
    N=\=0,
    M is N-1,
    moveTower(M, StartPeg, OtherPeg, TargetPeg,
              StartToOther-B),
    B=[move(StartPeg,TargetPeg)|C],
    moveTower(M, OtherPeg, TargetPeg, StartPeg,C-OtherToTarget).
    %hiddenApp(StartToOther,[move(StartPeg,TargetPeg)|OtherToTarget],Moves).

hanoi(Moves) :-
    moveTower(3, 1, 3, 2, Moves-[]).

:- hanoi(Moves), format("~w~n",[Moves]).
