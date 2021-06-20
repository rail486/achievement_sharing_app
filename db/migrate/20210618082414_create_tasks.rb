class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.date :date
      t.string :content
      t.integer :achievement, default:0
      t.boolean :share
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
