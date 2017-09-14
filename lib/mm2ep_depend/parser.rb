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
      def initialize(str, value)
        @name = str
        @value = value
      end

      def compute
        @value
      end

      def to_s
        "var:#{@name}<-(#{@value})"
      end
    end

    class NumberValue < TreeValue
      def initialize(str)
        @value = str
      end

      def compute
        @value
      end

      def to_s
        "number:#{@value}"
      end
    end

    class StringValue < TreeValue
      def initialize(str)
        @value = str
      end

      def compute
        @value
      end

      def to_s
        "string:\"#{@value}\""
      end
    end

    class BoolValue < TreeValue
      def initialize(str)
        @value = str
      end

      def compute
        @value
      end

      def to_s
        "bool:#{@value}"
      end
    end

    class AndOp < TreeExpr
      def initialize(expr1, expr2)
        @expr1 = expr1
        @expr2 = expr2
      end

      def compute
        @expr1.compute && @expr2.compute
      end

      def to_s
        "( #{@expr1} ) AND ( #{@expr2} )"
      end
    end

    class OrOp
      def initialize(expr1, expr2)
        @expr1 = expr1
        @expr2 = expr2
      end

      def compute
        @expr1.compute || @expr2.compute
      end

      def to_s
        "( #{@expr1} ) OR ( #{@expr2} )"
      end
    end

    class NotOp
      def initialize(expr)
        @expr = expr
      end

      def compute
        !@expr.compute
      end

      def to_s
        "NOT ( #{@expr} )"
      end
    end

    class EqOp
      def initialize(lval, rval)
        @lval = lval
        @rval = rval
      end

      def compute
        @lval.value.eql? @rval.value
      end

      def to_s
        "#{@lval} = #{@rval}"
      end
    end

    class Parser < Rly::Yacc
      attr_writer :names
      # def names(tab)
      #   @names = tab
      # end

      precedence :left, :OR_OP
      precedence :left, :AND_OP
      precedence :left, :EQ_OP
      precedence :right, :L_PAR, :R_PAR
      precedence :right, :UMINUS

      rule 'statement : expr' do |st, e|
        st.value = e.value
      end

      rule 'expr : VAR' do |ex, l|
        ex.value = EqOp.new(
          VarValue.new(l.value, @names[l.value]),
          BoolValue.new('true')
        )
      end

      rule 'bool_expr : F_BOOL' do |ex, l|
        ex.value = l.value
      end

      rule 'bool_expr : T_BOOL' do |ex, l|
        ex.value = l.value
      end

      rule 'expr : bool_expr' do |ex, l|
        ex.value = BoolValue.new(l.value.to_s)
      end

      rule 'expr : expr OR_OP expr' do |ex, l, _e, r|
        ex.value = OrOp.new(l.value, r.value)
      end

      rule 'expr : expr AND_OP expr' do |ex, l, _e, r|
        ex.value = AndOp.new(l.value, r.value)
      end

      rule 'expr : L_PAR expr R_PAR' do |ex, _l, e, _r|
        ex.value = e.value
      end

      rule 'expr : NOT_OP expr %prec UMINUS' do |ex, _l, e|
        ex.value = NotOp.new(e.value)
      end

      rule 'expr : VAR EQ_OP bool_expr' do |ex, v, _eq, n|
        # binding.pry
        ex.value = EqOp.new(
          VarValue.new(v.value.to_s, @names[v.value]),
          BoolValue.new(n.value)
        )
      end

      rule 'expr : VAR EQ_OP STRING' do |ex, v, _eq, n|
        ex.value = EqOp.new(
          VarValue.new(v.value.to_s, @names[v.value]),
          StringValue.new(n.value)
        )
      end

      rule 'expr : VAR EQ_OP NUMBER' do |ex, v, _eq, n|
        ex.value = EqOp.new(
          VarValue.new(v.value.to_s, @names[v.value]),
          NumberValue.new(n.value)
        )
      end
    end # class
  end # module
end # module
