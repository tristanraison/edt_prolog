/* instance.pl

@changelog
f8e54ce Thomas Coquereau        Mon Jan 2 15:35:42 2017 +0100   ADD jours min et max pour le suiv
837a2ac Guillaume Clochard      Mon Jan 2 11:37:16 2017 +0100   Ajout nom des séances
569cfb8 Guillaume Clochard      Mon Jan 2 10:09:13 2017 +0100   Ajout tests unitaires incompatibles/2
47400e0 Guillaume Clochard      Mon Jan 2 08:42:36 2017 +0100   Ajout incompatibles(Groupe1, Groupe2)
9443ae1 Guillaume Clochard      Mon Jan 2 08:03:18 2017 +0100   Convertion # --> %
00c0db5 Guillaume Clochard      Mon Jan 2 07:44:25 2017 +0100   Ajout groupeSeance et profSeance
a57af32 Guillaume Clochard      Mon Jan 2 06:38:22 2017 +0100   Ajout description prédicats
88a4bd3 Guillaume Clochard      Sun Jan 1 21:28:08 2017 +0100   Fix casse des constantes
7c83339 Thomas Coquereau        Thu Dec 29 10:39:47 2016 +0100  ADD suit
935d80e Thomas Coquereau        Thu Dec 29 10:31:46 2016 +0100  ADD seances
a4a8108 Guillaume Clochard      Thu Dec 15 12:55:21 2016 +0100  Début instanciation
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Groupes                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * groupe(Groupe, Effectif)
 *
 * @arg Groupe      Nom du groupe
 * @arg Effectif    Nombre d'étudiants dans le groupe
 **/
groupe(info,      62).
groupe(id,        24).
groupe(silr,      38).
groupe(silr1,     18).
groupe(silr2,     20).
groupe(silr_para, 14).
groupe(silr_code, 24).

/**
 * incompatibles(Groupe1, Groupe2)
 *
 * Définit l'incompatibilité entre 2 groupes (si il y a des étudiants en commun)
 *
 * @arg Groupe1     Nom du groupe 1
 * @arg Groupe2     Nom du groupe 2
 */
incomp(id, info).
incomp(silr, info).
incomp(silr1, silr).
incomp(silr1, info).
incomp(silr2, silr).
incomp(silr2, info).
incomp(silr_para, silr1).
incomp(silr_para, silr2).
incomp(silr_para, silr).
incomp(silr_para, info).
incomp(silr_code, silr1).
incomp(silr_code, silr2).
incomp(silr_code, silr).
incomp(silr_code, info).

% reflexive
incompatibles(X, X) :- !.

% symétrique
incompatibles(X, Y) :- incomp(X, Y), !.
incompatibles(X, Y) :- incomp(Y, X), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Matières                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * matiere(Matiere)
 *
 * @arg Matiere     Nom de la matière
 **/
matiere(projet_genie_logiciel).
matiere(projet_transversal).

matiere(hes_anglais).
matiere(hes_gestion_projet).
matiere(hes_marketing).
matiere(hes_jeu).
matiere(hes_sante_securite).

matiere(connaissances_bdd).
matiere(connaissances_projet_ia).
matiere(connaissances_ia).
matiere(connaissances_organisation).

matiere(math_analyse_donnees).
matiere(math_compta).
matiere(math_crypto).
matiere(math_opti).
matiere(math_archi_parallèle).

matiere(logiciel_patrons).
matiere(logiciel_projet_c).
matiere(logiciel_c).
matiere(logiciel_multimedia).
matiere(logiciel_traitement_image).
matiere(logiciel_reseau).
matiere(logiciel_signal).
matiere(logiciel_outils).
matiere(logiciel_meta_heuristique).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   Profs                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * prof(Prof)
 *
 * @arg Prof     Nom de l'enseignant
 **/
prof(jpeg).
prof(picarougne).
prof(marcus).
prof(prie).
prof(ricordel).
prof(martinez).
prof(kuntz).
prof(parrein).
prof(nachouki).
prof(porcheron).
prof(oili).
prof(pigeau).
prof(soufiane).
prof(milliat).
prof(goncalves).
prof(moreau).
prof(falcher).
prof(gelgon).
prof(raschia).
prof(lecapitaine).
prof(peter).
prof(lehn).
prof(le_callet).
prof(kingston).
prof(vigier).
prof(perreira).
prof(normand).
prof(cohen).
prof(olivier).
prof(leman).
prof(bigeard).
prof(prof_anglais1).
prof(prof_anglais2).
prof(prof_anglais3).
prof(prof_anglais4).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   Plages                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Selon les conseils de M. Le Capitaine, nous avons modifié les plages horaires

/**
 * plage(Id, Start:string, End:string)
 *
 * @arg Id      Id de la plage horaire
 * @arg Start   Heure de début de la plage
 * @arg End     Heure de fin de la plage
 */
plage(1, '08h00', '09h30').
plage(2, '09h45', '11h15').
plage(3, '11h30', '13h00').
plage(4, '14h00', '15h30').
plage(5, '15h45', '17h15').
plage(6, '17h30', '19h00').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    Jour                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * mois(IdMois).
 *
 * @arg IdMois  Id du mois
 */
mois(1).
mois(2).
mois(3).
mois(4).

/**
* joursParMois(-Nb).
*
* @arg Nb  Nombre de jours par mois
*/
joursParMois(20).

/**
* date(IdJour, IdMois)
*
* @arg IdJour  Id du jour
* @arg IdMois  Id du mois
*/
date(J, M) :-   % TODO add tests
    mois(M),
    joursParMois(Max),
    between(1, Max, J).

/**
 * dateBefore(J1, M1, J2, M2)
 *
 * Test si date 1 < date 2
 * @arg J1  Jour date 1
 *
 * @arg M1  Mois date 1
 * @arg J2  Jour date 2
 * @arg M2  Mois date 2
 */
dateBefore( _, M1,  _, M2) :- M1 < M2, !.
dateBefore(J1, M1, J2, M2) :- M1 = M2, J1 < J2, !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Type de cours                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * typeCours(Type)
 *
 * @arg Type  Un type de cours
 */
typeCours(cm).
typeCours(td).
typeCours(tp).
typeCours(ds).
typeCours(mp).
typeCours(tp_para).
typeCours(tp_rez).
typeCours(ds_machine).
typeCours(anglais).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   Salle                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * salle(Nom, Effectif, Types)
 *
 * @arg Nom         Nom de la salle
 * @arg Effectif    Nombre de place disponibles
 * @arg Types       Listes de types de cours
 **/
salle(a1, 300, [cm, ds]).
salle(a2, 200, [cm, ds]).
salle(b001, 26, [tp, mp, ds_machine]).
salle(c001, 26, [tp, mp, ds_machine]).
salle(c002, 26, [tp, mp, ds_machine]).
salle(c008, 50, [cm, td, ds]).
salle(c009, 26, [tp, tp_para, mp, ds_machine]).
salle(c007, 10, [tp_rez]).
salle(e101, 24, [cm, td]).
salle(e102, 24, [cm, td]).
salle(e103, 24, [td]).
salle(e104, 24, [td]).
salle(e202, 50, [cm, td]).
salle(iht_aronax, 100, [cm, td]).
salle(iht_nemo, 50, [td]).
salle(isitem_TD1, 30, [cm, td]).
salle(isitem_TD2, 30, [cm, td]).
salle(isitem_exam, 100, [ds]).

/**
 * salle(Nom, Effectif)
 *
 * @arg Nom         Nom de la salle
 * @arg Effectif    Nombre de place disponibles
 **/
salle(S, N) :- salle(S, N, _). % TODO add tests

/**
 * accueille(Salle, TypeCours)
 *
 * @arg Salle       Nom d'une salle
 * @arg TypeCours   Type de cours que la salle accueille
 */
accueille(S, T) :-  % TODO add tests
    salle(S, _, L),
    member(T, L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  Séances                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
 * seances(Nom, Mat, Prof, Type, Groupe, Ids).
 *
 * Définition de plusieurs séances à la volée
 *
 * @arg Nom     Nom des séances
 * @arg Mat     Id Matière
 * @arg Prof    Id Prof
 * @arg Type    Type de cours
 * @arg Groupe  Id Groupe
 * @arg Ids     Liste d'atomes servant d'ids pour ces séances
 */

/*
 * Systèmes d'information et de connaissances
 * INFO
 */

seances('CM BDD', connaissances_bdd, raschia, cm, info, [
    cm_bdd_1, cm_bdd_2, cm_bdd_3, cm_bdd_4,
    cm_bdd_5, cm_bdd_6, cm_bdd_7, cm_bdd_8
]).

seances('TD BDD', connaissances_bdd, raschia, td, id, [
	td_bdd_id_1,
    td_bdd_id_2,
   	td_bdd_id_3,
    td_bdd_id_4,
    td_bdd_id_5
]).

seances('TP BDD', connaissances_bdd, raschia, tp, id, [
    tp_bdd_id_1,
    tp_bdd_id_2,
    tp_bdd_id_3,
    tp_bdd_id_4,
    tp_bdd_id_5,
    tp_bdd_id_6
]).

seances('TD BDD', connaissances_bdd, nachouki, td, silr1, [
    td_bdd_silr1_1,
    td_bdd_silr1_2,
    td_bdd_silr1_3,
    td_bdd_silr1_4,
    td_bdd_silr1_5
]).

seances('TP BDD', connaissances_bdd, nachouki, tp, silr1, [
    tp_bdd_silr1_1,
    tp_bdd_silr1_2,
    tp_bdd_silr1_3,
    tp_bdd_silr1_4,
    tp_bdd_silr1_5,
    tp_bdd_silr1_6
]).

seances('TD BDD', connaissances_bdd, nachouki, td, silr2, [
    td_bdd_silr2_1,
    td_bdd_silr2_2,
    td_bdd_silr2_3,
    td_bdd_silr2_4,
    td_bdd_silr2_5
]).

seances('TP BDD', connaissances_bdd, nachouki, tp, silr2, [
    tp_bdd_silr2_1,
    tp_bdd_silr2_2,
    tp_bdd_silr2_3,
    tp_bdd_silr2_4,
    tp_bdd_silr2_5,
    tp_bdd_silr2_6
]).

seances('TP mini projet IA', connaissances_projet_ia, lecapitaine, tp, id, [
    tp_projet_ia_id_1,
    tp_projet_ia_id_2,
    tp_projet_ia_id_3,
    tp_projet_ia_id_4,
    tp_projet_ia_id_5,
    tp_projet_ia_id_6
]).

seances('TP mini projet IA', connaissances_projet_ia, lecapitaine, tp, silr1, [
    tp_projet_ia_silr1_1,
    tp_projet_ia_silr1_2,
    tp_projet_ia_silr1_3,
    tp_projet_ia_silr1_4,
    tp_projet_ia_silr1_5,
    tp_projet_ia_silr1_6
]).

seances('TP mini projet IA', connaissances_projet_ia, raschia, tp, silr2, [
    tp_projet_ia_silr2_1,
    tp_projet_ia_silr2_2,
    tp_projet_ia_silr2_3,
    tp_projet_ia_silr2_4,
    tp_projet_ia_silr2_5,
    tp_projet_ia_silr2_6
]).

seances('CM IA', connaissances_ia, martinez, cm, info, [
    cm_IA_1,
    cm_IA_2,
    cm_IA_3,
    cm_IA_4,
    cm_IA_5,
    cm_IA_6
]).

seances('TD IA', connaissances_ia, lecapitaine, td, id, [
    td_IA_id_1,
    td_IA_id_2,
    td_IA_id_3
]).

seances('TD IA', connaissances_ia, martinez, td, silr1, [
    td_IA_silr1_1,
    td_IA_silr1_2,
    td_IA_silr1_3
]).

seances('TD IA', connaissances_ia, raschia, td, silr2, [
    td_IA_silr2_1,
    td_IA_silr2_2,
    td_IA_silr2_3
]).

/*
 * Ingenierie logicielle
 * INFO
 */

seances('CM multimédia', logiciel_multimedia, jpeg, cm, id, [
    cm_multimedia_1,
    cm_multimedia_2,
    cm_multimedia_3,
    cm_multimedia_4
]).

seances('CM multimédia', logiciel_multimedia, gelgon, cm, id, [
    cm_multimedia_5,
    cm_multimedia_6,
    cm_multimedia_7,
    cm_multimedia_8
]).

seances('TP multimédia', logiciel_multimedia, gelgon, tp, id, [
    tp_multimedia_1,
    tp_multimedia_2,
    tp_multimedia_3,
    tp_multimedia_4,
    tp_multimedia_5,
    tp_multimedia_6
]).

seances('CM optimisation et meta heuristique', logiciel_meta_heuristique, kuntz, cm, id, [
    cm_meta_heuristique_1,
    cm_meta_heuristique_2,
    cm_meta_heuristique_3,
    cm_meta_heuristique_4,
    cm_meta_heuristique_5,
    cm_meta_heuristique_6,
    cm_meta_heuristique_7
]).

seances('CM C++', logiciel_c, picarougne, cm, info, [
    tp_c_1,
    tp_c_2,
    tp_c_3,
    tp_c_4,
    tp_c_5,
    tp_c_6,
    tp_c_7,
    tp_c_8,
    tp_c_9,
    tp_c_10
]).

seances('TP C++', logiciel_c, soufiane, tp, id, [
    tp_c_id_1,
    tp_c_id_2,
    tp_c_id_3,
    tp_c_id_4,
    tp_c_id_5,
    tp_c_id_6,
    tp_c_id_7,
    tp_c_id_8,
    tp_c_id_9,
    tp_c_id_10
]).

seances('TP C++', logiciel_c, milliat, tp, silr1, [
    tp_c_silr1_1,
    tp_c_silr1_2,
    tp_c_silr1_3,
    tp_c_silr1_4,
    tp_c_silr1_5,
    tp_c_silr1_6,
    tp_c_silr1_7,
    tp_c_silr1_8,
    tp_c_silr1_9,
    tp_c_silr1_10
]).

seances('TP C++', logiciel_c, picarougne, tp, silr2, [
    tp_c_silr2_1,
    tp_c_silr2_2,
    tp_c_silr2_3,
    tp_c_silr2_4,
    tp_c_silr2_5,
    tp_c_silr2_6,
    tp_c_silr2_7,
    tp_c_silr2_8,
    tp_c_silr2_9,
    tp_c_silr2_10
]).

seances('CM outils ingénierie logiciel', logiciel_outils, cohen, cm, silr, [
    cm_outils_ingenierie_silr_1,
    cm_outils_ingenierie_silr_2
]).

seances('TP outils ingénierie logiciel', logiciel_outils, cohen, tp, silr1, [
    tp_outils_ingenierie_silr1_1,
    tp_outils_ingenierie_silr1_2,
    tp_outils_ingenierie_silr1_3,
    tp_outils_ingenierie_silr1_4,
    tp_outils_ingenierie_silr1_5,
    tp_outils_ingenierie_silr1_6
]).

seances('TP outils ingénierie logiciel', logiciel_outils, vigier, tp, silr2, [
    tp_outils_ingenierie_silr2_1,
    tp_outils_ingenierie_silr2_2,
    tp_outils_ingenierie_silr2_3,
    tp_outils_ingenierie_silr2_4,
    tp_outils_ingenierie_silr2_5,
    tp_outils_ingenierie_silr2_6
]).

/*
 * Mathématiques de la décision
 * ID
 */

seances('CM analyse de données', math_analyse_donnees, kuntz, cm, id, [
    cm_analyse_donnees_1,
    cm_analyse_donnees_2,
    cm_analyse_donnees_3,
    cm_analyse_donnees_4,
    cm_analyse_donnees_5,
    cm_analyse_donnees_6,
    cm_analyse_donnees_7
]).

seances('TD analyse de données', math_analyse_donnees, lecapitaine, td, id, [
    td_analyse_donnees_1,
    td_analyse_donnees_2,
    td_analyse_donnees_3
]).

seances('TP analyse de données', math_analyse_donnees, [lecapitaine, peter], tp, id, [
    tp_analyse_donnees_1,
    tp_analyse_donnees_2,
    tp_analyse_donnees_3,
    tp_analyse_donnees_4,
    tp_analyse_donnees_5,
    tp_analyse_donnees_6
]).

seances('CM architecture para et parallélisation de données', math_archi_parallèle, martinez, cm, id, [
    cm_archi_parallèle_1,
    cm_archi_parallèle_2
]).

seances('TD architecture para et parallélisation de données', math_archi_parallèle, martinez, td, id, [
    td_archi_parallèle_1,
    td_archi_parallèle_2
]).

seances('TD comptabilite', math_compta, goncalves, td, id, [
    td_compta_1,
    td_compta_2,
    td_compta_3,
    td_compta_4,
    td_compta_5,
    td_compta_6,
    td_compta_7
]).

seances('CM crypto', math_crypto, parrein, cm, info, [
    cm_crypto_1,
    cm_crypto_2,
    cm_crypto_3,
    cm_crypto_4,
    cm_crypto_5,
    cm_crypto_6
]).

/*
 * Mathématiques de la décision & réseau
 * Info
 */

seances('TD crypto', math_crypto, raschia, td, id, [
    td_crypto_id_1,
    td_crypto_id_2,
    td_crypto_id_3,
    td_crypto_id_4
]).

seances('TD crypto', math_crypto, normand, td, silr1, [
    td_crypto_silr1_1,
    td_crypto_silr1_2,
    td_crypto_silr1_3,
    td_crypto_silr1_4
]).

seances('TD crypto', math_crypto, parrein, td, silr2, [
    td_crypto_silr2_1,
    td_crypto_silr2_2,
    td_crypto_silr2_3,
    td_crypto_silr2_4
]).

/*
 * Réseaux, multimédias 1
 * Silr
 */

seances('CM réseaux', logiciel_reseau, lehn, cm, silr, [
    cm_reseaux_1,
    cm_reseaux_2,
    cm_reseaux_3,
    cm_reseaux_4,
    cm_reseaux_5,
    cm_reseaux_6,
    cm_reseaux_7
]).

seances('TPréseaux', logiciel_reseau, [leman, parrein], tp, silr1, [
    tp_reseaux_silr1_1,
    tp_reseaux_silr1_2,
    tp_reseaux_silr1_3,
    tp_reseaux_silr1_4,
    tp_reseaux_silr1_5,
    tp_reseaux_silr1_6,
    tp_reseaux_silr1_7,
    tp_reseaux_silr1_8
]).

seances('TPréseaux', logiciel_reseau, [leman, parrein], tp, silr2, [
    tp_reseaux_silr2_1,
    tp_reseaux_silr2_2,
    tp_reseaux_silr2_3,
    tp_reseaux_silr2_4,
    tp_reseaux_silr2_5,
    tp_reseaux_silr2_6,
    tp_reseaux_silr2_7,
    tp_reseaux_silr2_8
]).

seances('CM traitement d\'image', logiciel_traitement_image, jpeg, cm, silr, [
    cm_traitement_image_1,
    cm_traitement_image_2,
    cm_traitement_image_3,
    cm_traitement_image_4,
    cm_traitement_image_5,
    cm_traitement_image_6,
    cm_traitement_image_7,
    cm_traitement_image_8,
    cm_traitement_image_9,
    cm_traitement_image_10,
    cm_traitement_image_11,
    cm_traitement_image_12
]).

seances('TP traitement d\'image', logiciel_traitement_image, [gelgon, perreira], tp, silr1, [
    tp_traitement_image_silr1_1,
    tp_traitement_image_silr1_2,
    tp_traitement_image_silr1_3,
    tp_traitement_image_silr1_4,
    tp_traitement_image_silr1_5,
    tp_traitement_image_silr1_6,
    tp_traitement_image_silr1_7
]).

seances('TP traitement d\'image', logiciel_traitement_image, marcus, tp, silr2, [
    tp_traitement_image_silr2_1,
    tp_traitement_image_silr2_2,
    tp_traitement_image_silr2_3,
    tp_traitement_image_silr2_4,
    tp_traitement_image_silr2_5,
    tp_traitement_image_silr2_6,
    tp_traitement_image_silr2_7
]).

seances('CM traitement du signal', logiciel_signal, le_callet, cm, silr, [
    cm_traitement_signal_1,
    cm_traitement_signal_2,
    cm_traitement_signal_3,
    cm_traitement_signal_4,
    cm_traitement_signal_5,
    cm_traitement_signal_6
]).

seances('TD traitement du signal', logiciel_signal, le_callet, td, silr2, [
    td_traitement_signal_silr1_1,
    td_traitement_signal_silr1_2,
    td_traitement_signal_silr1_3,
    td_traitement_signal_silr1_4,
    td_traitement_signal_silr1_5,
    td_traitement_signal_silr1_6
]).

seances('TD traitement du signal', logiciel_signal, ricordel, td, silr2, [
    td_traitement_signal_silr2_1,
    td_traitement_signal_silr2_2,
    td_traitement_signal_silr2_3,
    td_traitement_signal_silr2_4,
    td_traitement_signal_silr2_5,
    td_traitement_signal_silr2_6
]).

seances('TD traitement du signal', logiciel_signal, [le_callet, vigier], tp, silr1, [
    tp_traitement_signal_silr1_1,
    tp_traitement_signal_silr1_2,
    tp_traitement_signal_silr1_3,
    tp_traitement_signal_silr1_4,
    tp_traitement_signal_silr1_5,
    tp_traitement_signal_silr1_6
]).

seances('TD traitement du signal', logiciel_signal, ricordel, tp, silr2, [
    tp_traitement_signal_silr2_1,
    tp_traitement_signal_silr2_2,
    tp_traitement_signal_silr2_3,
    tp_traitement_signal_silr2_4,
    tp_traitement_signal_silr2_5,
    tp_traitement_signal_silr2_6
]).

/**
 * seances(Id, TypeCours, Matiere, Nom)
 *
 * @arg Id          Id de la séance
 * @arg TypeCours   Type de cours de la séance
 * @arg Matiere     Matiere à laquelle la séance appartient
 * @arg Nom         Nom de la séance
 */
seance(Id, Type, Mat, Nom) :- % TODO add tests
    seances(Nom, Mat, _, Type, _, Ids),
    member(Id, Ids).

/**
 * groupeSeance(Groupe, Seance)
 *
 * Définit la participation d'un groupe à une séance
 *
 * @arg Groupe      Nom du groupe
 * @arg Seance      Id de la séance
 */
groupeSeance(Groupe, Seance) :- % TODO add tests
    seances(_, _, _, _, Groupe, Ids),
    member(Seance, Ids).

/**
 * profSeance(Prof, Seance)
 *
 * Définit la participation d'un enseignant à une séance
 *
 * @arg Prof        Nom de l'enseignant
 * @arg Seance      Id de la séance
 */
profSeance(Prof, Seance) :- % TODO add tests
    seances(_, _, Prof, _, _, Ids),
    \+ is_list(Prof),
    member(Seance, Ids).
profSeance(Prof, Seance) :- % TODO add tests
    seances(_, _, Profs, _, _, Ids),
    is_list(Profs),
    member(Prof, Profs),
    member(Seance, Ids).

/**
 * suitSeancesListe(+S1, ?S2, +Liste).
 *
 * Est vrai si S1 et S2 se suivent dans Liste
 *
 * @arg S1      Id de séance
 * @arg S2      Id de séance
 * @arg Liste   Liste d'id de séances
 */
suitSeancesListe(S2, S1, [S1, S2|_]) :- !. % TODO add tests
suitSeancesListe(S2, S1, [_|Ss]) :-
    suitSeancesListe(S2, S1, Ss).

/**
 * suitSeance(+Seance_suivante, ?Seance_suivie)
 *
 * On remarque que le prédicat nous permet également d'implémenter la relation
 * de suite entre les matière (dernière séance matière 1 - première séance
 * matière 2)
 *
 * @arg Seance_suivante     Id de la séance qui suit
 * @arg Seance_suivie       Id de la séance suivit
 */
suitSeance(td_bdd_id_1, cm_bdd_8) :- !.
suitSeance(tp_bdd_id_1, cm_bdd_8) :- !.
suitSeance(td_bdd_silr1_1, cm_bdd_8) :- !.
suitSeance(tp_bdd_silr1_1, cm_bdd_8) :- !.
suitSeance(td_bdd_silr2_1, cm_bdd_8) :- !.
suitSeance(tp_bdd_silr2_1, cm_bdd_8) :- !.
suitSeance(td_IA_silr2_1, cm_IA_6) :- !.
suitSeance(td_IA_silr1_1, cm_IA_6) :- !.
suitSeance(td_IA_id_1, cm_IA_6) :- !.
suitSeance(tp_projet_ia_silr2_1, td_IA_silr2_3) :- !.
suitSeance(tp_projet_ia_silr1_1, td_IA_silr1_3) :- !.
suitSeance(tp_projet_ia_id_1, td_IA_id_3) :- !.
suitSeance(tp_multimedia_1, cm_multimedia_8) :- !.
suitSeance(tp_multimedia_1, cm_multimedia_4) :- !.
suitSeance(tp_c_id_1, cm_IA_6) :- !.
suitSeance(tp_c_silr1_1, cm_IA_6) :- !.
suitSeance(tp_c_silr2_1, cm_IA_6) :- !.
suitSeance(tp_outils_ingenierie_silr2_1, cm_outils_ingenierie_silr_2) :- !.
suitSeance(tp_outils_ingenierie_silr1_1, cm_outils_ingenierie_silr_2) :- !.
suitSeance(td_analyse_donnees_1, cm_analyse_donnees_7) :- !.
suitSeance(tp_analyse_donnees_1, td_analyse_donnees_3) :- !.
suitSeance(td_archi_parallèle_1, cm_archi_parallèle_2) :- !.
suitSeance(td_crypto_silr2_1, cm_crypto_6) :- !.
suitSeance(td_crypto_silr1_1, cm_crypto_6) :- !.
suitSeance(td_crypto_id_1, cm_crypto_6) :- !.
suitSeance(tp_reseaux_silr1_1, cm_reseaux_7) :- !.
suitSeance(tp_reseaux_silr2_1, cm_reseaux_7) :- !.
suitSeance(tp_traitement_image_silr2_1, cm_traitement_image_12) :- !.
suitSeance(tp_traitement_image_silr1_1, cm_traitement_image_12) :- !.
suitSeance(td_traitement_signal_silr1_6, cm_traitement_signal_6) :- !.
suitSeance(td_traitement_signal_silr2_6, cm_traitement_signal_6) :- !.
suitSeance(tp_traitement_signal_silr1_6, cm_traitement_signal_6) :- !.
suitSeance(tp_traitement_signal_silr2_6, cm_traitement_signal_6) :- !.
suitSeance(S2, S1) :-  % TODO tests
    seances(_, _, _, _, _, Ids),
    suitSeancesListe(S2, S1, Ids).


/**
 * suitSeance(Seance_suivante, Seance_suivie, tempsMin, tempsMax)
 *
 * @arg Seance_suivante     Id de la séance qui suit
 * @arg Seance_suivie       Id de la séance suivit
 * @arg tempsMin     		Nombre de jours min avant la prochaine séance
 * @arg tempsMax       		Nombre de jours max avant la prochaine séance
 */

suitSeance(2, 1, 1, 1).
% suitSeance(3, 1, 1, 2).
% suitSeance(4, 1, 2, 5).
% suitSeance(5, 1, 1, 3).
% suitSeance(6, 1, 2, 2).
% suitSeance(7, 1, 1, 5).
