# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  context 'Columns Exists' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
  end

  describe 'Columns Valid check' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should_not allow_values('test').for(:email) }
    it { should_not allow_values('test@test').for(:email) }
    it { should validate_length_of(:password).is_at_least(6).with_message(/is too short/) }
    it { should have_many(:file_lists) }
  end

  it 'is not valid with password less than 6 characters' do
    user = User.new(email: 'test3@test.com', password: 'test', password_confirmation: 'test')
    expect(user).to_not be_valid
  end

  it 'is not valid with password and confirmation is different' do
    user = User.new(email: 'test3@test.com', password: 'test1234', password_confirmation: 'test')
    expect(user).to_not be_valid
  end

  it 'is valid with password more than 6 characters and same password and confirmation' do
    user = User.new(email: 'test3@test.com', password: 'test1234', password_confirmation: 'test1234')
    expect(user).to be_valid
  end
end
