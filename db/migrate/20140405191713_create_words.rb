class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :citation
      t.string :pos
      t.string :eng
      t.text :forms

      t.timestamps
    end
    
    create_table :words_keys do |t|
          t.belongs_to :word
          t.belongs_to :key
    end
  end
end
