module Mm2ep
  module Depend
    class Parser
      attr_reader :tokens

      TOKEN = {
        'L_PAR' => "(",
        'NUMBER' => /[0-9]+(\.[0-9]+)?/,
        'STRING' => /"[^"]*"/,
        'EQ_OP' => "=",
        'T_BOOL' => /[tT]rue/,
        'F_BOOL' => /[fF]alse/,
        'VAR' => /[a-z][a-zA-Z0-9_]+/,
        'AND_OP' => "AND",
        'OR_OP' => "OR",
        'NOT_OP' => "NOT",
        'SPACE' => /\s+/,
        'R_PAR' => ")"
      }.freeze

      def initialize
        @tokens = []
      end

      def parse s
        s = s.split(' ')
        s.each_with_index do |element, idx|
          TOKEN.each do |token, regex|
            next if element.sub!(regex, '').nil?
            @tokens << token
            break if element.nil?
          end
          @tokens <<'SPACE' unless idx == s.length-1
        end
        puts @tokens
      end # def

    end # class
  end # module
end # module
