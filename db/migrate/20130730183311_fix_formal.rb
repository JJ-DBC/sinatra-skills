class FixFormal < ActiveRecord::Migration
  def change
    change_table :proficiencies do |t|
      t.rename :formal?, :formal
    end
  end
end
