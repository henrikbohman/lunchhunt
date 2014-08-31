class ScoreShouldHaveInitialValue < ActiveRecord::Migration
  def change
  	change_column_default :restaurants, :score, 1
  end
end
