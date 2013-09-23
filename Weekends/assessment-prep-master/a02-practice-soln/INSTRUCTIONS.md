# Assessment 02: Blackjack

**Time: 1hrs**

In this assessment, we'll build a blackjack game.

## Rules

You may review the rules of blackjack on
[Wikipedia][wiki-blackjack]. The ones we care about:

* Players play against the dealer; multiple players can win each round.
* Players win if they don't "bust" and either:
    1. their hand is worth more points than the dealer's hand.
    2. the dealer busts.
* To compute a hand's value, add the value of each numbered card, and ten for
  face cards. An ace is worth 11 if the total score would be <= 21. If an ace
  value of 11 would result in a bust, it is worth 1.
* A score of >21 is a bust.
* Players are first dealt two cards; they can request additional cards
  ("hit") until they pass ("stay") or bust.
* The dealer must hit on a hand worth <17, otherwise he must stay.
* **HINT**: cards should be taken from the top of the deck.

[wiki-blackjack]: http://en.wikipedia.org/wiki/Blackjack

## Classes

I've written a `Card` class for you already. You must implement the following
further classes:

* A Deck class that holds the cards and shuffles them.
* A Hand class that holds a hand's worth of cards, computes the worth of a
  hand, tells if it is busted.
* A Player class to represent the players at the table; a HumanPlayer
  subclass is how your user will interact with the game.
* A Dealer subclass of Player that plays the dealer's hand, tracks and pays
  bets.
* A Game class, which will keep track of the deck, players, and dealer, and
  has a single public method, `#play_round`.

## Specs

You should first write `Deck`, then `Hand`, `Player`, and `Dealer`. To run
the specs for a single class, use

    `rake spec spec/deck_spec.rb`
    `rake spec spec/hand_spec.rb`
    `rake spec spec/player_spec.rb`
    `rake spec spec/dealer_spec.rb`

To run all the specs, you may type simply `rake`.

## Other

Please ask if you get stuck. We want this to be an accurate measure of what
you know about OO, so if you're stuck on something small, please ask.
