A checkers AI program.

### Current Status

The Engine module is a human-vs-human CLI program. Users input their moves in 
[standard notation](http://en.wikipedia.org/wiki/English_draughts#Notation).

The AI module contains a machine learning bot that does Bayes classification to 
determine how likely a move is to be legal in the current board. It is possible 
to test the bot directly in an irb-like session (which uses pry) or to start 
a game between 2 bots.

### Setup

1. Copy data/draughts.db.example to data/draughts.db
2. Copy config/bots.rb.exmample to config/bots.rb

### Testing the training bot

Simply give bin/draughts-testbot execution permissions (`chmod +x bin/testbot`) 
and run it.

Once inside the pry session, instantiate a bot with a board configuration:

```ruby
# Board configurations follow checkers' standard notation. There are a few 
# samples in examples/configurations.txt
bot = Draughts::AI::TrainingBot.new("bbbbbbbbbbbb        wwwwwwwwwwww")
```

You can ask him for the probability of a move of your chosing of being legal:

```ruby
move = Draughts::AI::Move.first :origin => 9, :destination => 14
bot.probability_of move # => Float number, like 0.801234532
```
 
Or ask him to find the most likely move:

```ruby
puts bot.play # => A Draughts::AI::Move object, which prints as (origin, destination)
```

Once he has chosen his move, teach him whether he was right or wrong:

```ruby
# If the move was legal:
bot.learn true
# If it wasn't:
bot.learn false
```

This updates the training data so that the bot can make more informed guesses 
in the future.

### Starting a game between 2 bots

Give bin/draughts-trainer execution permissions (`chmod +x bin/trainer`) and 
run it.  The game between the 2 bots will be narrated to you. Watch them FIGHT 
TO THE DEATH!

There's a couple of switches you can use:

* If you want to take your time to read what the program is printing, pass the 
  `-p` switch. This requires you to type Enter after everything that's printed 
before continuing.

* If you don't want any output whatsoever (maybe you want to keep the program 
  running to build your database), pass the `-q` switch.

* If you want to save the output to review it later, use the `--output=FILE` 
  switch.
