class Card
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[クローバー ハート ダイヤ スペード].freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value

    case @rank
    when 'A' then 11
    when 'K', 'Q', 'J' then 10
    else @rank.to_i
    end
  end
end
