require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user  = User.create({ username: 'tester', password: 'testpass' })
  end

  it 'must store generated password digest instead of storing password' do
    user = User.find(@user.id)
    expect(user.password).to be_nil
    expect(user.password_digest).not_to be_nil
  end
end
