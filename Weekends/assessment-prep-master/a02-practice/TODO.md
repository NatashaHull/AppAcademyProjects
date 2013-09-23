## Problems with my rspec for Blackjack
* return_cards double expected all the cards to be returned together
  * they returned one at a time, but got bad error message
  * they also often expected return to remove cards from passed in array
  * no test for points with busted hand
* order of deck still expressed in points methods
* Hand gets injected to dealer, but they reference it through ivar in
  pay bets tests.
* Hand#points should have been class method for easier testing.
