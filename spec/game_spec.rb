require 'game'

describe 'Game' do
  let(:real_player) { double(:player) }
  let(:computer_player) { double(:computer_player) }
  let(:winner_calculator) { double(:winner_calculator) }
  let(:game) { Game.new(real_player, computer_player, winner_calculator) }

  describe '.instance' do
    it 'returns a Game' do
      Game.create(real_player, computer_player)
      expect(Game.instance).to be_a(Game)
    end

    it 'returns the same Game each time' do
      Game.create(real_player, computer_player)
      expect(Game.instance).to be(Game.instance)
    end
  end

  describe '#play' do
    context 'when real player vs computer' do
      context 'when real player wins' do
        it 'sets the move for the real player' do
          allow(winner_calculator).to receive(:calculate).with(real_player, computer_player)
          expect(real_player).to receive(:move=).with(:rock)
          game.play('rock')
        end
        it 'calls calculate on winner_calculator with the two players' do
          expect(winner_calculator).to receive(:calculate).with(real_player, computer_player)
          allow(real_player).to receive(:move=).with(:rock)
          game.play('rock')
        end
        it 'returns the result of winner_calculate.calculate' do
          allow(winner_calculator).to receive(:calculate).with(real_player, computer_player).and_return(real_player)
          allow(real_player).to receive(:move=).with(:rock)
          expect(game.play('rock')).to be real_player
        end
      end
    end
  end
end