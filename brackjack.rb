require_relative 'card'
require_relative 'deck'

class Blackjack
  def hand_value(hand)
    base_value = hand.map(&:value).reduce(:+)
    num_aces = hand.count { |card| card.rank == 'A' }
    num_aces.times do
      base_value -= 10 if base_value > 21
    end
    base_value
  end

  def display_card(card, owner)
    puts "#{owner}の引いたカードは#{card.suit}の#{card.rank}です。"
  end

  def play
    puts 'ブラックジャックを開始します。'

    deck = Deck.new
    player_hand = [deck.draw, deck.draw]
    dealer_hand = [deck.draw, deck.draw]

    display_card(player_hand[0], 'あなた')
    display_card(player_hand[1], 'あなた')
    display_card(dealer_hand[0], 'ディーラー')

    puts 'ディーラーの引いた2枚目のカードはわかりません。'
    puts "あなたの現在の得点は#{hand_value(player_hand)}です。カードを引きますか？（Y/N）"

    while hand_value(player_hand) < 21
      input = gets.chomp.upcase
      break if input == 'N'

      unless %w[Y N].include?(input)
        puts 'エラー: 正しく入力してください。'
        next
      end

      new_card = deck.draw
      player_hand << new_card
      display_card(new_card, 'あなた')
      puts "あなたの現在の得点は#{hand_value(player_hand)}です。カードを引きますか？（Y/N）" unless hand_value(player_hand) >= 21

    end

    puts "ディーラーの引いた2枚目のカードは#{dealer_hand[1].suit}の#{dealer_hand[1].rank}でした。"

    while hand_value(dealer_hand) < 17
      new_card = deck.draw
      dealer_hand << new_card
      display_card(new_card, 'ディーラー')
      break if hand_value(dealer_hand) > 17

      puts "ディーラーの現在の得点は#{hand_value(dealer_hand)}です。"
    end

    puts "あなたの得点は#{hand_value(player_hand)}です。"
    puts "ディーラーの得点は#{hand_value(dealer_hand)}です。"

    if hand_value(player_hand) > 21
      puts 'あなたの負けです！'
    elsif hand_value(dealer_hand) > 21 || hand_value(player_hand) > hand_value(dealer_hand)
      puts 'あなたの勝ちです！'
    elsif hand_value(player_hand) == hand_value(dealer_hand)
      puts '引き分けです！'
    else
      puts 'あなたの負けです！'
    end

    puts 'ブラックジャックを終了します。'
  end
end

Blackjack.new.play


