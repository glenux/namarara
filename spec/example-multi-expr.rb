
require 'namarara'

# Initialize Namarara
namarara = Namarara::Parser.new(Namarara::Lexer.new)

# A set of rules i want to check 
# (in this example we are looking for sensitive personnal data)
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

results = rules.map { |rule, expr| [rule, namarara.parse(expr).compute] }

if results.select{ |rule, value| value }.empty?
    puts "Perfect! Nothing to say ;-)"
else
    puts "Warning: you are collectif sensitive personnal data !"
    results.each do |rule, value|
      puts "#{value ? '>>':'  '} #{rule}: #{value}" 
    end
end
