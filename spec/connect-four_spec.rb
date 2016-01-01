require_relative '../lib/connect-four.rb'

describe Grid do
  before { @grid = Grid.new }

  context '#initalize' do
    it 'initializes a grid instance' do
      expect(@grid).to be_an_instance_of Grid
    end

    it 'initializes with a 7-by-6 array' do
      expect(@grid.cells.size).to eq(7)
      expect(@grid.cells).to all(be == [0,0,0, 0,0,0])
    end
  end

  context '#update' do
    before do
      @grid.cells[0] = [1,0,0,0,0,0]
      @grid.cells[1] = [1,1,2,2,1,1]
    end
    
    it 'appends input value to the first 0 element in the column array' do
      @grid.update(1,0)
      expect(@grid.cells[0]).to eq([1,1,0,0,0,0])
    end

    it 'will not append input value to 0-less columns' do
      expect(@grid.update(1,1)).to be_nil
    end
  end
end

describe Player do
  before {@player = Player.new('player1',1)}

  context '#initialize' do
    it 'initializes a Player instance' do
      expect(@player).to be_an_instance_of Player
    end

    it 'initializes with the input name and identity' do
      expect(@player.name).to eq('player1')
      expect(@player.id).to eq(1)
    end
  end

  context '#win?' do
    before do
      # inner arrays are columns in the game grid
      @cells_0 = [[ 1 , 2 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ]]

      @cells_h = [[ 1 , 2 , 0 , 0 , 0 , 0 ],
                  [ 1 , 2 , 0 , 0 , 0 , 0 ],
                  [ 1 , 2 , 0 , 0 , 0 , 0 ],
                  [ 1 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ]]

      @cells_v = [[ 1 , 1 , 1 , 1 , 0 , 0 ],
                  [ 2 , 0 , 0 , 0 , 0 , 0 ],
                  [ 2 , 0 , 0 , 0 , 0 , 0 ],
                  [ 2 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ],
                  [ 0 , 0 , 0 , 0 , 0 , 0 ]]

      @cells_dp = [[ 1 , 2 , 0 , 0 , 0 , 0 ],
                   [ 2 , 1 , 0 , 0 , 0 , 0 ],
                   [ 2 , 1 , 1 , 0 , 0 , 0 ],
                   [ 2 , 2 , 1 , 1 , 0 , 0 ],
                   [ 0 , 0 , 0 , 0 , 0 , 0 ],
                   [ 0 , 0 , 0 , 0 , 0 , 0 ],
                   [ 0 , 0 , 0 , 0 , 0 , 0 ]]

      @cells_dn = [[ 2 , 1 , 2 , 1 , 0 , 0 ],
                   [ 2 , 1 , 1 , 0 , 0 , 0 ],
                   [ 2 , 1 , 0 , 0 , 0 , 0 ],
                   [ 1 , 2 , 0 , 0 , 0 , 0 ],
                   [ 0 , 0 , 0 , 0 , 0 , 0 ],
                   [ 0 , 0 , 0 , 0 , 0 , 0 ],
                   [ 0 , 0 , 0 , 0 , 0 , 0 ]]
    end

    it 'finds no wins' do
      expect(@player.win?(@cells_0)).not_to be
    end

    it 'finds horizontal wins' do
      expect(@player.win?(@cells_h)).to be
    end

    it 'finds vertical wins' do
      expect(@player.win?(@cells_v)).to be
    end

    it 'finds diagonal wins (positive slope)' do
      expect(@player.win?(@cells_dp)).to be
    end

    it 'finds diagonal wins (negative slope)' do
      expect(@player.win?(@cells_dn)).to be
    end
  end
end