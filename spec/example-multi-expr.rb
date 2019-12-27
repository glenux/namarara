
require 'namarara'

# Initialize Namarara
namarara = Namarara::Parser.new(Namarara::Lexer.new)

# A set of rules i want to check
rules = {
    vulnerable_person: 'is_adult AND is_subordinate',
    has_constraints: 'is_adult AND has_children',
    is_child: 'NOT is_adult'
    # ...
}

# A set of values i want to inject (values must be expressed as strings)
namarara.names = {
    "is_adult" => 'false', 
    "is_subordinate" => 'true',
    "has_children" => 'true'
}

rules.map do |rule|
    namarara_bet = namarara.parse(rule.expr)
    result = namarara_bet.compute
    if result then
        warnings << "Rule #{rule} is true"
    end
end

if not warnings.empty?
    puts "Warning: you are collectif sensitive personnal data !"
    puts warnings.join("\n")
else
    puts "Perfect! Nothing to say ;-)"
end
