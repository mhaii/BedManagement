require 'rails_helper'

RSpec.describe Log, type: :model do
  before do
    @user  = User.create({ username: 'tester', password: 'testpass' })
  end

  it 'must not allow record without necessary attribute' do
  end
end
