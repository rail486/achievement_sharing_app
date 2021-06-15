class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :user_id
      t.date :date
      t.string :content
      t.integer :achievement
      t.boolean :share

      t.timestamps
    end
  end
end
