module Mm2ep
  module Depend
    class TestLexer
      attr_reader :truc, :tokens, :fait, :non_traites, :i, :atteint

      BOOL_EXPR = ['T_BOOL', 'F_BOOL'].freeze

      EXPR = {
        'EXPR_T1' => ['VAR'],
        'EXPR_T2' => ['BOOL_EXPR'],
        'EXPR_T3' => ['VAR', 'SPACE', 'EQ_OP', 'SPACE', 'NUMBER'],
        'EXPR_T4' => ['VAR', 'SPACE', 'EQ_OP', 'SPACE', 'STRING'],
        'EXPR_T5' => ['VAR', 'SPACE', 'EQ_OP', 'SPACE', 'T_BOOL'],
        'EXPR_T6' => ['VAR', 'SPACE', 'EQ_OP', 'SPACE', 'F_BOOL'],
        'EXPR_NT1' => ['EXPR', 'SPACE', 'OR_OP', 'SPACE', 'EXPR'],
        'EXPR_NT2' => ['EXPR', 'SPACE', 'AND_OP', 'SPACE', 'EXPR'],
        'EXPR_NT3' => ['L_PAR', 'SPACE', 'EXPR', 'SPACE', 'R_PAR'],
        'EXPR_NT4' => ['NOT_OP', 'SPACE', 'EXPR']
      }.freeze

      def initialize tokens
        @non_traites = []
        @fait = false
        @tokens= tokens
        @i = 0
        @atteint = false
      end

      #
      def try_expr
        @truc = Hash[@truc.sort_by { |key, value| value.length }.reverse!]
        @truc.each do |_, value|
          if @tokens[@i...@i+value.length].eql? value
            @tokens.slice!(@i...@i+value.length)
            @tokens.insert(@i, 'EXPR')
            unless @non_traites.empty?
              @i -= 2
              @non_traites.pop(2)
              @fait = true
              break
            end
          end
        end
      end

      def move_forward
        @non_traites << @tokens[@i]
        @non_traites << @tokens[@i+1]
        @i += 2
      end

      def move_backwards
        @i -= 2
        @non_traites.pop(2)
      end

      def expr_nt
        @fait = false
        try_expr
        # binding.pry
        if !@fait && @i < @tokens.size-1
          if !@atteint || (!@tokens[@i].eql?('OR_OP') && !@tokens[@i].eql?('AND_OP'))
            move_forward
          else
            move_backwards
          end
        elsif !@fait
          move_backwards
        end
      end

      def expr
        @truc = EXPR.select { |key, value| value.include? @tokens[@i] }
        if(!@truc.keys[0].nil? && @truc.keys[0].include?('EXPR_NT'))
            expr_nt
        elsif(!@truc.keys[0].nil? && @truc.keys[0].include?('EXPR_T'))
          @truc = Hash[@truc.sort_by { |key, value| value.length }.reverse!]
          try_expr
        elsif !@non_traites.empty?
          move_backwards
        else
          raise 'BUG 2 !!!!!'
        end
      end

      def lexe
        if @i == @tokens.size-1
          @atteint = true
        end
        if !EXPR.select{|key, value| value.include? @tokens[@i]}.nil?
          expr
        elsif !@non_traites.empty?
          move_backwards
        else
          raise 'BUG !!!!'
        end
      end

      def testlexe
        cle, valeur = nil
        compteur = 0
        while @tokens.size != 1 && compteur < 1000
          lexe
          compteur += 1
        end
        return false unless @tokens. size == 1 && @tokens[0].eql?('EXPR')
        return true
      end
    end
  end
end
