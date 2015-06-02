class CreateDefaultCategories < ActiveRecord::Migration
  def change
    cs = ['All', 'Cameras', 'Lenses', 'Audio', 'External', 'Recorders', 'Tripods', 'Rigs & Stabilizers', 'Accessories']
    Category.delete_all
    cs.map{|c| Category.create(name: c)}
  end
end
