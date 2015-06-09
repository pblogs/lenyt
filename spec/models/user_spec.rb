# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  username               :string
#  address                :string
#  city                   :string
#  state                  :string
#  country                :string
#  postal_code            :string
#  phone_number           :string
#  email                  :string           default(""), not null
#  password_salt          :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  provider               :string
#  uid                    :string
#  created_at             :datetime
#  updated_at             :datetime
#  image_url              :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  newsletter             :boolean          default(TRUE)
#  messages               :boolean          default(TRUE)
#

require "rails_helper"

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:factory_instance) { build(:user) }

  describe 'User Validations' do
    # http://guides.rubyonrails.org/active_record_validations.html
    # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/frames
    # http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/Shoulda/Matchers/ActiveModel
    before do
      @user = build(:user)
    end
    # Basic validations
    it { expect(@user).to validate_presence_of(:username) }
    it { expect(@user).to validate_uniqueness_of(:username) }
    # # Format validations
    it { expect(@user).to allow_value('dhh@nonopinionated.com').for(:email) }
    it { expect(@user).to_not allow_value('base@example').for(:email) }
    it { expect(@user).to_not allow_value('blah').for(:email) }
    # Ensure two values match
    it { expect(@user).to validate_confirmation_of(:password) }
  end
end
