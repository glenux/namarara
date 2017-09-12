module Mm2ep
  module Depend
    class TreeExpr 
      def compute 
        raise NotImplementedError 
      end 
    end 

    class TreeValue
      def value 
        raise "No value for #{@name}" if @value.nil?
        @value 
      end 

      def to_s 
        raise NotImplementedError
      end 
    end 

    class VarValue < TreeValue
      def initialize str 
        @name = str
        @value = nil 
      end 

      def to_s 
        "var:#{@name}<-(#{@value})"
      end
    end 

    class NumberValue < TreeValue
      def initialize str 
        @value = str.to_i
      end 

      def to_s 
        "number:#{@value}"
      end
    end 

    class StringValue < TreeValue
      def initialize str 
        @value = str
      end 

      def to_s 
        "string:\"#{@value}\""
      end
    end 

    class BoolValue < TreeValue
      def initialize str 
        @value = case str 
                 when /true/i then true 
                 when /false/i then false 
                 end 

      end 

      def to_s 
        "bool:#{@value}"
      end
    end 

    class AndOp < TreeExpr
      def initialize expr1, expr2
          @expr1 = expr1 
          @expr2 = expr2
      end

      def compute
        # binding.pry
        return @expr1.compute && @expr2.compute
      end

      def to_s 
        "( #{@expr1.to_s}) AND (#{@expr2.to_s} )"
      end 
    end

    class OrOp
      def initialize expr1, expr2
          @expr1 = expr1 
          @expr2 = expr2
      end

      def compute
        return @expr1.compute || @expr2.compute
      end

      def to_s 
        "( #{@expr1.to_s}) OR (#{@expr2.to_s} )"
      end 
    end

    class NotOp
      def initialize expr
        @expr = expr
      end

      def compute
        return ! @expr.compute 
      end

      def to_s 
        "NOT ( #{@expr.to_s} )"
      end 
    end

    class EqOp
      def initialize lval, rval
        @lval = lval 
        @rval = rval
      end

      def compute
        return if @lval.value == @rval.value
      end

      def to_s 
        "#{@lval.to_s} = #{@rval.to_s}"
      end 
    end

    class Parser < Rly::Yacc

      precedence :left, 'OR_OP'
      precedence :left, 'AND_OP'
      precedence :left, 'EQ_OP' 
      precedence :right, :UMINUS

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
        ex.value = BoolValue.new(l.value.to_s)
      end

      rule 'expr : F_BOOL' do |ex, l|
        ex.value = BoolValue.new(l.value.to_s)
      end

      rule 'expr : NOT_OP SPACE expr %prec UMINUS' do |ex, l, s, e|
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
        ex.value = EqOp.new(
          VarValue.new(v.value.to_s), 
          BoolValue.new(n.value)
        )
      end

      rule 'expr : VAR SPACE EQ_OP SPACE T_BOOL' do |ex, v, s, eq, _, n|
        ex.value = EqOp.new(
          VarValue.new(v.value.to_s), 
          BoolValue.new(n.value)
        )
      end

      rule 'expr : VAR SPACE EQ_OP SPACE STRING' do |ex, v, s, eq, _, n|
        ex.value = EqOp.new(
          VarValue.new(v.value.to_s), 
          StringValue.new(n.value)
        )
      end

      rule 'expr : VAR SPACE EQ_OP SPACE NUMBER' do |ex, v, s, eq, _, n|
        ex.value = EqOp.new(
          VarValue.new(v.value.to_s), 
          NumberValue.new(n.value)
        )
      end

    end # class
  end # module
end # module
