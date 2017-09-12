module Mm2ep
  module Depend
    class And_op
      attr_reader :expr1, :expr2
      def initialize expr1, expr2
        unless expr1.value.to_s.match(/true/).nil?
          @expr1 = true
        else
          @expr1 = false
        end
        unless expr2.value.to_s.match(/true/).nil?
          @expr2 = true
        else
          @expr2 = false
        end
      end

      def and_op
        binding.pry
        return @expr1 && @expr2
      end
    end

    class Or_op
      attr_reader :expr1, :expr2
      def initialize expr1, expr2
        unless expr1.value.to_s.match(/true/).nil?
          @expr1 = true
        else
          @expr1 = false
        end
        unless expr2.value.to_s.match(/true/).nil?
          @expr2 = true
        else
          @expr2 = false
        end
      end

      def or_op
        return @expr1 || @expr2
      end
    end

    class Not_op
      attr_reader :expr
      def initialize expr
        @expr = expr
      end

      def not_op
        # binding.pry
        return true unless @expr.value.to_s.eql? 'true'
        return false
      end
    end

    class Eq_op
      attr_reader :val, :other
      def initialize val, other
        @val = val.value.to_s
        if other.value.to_s.match(/true/).nil?
          @other = true
        else
          @other = false
        end
      end

      def eq_op
        return val = @other
      end
    end

    class Parser < Rly::Yacc

      precedence :left, 'OR_OP', 'EQ_OP'
      precedence :left, 'AND_OP', 'NOT_OP'

      rule 'statement : expr' do |st, e|
        st.value = e.value
      end

      rule 'expr : VAR' do |ex, l|
        ex.value = l.value
      end

      rule 'expr : T_BOOL' do |ex, l|
        ex.value = l.value
      end

      rule 'expr : F_BOOL' do |ex, l|
        ex.value = l.value
      end

      rule 'expr : NOT_OP SPACE expr' do |ex, l, s, e|
        ex.value = Not_op.new(e).not_op
      end

      rule 'expr : expr SPACE AND_OP SPACE expr' do |ex, l, s, e, sp, r|
        ex.value = And_op.new(l, r).and_op
      end

      rule 'expr : expr SPACE OR_OP SPACE expr' do |ex, l, s, e, sp, r|
        ex.value = Or_op.new(l, r).or_op
      end
      rule 'expr : L_PAR SPACE expr SPACE R_PAR' do |ex, l, s, e, sp, r|
        ex.value = e.value
      end

      rule 'expr : VAR SPACE EQ_OP SPACE F_BOOL' do |ex, v, s, eq, _, n|
        ex.value = Eq_op.new(v, n).eq_op
      end

      rule 'expr : VAR SPACE EQ_OP SPACE T_BOOL' do |ex, v, s, eq, _, n|
        ex.value = Eq_op.new(v, n).eq_op
      end

      rule 'expr : VAR SPACE EQ_OP SPACE STRING' do |ex, v, s, eq, _, n|
        ex.value = Eq_op.new(v, n).eq_op
      end

      rule 'expr : VAR SPACE EQ_OP SPACE NUMBER' do |ex, v, s, eq, _, n|
        ex.value = Eq_op.new(v, n).eq_op
      end

    end # class
  end # module
end # module
