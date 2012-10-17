class AddWaveformToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :waveform, :string

  end
end
