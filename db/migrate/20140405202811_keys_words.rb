class KeysWords < ActiveRecord::Migration
  def change
    create_table :keys_words do |t|
          t.belongs_to :word
          t.belongs_to :key
    end
    drop_table :words_keys
    
  end
end
