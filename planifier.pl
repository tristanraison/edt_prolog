/* planifier.pl

*/

/**
 * typesCoursIdentiques(X, Y).
 *
 * @arg X Un type de cours
 * @arg Y Un type de cours
 */
typesCoursIdentiques(X, X).

/**
 * memeMomentCreneau(H, J, M, C).
 *
 * Définit si les deux créneaux sont au même moment.
 *
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeMomentCreneau(H, J, M, [_, H2, J2, M2, _]) :- H = H2, J = J2, M = M2, !.

/**
 * memeSalle(L, C).
 *
 * Définit si L est une salle du créneau C
 *
 * @arg L   Une salle
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeSalle(L, [_, _, _, _, L]) :- !.

/**
 * memeProfs(P, C).
 *
 * Définit si Ps sont des prof du créneau C.
 *
 * @arg Ps  Des enseignant
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeProfs([P|_], [S, _, _, _, _]) :- profSeance(P2, S), P2 = P, !.
memeProfs([_|Ps], [S, H, J, M, L]) :- memeProfs(Ps, [S, H, J, M, L]), !.

/**
 * groupesIncompatibleCreneau(Gs, C).
 *
 * Définit si Gs sont incompatibles avec le groupe de C.
 *
 * @arg Gs  Les groupes
 * @arg C   Un créneau [S, H, J, M, L]
 */
groupesIncompatibleCreneau([G|_], [S, _, _, _, _]) :-
    groupeSeance(G2, S),
    incompatibles(G, G2),
    !.
groupesIncompatibleCreneau([_|Gs], [S, H, J, M, L]) :-
    groupesIncompatibleCreneau(Gs, [S, H, J, M, L]),
    !.

/**
 * sequencementValideCreneau(S, H, J, M, C).
 *
 * Définit si le créneau potentiel est conforme avec le séquencement voulu
 *
 * @arg S   Une séance
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg C   Un créneau [S, H, J, M, L]
 */
% la séance n'en pas en lien avec le créneau transmis
sequencementValideCreneau(S, _, _, _, [S2, _, _, _, _]):-
    \+ suitSeance(S, S2),
    \+ suitSeance(S, S2, _, _),
    !.
sequencementValideCreneau(S, H, J, M, [S2, H2, J2, M2, _]):-
    suitSeance(S, S2),
    (dateBefore(J2, M2, J, M); H2 < H),
    !.
sequencementValideCreneau(S, H, J, M, [S2, H2, J2, M2, _]):-
    suitSeance(S2, S),
    (dateBefore(J, M, J2, M2); H < H2),
    !.
sequencementValideCreneau(S, _, J, M, [S2, _, J2, M2, _]):-
    suitSeance(S, S2, Jmin, Jmax),
    joursParMois(Nb),
    Offset is ((J + M * Nb) - (J2 + M2 * Nb)),
    Offset >= Jmin,
    Offset =< Jmax,
    !.
sequencementValideCreneau(S, _, J, M, [S2, _, J2, M2, _]):-
    suitSeance(S2, S, Jmin, Jmax),
    joursParMois(Nb),
    Offset is ((J2 + M2 * Nb) - (J + M * Nb)),
    Offset >= Jmin,
    Offset =< Jmax,
    !.

/**
 * creneauValideCreneau(P, Gs, H, J, M, L, C).
 *
 * Définit si un cours n'est pas incompatible au moment donné avec les autres
 * cours de la liste de créneaux.
 *
 * @arg Ps  Les enseignants
 * @arg Gs  Les groupes
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg L   La salle
 * @arg Cs  Un créneau [S, H, J, M, L]
 */
creneauValideCreneau(S, Ps, Gs, H, J, M, L, C) :-
    % le créneau valide le séquencement avec C
    sequencementValideCreneau(S, H, J, M, C),
    (
        % le créneau n'est pas au même moment que C
        (\+ memeMomentCreneau(H, J, M, C));
        % ou il ne concerne pas un même prof, des groupes incompatibles
        % ou une même salle
        (
            \+ groupesIncompatibleCreneau(Gs, C),
            \+ memeProfs(Ps, C),
            \+ memeSalle(L, C)
        )
    ),
    !.

/**
 * creneauValide(S, Ps, G, H, J, M, L, [Cs]).
 *
 * Définit si un creneau est valide (Pas de conflit avec les créneaux existants)
 *
 * @arg S   La séance
 * @arg Ps  Les enseignants
 * @arg Gs  Les groupes
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg L   La salle
 * @arg Cs  Liste de créneaux [S, H, J, M, L]
 */
creneauValide(_, _, _, _, _, _, _, []) :- !.
creneauValide(S, Ps, Gs, H, J, M, L, [C|Cs]) :-
    creneauValideCreneau(S, Ps, Gs, H, J, M, L, C),
    creneauValide(S, Ps, Gs, H, J, M, L, Cs),
    !.

/**
 * effectifGroupes(+Gs, -S)
 *
 * @arg Gs  Liste de groupes
 * @arg S   Somme des effectifs des groupes
 */
effectifGroupes([], 0) :- !.
effectifGroupes([G], S) :- groupe(G, S), !.
effectifGroupes([G|Gs], S) :-
    effectifGroupes(Gs, S1),
    groupe(G, S2),
    S is S1 + S2,
    !.

/**
 * planifier(+Ss, -Cs).
 *
 * @arg S   Listes des séances à planifier
 * @arg C   Listes des créneaux construits
 */
planifier([], []) :- !.

planifier(Ss, [C|Cs]) :-

    member(S, Ss),      % La séance courante
    delete(Ss, S, Ss2), % On l'enlève de la liste

    planifier(Ss2, Cs), % on traite le sous-problème

    % Création du créneau et tests ---------------------------------------------

    seance(S, TypeS, _, _),

    % une salle
    salle(L, TailleL),
    accueille(L, TypeL),
    typesCoursIdentiques(TypeS, TypeL), % type de salle valide

    findall(G, groupeSeance(G, S), Gs), % tous les groupes de la séance
    effectifGroupes(Gs, Effectif),
    Effectif =< TailleL, % taille de salle valide

    findall(P, profSeance(P, S), Ps),   % tous les enseignants de la séance

    plage(H, _, _), % une plage horaire
    date(J, M),     % une date

    % test des contraintes (profs, incompatibilité groupes, séquencement)
    % sur cette proposition de créneau
    creneauValide(S, Ps, Gs, H, J, M, L, Cs),

    % Fin création du créneau et tests -----------------------------------------

    C = [S, H, J, M, L].

planification(Cs) :-
   findall(S, seance(S, _, _, _), Ss),
   planifier(Ss, Cs).

afficherSeance(S) :-
    seance(S, TypeCours, Mat, Nom),
    write('Séance:\t\t'),
    write(S), write(' "'), write(Nom), write('"'),
    write(' - '), write(TypeCours),
    write(' - '), write(Mat).

afficherMoment(J, M, H) :-
    plage(H, Start, End),
    write('Date:\t\t'),
    write(J), write('/'), write(M),
    write(' '), write(Start), write('-'), write(End).

afficherGroupe([G]) :-
    write(G),
    !.
afficherGroupe([G, G2|Gs]) :-
    write(G), write(', '),
    afficherGroupe([G2|Gs]).

afficherGroupes(S) :-
    findall(G, groupeSeance(G, S), Gs), % tous les groupes de la séance
    write('Groupes:\t'),
    afficherGroupe(Gs).

afficherProf([P]) :-
    write(P),
    !.
afficherProf([P, P2|Ps]) :-
    write(P), write(', '),
    afficherProf([P2|Ps]).

afficherProfs(S) :-
    findall(P, profSeance(P, S), Ps), % tous les profs de la séance
    write('Profs:\t\t'),
    afficherProf(Ps).

afficherSalle(L) :-
    salle(L, Nb),
    write('Salle:\t\t'), write(L), write('('), write(Nb), write(')').

afficherPlanification([]) :- !.
afficherPlanification(Cs) :-
    date(J, M),
    member(C, Cs),
    C = [S, H, J, M, L],
    write('--------------------------------------------------------------'), nl,
    afficherSeance(S), nl,
    afficherMoment(J, M, H), nl,
    afficherGroupes(S), nl,
    afficherProfs(S), nl,
    afficherSalle(L), nl,
    delete(Cs, C, Cs2),
    afficherPlanification(Cs2).


