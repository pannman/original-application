class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string "title"
      t.text "sentence"
      t.string "img"
      t.string "word"
    end
  end
end
