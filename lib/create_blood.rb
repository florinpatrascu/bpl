require 'active_record'

class CreateBlood < ActiveRecord::Migration
  def self.up
    create_table :blood_pressures do |t|
      t.column :sys,    :integer
      t.column :dia,    :integer
      t.column :hr,     :integer
      t.column :arm,    :string
      t.column :weight, :integer
      t.column :notes,  :text      
      t.timestamps      
    end
    add_index :blood_pressures, [:created_at]
  end

  def self.down
    drop_table :blood_pressures
  end
end

# other methods: 
# def init_db
#   ActiveRecord::Schema.define do 
#     .....
#   end
# end
