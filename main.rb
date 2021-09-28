require "app/character.rb"
require "app/game_board.rb"

class Game
  def initialize(args)
    @args = args
    @character = Character.new(args)
  end

  def render
    @character.tick
  end

  def tick
    render
  end
end

def tick(args)
  args.state.game ||= Game.new(args)
  args.state.game.tick
end
