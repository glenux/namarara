module Mm2ep
  module Depend
    class Parser < Rly::Yacc

      precedence :left,  'OR_OP', 'EQ_OP'
      precedence :right,  'AND_OP', 'NOT_OP'

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
        ex.value = "#{l.value} #{s.value} #{e.value}"
      end

      rule 'expr : expr SPACE AND_OP SPACE expr' do |ex, l, s, e, sp, r|
        ex.value = "#{l.value} #{s.value} #{e.value} #{sp.value} #{r.value}"
      end

      rule 'expr : expr SPACE OR_OP SPACE expr' do |ex, l, s, e, sp, r|
        ex.value = "#{l.value} #{s.value} #{e.value} #{sp.value} #{r.value}"
      end
      rule 'expr : L_PAR SPACE expr SPACE R_PAR' do |ex, l, s, e, sp, r|
        ex.value = "#{l.value} #{s.value} #{e.value} #{sp.value} #{r.value}"
      end

      rule 'expr : VAR SPACE EQ_OP SPACE F_BOOL' do |ex, v, s, eq, _, n|
        ex.value = "#{v.value} #{s.value} #{eq.value} #{s.value} #{n.value}"
      end

      rule 'expr : VAR SPACE EQ_OP SPACE T_BOOL' do |ex, v, s, eq, _, n|
        ex.value = "#{v.value} #{s.value} #{eq.value} #{s.value} #{n.value}"
      end

      rule 'expr : VAR SPACE EQ_OP SPACE STRING' do |ex, v, s, eq, _, n|
        ex.value = "#{v.value} #{s.value} #{eq.value} #{s.value} #{n.value}"
      end

      rule 'expr : VAR SPACE EQ_OP SPACE NUMBER' do |ex, v, s, eq, _, n|
        ex.value = "#{v.value} #{s.value} #{eq.value} #{s.value} #{n.value}"
      end

    end # class
  end # module
end # module
