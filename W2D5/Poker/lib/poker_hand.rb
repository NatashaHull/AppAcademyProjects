class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def get_hand(deck)
    until @cards.length == 5
      @cards << deck.draw_card
    end
  end

  def discard_card(card)
    @cards.delete(card)
  end

  def hand_value
    @cards.sort_by!(&:value)
    #Calculate how good the hand is
    if straight_flush
      return 160 + straight_flush #Account for Ace through five flush
    elsif four_of_a_kind
      return 140 + four_of_a_kind
    elsif full_house
      return 120 + full_house
    elsif flush
      return 100 + flush
    elsif straight
      return 80 + straight
    elsif three_of_a_kind
      return 60 + three_of_a_kind
    elsif num_pairs
      return 40 + num_pairs.keys.sort.last if num_pairs.count == 2
      return 20 + num_pairs.keys.last
    else
      return high_card
    end
  end

  def display
    p @cards.map(&:display)
  end

  private

    def high_card
      @cards.last.value
    end

    def calculate_value_frequency
      values = @cards.map(&:value)
      value_frequency = Hash.new(0)

      values.each do |value|
        value_frequency[value] += 1
      end

      value_frequency
    end

    def num_pairs
      value_frequency = calculate_value_frequency
      value_frequency.select! { |key, value| value == 2 }

      return value_frequency if value_frequency.count > 0
    end

    def three_of_a_kind
      value_frequency = calculate_value_frequency
      value_frequency.select! { |key, value| value == 3 }

      if value_frequency.length == 1
        return value_frequency.keys.first
      end
    end

    def straight
      values = @cards.map(&:value)
      first_value = values.first
      last_value = values.last

      #Moves Ace in front if the lowest card is a 2
      if last_value == (Deck::NUM_CARDS+Deck::FACE_CARDS).index(:ace) &&
        first_value == 0

        values.delete(last_value)
        first_value = -1
        values.unshift(first_value)
        last_value = values.last
      end

      if (first_value..last_value).to_a == values
        return values.last
      end
    end

    def flush
      first_suit = @cards.first.suit
      if @cards.all? { |card| card.suit == first_suit }
        return @cards.last.value
      end
    end

    def full_house
      return three_of_a_kind if num_pairs && three_of_a_kind
    end

    def four_of_a_kind
      value_frequency = calculate_value_frequency
      value_frequency.select! { |key, value| value == 4 }

      if value_frequency.length == 1
        return value_frequency.keys.first
      end
    end

    def straight_flush
      return straight if straight && flush
    end
end