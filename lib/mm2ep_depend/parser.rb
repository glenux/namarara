module Mm2ep
  module Depend
    class TreeExpr
      def compute
        raise NotImplementedError
      end
    end

    class TreeValue
      attr_reader :value

      def to_s
        raise NotImplementedError
      end
    end

    class VarValue < TreeValue
      attr_reader :errors

      def initialize(str, value)
        @errors = []
        @name = str
        @value = case value
                 when /true/i then true
                 when /false/i then false
                 else value
                 end
        return unless @value.nil?
        @errors << VarNotDefined.new(
          message: "No value for #{@name}",
          var: @name
        )
      end

      def compute
        @value
      end

      def to_s
        "var:#{@name}<-(#{@value})"
      end
    end

    class NumberValue < TreeValue
      attr_reader :errors

      def initialize(str)
        @errors = []
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
      attr_reader :errors

      def initialize(str)
        @errors = []
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
      attr_reader :errors

      def initialize(str)
        @errors = []
        @value = case str
                 when /true/i then true
                 when /false/i then false
                 end
      end

      def compute
        @value
      end

      def to_s
        "bool:#{@value}"
      end
    end

    class AndOp < TreeExpr
      attr_reader :errors

      def initialize(lval, rval)
        @errors = []
        @errors.concat lval.errors
        @errors.concat rval.errors
        @lval = lval
        @rval = rval
      end

      def compute
        @lval.compute && @rval.compute
      end

      def to_s
        "( #{@lval} ) AND ( #{@rval} )"
      end
    end

    class OrOp
      attr_reader :errors

      def initialize(lval, rval)
        @errors = []
        @errors.concat lval.errors
        @errors.concat rval.errors
        @lval = lval
        @rval = rval
      end

      def compute
        @lval.compute || @rval.compute
      end

      def to_s
        "( #{@lval} ) OR ( #{@rval} )"
      end
    end

    class NotOp
      attr_reader :errors

      def initialize(expr)
        @errors = []
        @errors.concat expr.errors
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
      attr_reader :errors

      def initialize(lval, rval)
        @errors = []
        @errors.concat lval.errors
        @errors.concat rval.errors
        @lval = lval
        @rval = rval
      end

      def compute
        @lval.value == @rval.value
      end

      def to_s
        "#{@lval} = #{@rval}"
      end
    end

    class Parser < Rly::Yacc
      attr_writer :names

      # Check if grammar is valid
      def check_grammar(line, tokens)
        grammar = tokens.to_s.split(/=|AND|OR/)
        expr = line.split(/=|AND|OR/)
        return if grammar.size == expr.size
        return if grammar.empty?
        tokens.errors << InvalidGrammar.new(
          message: 'Invalid Grammar'
        )
      end

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
