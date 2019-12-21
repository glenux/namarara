  
$:.insert(0, 'lib')
require 'namarara'

def verify_input
  parser = Namarara::Parser.new(Namarara::Lexer.new)

  # on démarre avec zéro alertes
  warnings = []

  # ma liste de regles pour lesquelles je veux des alertes
  rules = [
    'est_adulte AND est_subordone',
    'est_adulte AND a_des_enfants',
    'NOT est_adulte'
    # ...
  ]

  # contexte récupéré en HTTP ou en base de données
  context = {
    "est_adulte" => 'false', 
    "est_subordone" => 'true',
    "a_des_enfants" => 'true'
    # 80 valeurs de plus si on veut
  }

  rules.each do |rule|
    parser.names = context
    token = parser.parse(rule)
    res = token.compute
    if res then
      warnings << "La règle #{rule} n'est pas respectée"
    end
  end

  if not warnings.empty?
    puts "Attention: vous collectez des DCP de personnes vulnerables"
    puts warnings.join("\n")
  else
    puts "Rien à dire :-)"
  end

end

verify_input()

