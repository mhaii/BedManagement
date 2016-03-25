require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:ward) { Ward.create({name: 'WardName'}) }

  it 'must not allow record without necessary attribute' do
    expect(Room.create.valid?).to be_falsey
    expect(Room.create({number: '101'}).valid?).to be_falsey
    expect(Room.create({ward: ward}).valid?).to be_falsey
    expect(Room.create({number: '101', ward: ward}).valid?).to be_truthy
  end
end
