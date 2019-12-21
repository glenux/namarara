module Namarara
  class EvalError
    attr_accessor :var
    attr_accessor :message

    def initialize(hash)
      # validate input
      raise ArgumentError unless hash[:message]

      # load input
      @message = hash[:message]
      @var = hash[:var]
    end
  end
end
