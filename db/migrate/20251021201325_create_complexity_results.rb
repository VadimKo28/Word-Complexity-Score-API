class CreateComplexityResults < ActiveRecord::Migration[8.0]
  def change
    create_table :complexity_results do |t|
      t.string :job_id, null: false
      t.string :status, null: false
      t.json :result
      t.timestamps
    end
  end
end
