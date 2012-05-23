class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :pub_name
      t.string :pub_place

      t.timestamps
    end
  end
end
