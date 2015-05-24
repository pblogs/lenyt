# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  attachable_id      :integer
#  attachable_type    :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Asset < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_attached_file :image, styles: {small: '100x100>'}
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png']

end
