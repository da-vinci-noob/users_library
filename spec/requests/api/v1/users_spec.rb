require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  fixtures :all

  describe 'GET /check_user' do
    it 'checks for the if user is signed in' do
      get check_user_path
      expect(response.status).to eq 401
      expect(response.body).to eq({ error: 'You need to sign in or sign up before continuing.' }.to_json)

      sign_in users(:one)
      get check_user_path
      expect(response.status).to eq 200
      expect(response.body).to eq({ message: 'User Already logged in', email: users(:one).email }.to_json)
    end
  end

  describe 'POST /add_files, GET user_files, POST delete_file' do
    context 'tests for adding files' do
      let(:file) { fixture_file_upload('sample.jpg') }
      it 'without logged in user' do
        # ActiveStorage::Current.url_options = { host: 'http://localhost' }
        post add_files_path
        expect(response.status).to eq 401
        expect(response.body).to eq({ error: 'You need to sign in or sign up before continuing.' }.to_json)
      end

      it 'with logged in user with valid params upload 1 private and 1 public file then delete' do
        # Upload User files
        sign_in users(:one)
        post add_files_path, params: { file: [file, file], private: %w[false true] }
        expect(response.status).to eq 201
        expect(response.body).to eq({ message: 'Files Has been uploaded Successfully' }.to_json)

        # fetch user user files upload
        get user_files_path
        user_files = response.parsed_body['files']
        expect(user_files.count).to eq 2
        expect([user_files.first['private'], user_files.second['private']]).to eq %w[No Yes]

        # Delete one file and fetch files after delete
        post delete_file_path, params: { id: user_files.second['id'] }
        get user_files_path
        user_files = response.parsed_body['files']
        expect(user_files.count).to eq 1
        expect(user_files.first['private']).to eq 'No'

        # fetch second user files
        sign_in users(:two)
        get user_files_path
        user_files = response.parsed_body['files']
        expect(user_files.count).to eq 0

        # Show Public files of user
        get show_public_files_path
        public_user_files = response.parsed_body['files']
        expect(public_user_files.count).to eq 1

        # Copy Public File
        post copy_file_path, params: { id: public_user_files.first['id'] }
        get user_files_path
        user_files = response.parsed_body['files']
        expect(user_files.count).to eq 1
        expect(user_files.first['private']).to eq 'No'

        # Toggle public to Private file
        post toggle_private_file_path, params: { id: user_files.first['id'] }
        get user_files_path
        user_files = response.parsed_body['files']
        expect(user_files.first['private']).to eq 'Yes'
      end
    end
  end
end
