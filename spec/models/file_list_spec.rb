# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileList, type: :model do
  fixtures :users

  describe 'Columns Exists' do
    it { should have_db_column(:private).of_type(:boolean) }
    it { should have_one_attached(:file) }
    it { should belong_to(:user) }
  end

  describe 'Columns Valid check' do
    it { should validate_presence_of :file }
  end

  it 'is not valid without user and without image' do
    file_list = FileList.new(private: true)
    expect(file_list).to_not be_valid

    file_list = FileList.new(private: true, user: users(:one))
    expect(file_list).to_not be_valid
  end

  it 'is valid with user and image' do
    f = Rails.root.join('spec/fixtures/files/sample.jpg').open
    file_list = FileList.new(private: true, user: users(:one))
    file_list.file.attach(io: f, filename: File.basename(f), content_type: 'image/jpeg')
    expect(file_list).to be_valid
  end
end
