require "app/character.rb"
require "app/game_board.rb"

class Game
  def initialize(args)
    @args = args
    @character = Character.new(args)
  end

  def render
    @character.draw
  end

  def tick
    render
    @character.move
  end
end

def tick(args)
  args.state.game ||= Game.new(args)
  args.state.game.tick
end
