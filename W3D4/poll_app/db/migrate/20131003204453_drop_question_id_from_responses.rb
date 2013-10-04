class DropQuestionIdFromResponses < ActiveRecord::Migration
  def up
    remove_column :responses, :question_id
  end

  def down
    add_column :responses, :question_id, :integer
  end
end
