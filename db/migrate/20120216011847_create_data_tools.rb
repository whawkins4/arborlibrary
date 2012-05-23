class CreateDataTools < ActiveRecord::Migration
  def change
    create_table :data_tools do |t|

      t.timestamps
    end
  end
end
