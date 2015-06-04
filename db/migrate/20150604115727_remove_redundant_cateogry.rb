class RemoveRedundantCateogry < ActiveRecord::Migration
  def change
    Category.where(name: 'All').first.destroy
  end
end
