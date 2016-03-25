require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create({ username: 'tester', password: 'testpass' }) }

  it 'should display what is incorrect on incorrect login' do
    post :create, { sessions: { username: 'bob', password: 'yui' }}
    expect(flash[:danger]).to eq 'INCORRECT_USERNAME'

    post :create, { sessions: { username: 'tester', password: 'yui' }}
    expect(flash[:danger]).to eq 'INCORRECT_PASSWORD'
  end

  it 'should create user id in session on login' do
    post :create, { sessions: { username: 'tester', password: 'testpass' }}
    expect(session[:user_id]).not_to be_nil
  end

  it 'should clear user id in session on logout' do
    post    :create, { sessions: { username: 'tester', password: 'testpass' }}
    delete  :destroy
    expect(session[:user_id]).to be_nil
  end
end
