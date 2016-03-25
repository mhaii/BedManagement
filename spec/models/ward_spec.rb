require 'rails_helper'

RSpec.describe Ward, type: :model do
  let(:ward) { Ward.create({name: 'WardName'}) }

  it 'must not allow record without necessary attribute' do
    expect(Ward.create.valid?).to be_falsey
    expect(Ward.create({name: 'Name'}).valid?).to be_truthy
  end

  it 'must return rooms sorted by room number no matter the order of their ids' do
    Room.create({ward: ward, number: 215})
    Room.create({ward: ward, number: 207})
    Room.create({ward: ward, number: 222})
    Room.create({ward: ward, number: 201})

    rooms = ward.rooms.map &:number
    expect(rooms[0]).to eq '201'
    expect(rooms[1]).to eq '207'
    expect(rooms[2]).to eq '215'
    expect(rooms[3]).to eq '222'
  end
end
