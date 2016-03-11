require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  before do
    @json_string = '{ "username": "tester", "password": "yui" }'
  end

  it 'be able to create new user' do
    post :create, @json_string, { format: 'json' }

    json_response = JSON.parse(response.body)
    expect(json_response['status'].downcase).to eq 'success'
  end

  it 'will not create user with identical username' do
    post :create, @json_string, { format: 'json' }
    post :create, @json_string, { format: 'json' }

    json_response = JSON.parse(response.body)
    expect(json_response['username'][0].downcase).to eq 'has already been taken'
  end
end
