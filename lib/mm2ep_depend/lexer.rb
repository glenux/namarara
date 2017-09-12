module Mm2ep
  module Depend
    class Lexer < Rly::Lex

      token :L_PAR, /\(/
      token :R_PAR, /\)/
      token :NUMBER, /[0-9]+(\.[0-9]+)?/
      token :STRING, /"[^"]*"/
      token :EQ_OP, /\=/
      token :T_BOOL, /[tT]rue/
      token :F_BOOL, /[fF]alse/
      token :VAR, /[a-z][a-zA-Z0-9_]+/
      token :AND_OP, /AND/
      token :OR_OP, /OR/
      token :NOT_OP, /NOT/
      token :SPACE, /\s+/

      on_error do |t|
        puts "Illegal character #{t.value}"
        t.lexer.pos += 1
        nil
      end

    end # class
  end # module
end # module
