class AddFabricationIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :fabrication_id, :integer
  end
end
