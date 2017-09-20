# TODO

* prefixer les spec/files par success ou error
* factoriser parser dans tous les tests unitaires (le mettre en let(:parser)
* dans les tests, verifier quelle variables ont été reportées comme non définies
  (si possible)
* pour priority parser, comparer le to_s de l'expression
  avec celui d'un arbre correct plutot que le résultat

* tester une expression pour chaque type possible dans la grammaire de EXPR 
* tester ensuite quelques combinaisons simples 
* tester enfin les cas foireux (ceux des priorités à gauche/droite sur les NOT, etc.)

