# textula
Text-based adventure game engine played in the terminal and written in Ruby.

## Project Vision

This will be a command-line CRUD app written in Ruby that allows users to
generate their own text-based adventure games.

## Dependencies

The only dependency will be the Ruby gem Sqlite3.

### Short-term Vision
Users will be able to add/edit/delete game rooms and add objects and
exits. Players should be able to move between rooms and execute basic
actions, like look, touch, listen, etc. As they make the game, they can take a trial run to see
how it plays. Once finished, they can play the whole game and save their
progress as they go.


### Long-term Vision

Users will be able to add/edit/delete game rooms, objects, players,
and associated objects (contained objects, exits, verbs, games). They should be able to interact with the objects in the game, such as adding the object to the player's inventory or moving objects from room to room. Objects should be allowed to contain other objects. Battles against game characters should also be possible. As they make the game, they can take a trial run to see
how it plays. Once finished, they can play the whole game and save their
progress as they go.

## File Structure

    |--app
    |  |--controllers
    |  |--models
    |
    |--Gemfile
    |--Gemfile.lock
    |--textula.rb
    |--README.md
    |
    |--test
       |--controllers
       |--integration
       |--models
       |--test_helper.rb


## Features

The game will allow users to:

* add/edit/delete game objects, players, rooms, and associated objects.
* play game as they build it
* play the entire game once they are done
* save their progress as they play and come back to it
  later

### Adding Game Information

The app should start by asking the user whether they want to create a
new game or open an existing game. They should be able to see a list of
existing games to choose from.

If they choose to create a new game, they are taken through a series of
predetermined steps to set up the game, getting input such the game's
name and description. After creating the game, they then are
given the choice to add objects, players, and scenarios. The engine will
loop through a set of predetermined questions to gather input from the
user for each of these items and determine their relationships to
existing items. The user can add an infinite number of
these items to make the game as simple or complex as they wish.

If they choose to open an existing game, the engine will recall that
game's information from a database and allow the user to continue adding
items to the game from where they left off.

### Playing the Game

The engine will allow the user to play the game at any point in the
development process.

### Usage Example

    > ./game start
    1. Welcome to the Ruby Game Engine!
    2. What would you like to do? (create new / open existing game)
    > create new
    1. What would you like to call your game?
    > Nashville Adventure
    1. What is your game about?
    > Text-based advanture set in Nashville.
    1. Your game, Nashville Adventure, has been created!

### Acceptance Criteria

* Program creates new games
* Players can move between rooms and have their location updated
* Players can interact with the game environment in simple ways
* Program allows users to dynamically add new objects, rooms,
  players to the game
* Program allows users to play the game at any point in the development
  process
* Program tracks player usage as the game is played, alowing the player
  to quit and return to a particular part of the game later
