# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  username               :string(255)
#  address                :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  country                :string(255)
#  postal_code            :string(255)
#  phone_number           :string(255)
#  email                  :string(255)      default(""), not null
#  password_salt          :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  provider               :string(255)
#  uid                    :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  image_url              :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
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
    # it { expect(bodybuilder).to validate_presence_of(:food)
    # .with_message(/you can't get big without your protein!/) }
    it { expect(@user).to validate_presence_of(:username) }
    # it { expect(meal).to validate_numericality_of(:price) }
    # it { expect(tumblog).to validate_numericality_of(:follower_count)
    # .only_integer }
    # it { expect(odd_number).to validate_numericality_of(:value).odd }
    # it { expect(even_number).to validate_numericality_of(:value).even }
    # it { expect(mercedes).to validate_numericality_of(:price)
    # .is_greater_than(30000) }
    # it { expect(junked_car).to validate_numericality_of(:price)
    # .is_less_than_or_equal_to(500) }
    it { expect(@user).to validate_uniqueness_of(:username) }
    # it { expect(wishlist).to validate_uniqueness_of(:product)
    # .scoped_to(:user_id, :wishlist_id)
    # .with_message("You can only have an item on your wishlist once.") }

    # # Format validations
    # it { expect(user).to allow_value("JSON Vorhees").for(:name) }
    # it { expect(user).to_not allow_value("Java")
    # .for(:favorite_programming_language) }
    it { expect(@user).to allow_value('dhh@nonopinionated.com').for(:email) }
    it { expect(@user).to_not allow_value('base@example').for(:email) }
    it { expect(@user).to_not allow_value('blah').for(:email) }
    # it { expect(blog).to allow_blank(:connect_to_facebook) }
    # it { expect(blog).to allow_nil(:connect_to_facebook) }

    # # Inclusion/acceptance of values
    # it { expect(tumblog).to ensure_inclusion_of(:status)
    # .in_array(['draft', 'public', 'queue']) }
    # it { expect(tng_group).to ensure_inclusion_of(:age).in_range(18..35) }
    # it { expect(band).to ensure_length_of(:bio)
    # .is_at_least(25).is_at_most(1000) }
    # it { expect(tweet).to ensure_length_of(:content).is_at_most(140) }
    # it { expect(applicant).to ensure_length_of(:ssn).is_equal_to(9) }
    # For boolean values
    # it { expect(contract).to validate_acceptance_of(:terms) }

    # Ensure two values match
    it { expect(@user).to validate_confirmation_of(:password) }
  end
end
