require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create({ username: 'tester', password: 'testpass' }) }

  it 'must store generated password digest instead of storing password' do
    newUser = User.find_by_id(user.id)
    expect(newUser.password).to be_nil
    expect(newUser.password_digest).not_to be_nil
  end

  it 'can compare string with digest value' do
    expect(BCrypt::Password.new(user.password_digest).is_password?('testpass')).to be_truthy
  end
end
