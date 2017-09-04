module Mm2ep
  module Depend
    class Lexer
      attr_reader :expr

      BOOL_EXPR = ['T_BOOL', 'F_BOOL']
      START_EXPR = ['VAR', 'BOOL_EXPR','NOT_OP', 'EXPR', 'L_PAR']

      def initialize
        @expr = []
      end

      def validate_space
      end

      def validate tokens
        if START_EXPR.include? tokens[0]
          @expr << tokens[0]
          tokens = tokens.drop(1)
        end
      end

    end # class
  end # module
end # module
