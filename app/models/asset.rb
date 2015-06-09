# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  attachable_id      :integer
#  attachable_type    :string
#  created_at         :datetime
#  updated_at         :datetime
#  unique_token       :string
#  is_main            :boolean          default(FALSE)
#

class Asset < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_attached_file :image, styles: {small: '100x100>', thumb: '133x133', large: '690x300#'}
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png']
end
