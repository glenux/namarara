module Mm2ep
  module Depend
    class TreeExpr 
      def compute 
        raise NotImplementedError 
      end 
    end 

    class TreeValue
      attr_accessor :value
    end 

    class VarValue < TreeValue
      attr_accessor :value 

      def initialize str 
        @name = str
        @value = nil 
      end 

      def compute
        # FIXME: test if @value is a boolean 
        # raise an exception in all other cases
        @value 
      end 
    end 

    class NumberValue < TreeValue
    end 

    class StringValue < TreeValue
    end 

    class BoolValue < TreeValue
      def initialize str 
        @value = case str 
                 when /true/i then true 
                 when /false/i then false 
                 end 

      end 

      def compute
        @value 
      end 
    end 

    class AndOp < TreeExpr
      attr_reader :expr1, :expr2
      def initialize expr1, expr2
          @expr1 = expr1 
          @expr2 = expr2
      end

      def compute
        # binding.pry
        return @expr1.compute && @expr2.compute
      end
    end

    class OrOp
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

      def compute
        return @expr1 || @expr2
      end
    end

    class NotOp
      attr_reader :expr
      def initialize expr
        @expr = expr
      end

      def compute
        # binding.pry
        return true unless @expr.value.to_s.eql? 'true'
        return false
      end
    end

    class EqOp
      attr_reader :val, :other
      def initialize var, value
      end

      def compute
        return if val.value == @other.value
      end
    end

    class Parser < Rly::Yacc

      precedence :left, 'OR_OP', 'EQ_OP'
      precedence :left, 'AND_OP', 'NOT_OP'

      rule 'statement : expr' do |st, e|
        st.value = e.value
      end

      rule 'expr : VAR' do |ex, l|
        ex.value = EqOp.new(
          VarExpr.new(l.value), 
          BoolValue.new('true')
        )
      end

      rule 'expr : T_BOOL' do |ex, l|
        ex.value = BoolExpr.new(l.value)
      end

      rule 'expr : F_BOOL' do |ex, l|
        ex.value = BoolExpr.new(l.value)
      end

      rule 'expr : NOT_OP SPACE expr' do |ex, l, s, e|
        ex.value = NotOp.new(e.value)
      end

      rule 'expr : expr SPACE AND_OP SPACE expr' do |ex, l, s, e, sp, r|
        ex.value = AndOp.new(l.value, r.value)
      end

      rule 'expr : expr SPACE OR_OP SPACE expr' do |ex, l, s, e, sp, r|
        ex.value = OrOp.new(l.value, r.value)
      end
      rule 'expr : L_PAR SPACE expr SPACE R_PAR' do |ex, l, s, e, sp, r|
        ex.value = e.value
      end

      rule 'expr : VAR SPACE EQ_OP SPACE F_BOOL' do |ex, v, s, eq, _, n|
        ex.value = EqOp.new(v.value, n.value)
      end

      rule 'expr : VAR SPACE EQ_OP SPACE T_BOOL' do |ex, v, s, eq, _, n|
        ex.value = EqOp.new(v.value, n.value)
      end

      rule 'expr : VAR SPACE EQ_OP SPACE STRING' do |ex, v, s, eq, _, n|
        ex.value = EqOp.new(v.value, n.value)
      end

      rule 'expr : VAR SPACE EQ_OP SPACE NUMBER' do |ex, v, s, eq, _, n|
        ex.value = EqOp.new(v.value, n.value)
      end

    end # class
  end # module
end # module
