require 'rails_helper'

RSpec.describe Admit, type: :model do
  before do
    @room  = Room.find_or_create_by({ number: '1412' })
    @patient = Patient.find_or_create_by({ hn: 1111, first_name: 'first', last_name: 'last'})
  end

  it 'should occupy the room when patient is placed in' do
    admit = Admit.create({ patient: @patient })
    admit.update({ status: :currentlyAdmit, room: @room })

    expect(admit.room).to eq @room
    expect(admit.status).to eq 'currentlyAdmit'
    expect(@room.status).to eq 'occupied'
  end

  it 'should vacant the room when the patient is discharged' do
    admit = Admit.create({ status: :preDischarged, patient: @patient, room: @room })
    admit.discharged!
    @room.reload

    expect(admit.room).to be_nil
    expect(admit.status).to eq 'discharged'
    expect(@room.status). to eq 'available'
  end

  it 'should set status of both rooms when switching between rooms' do
    room  = Room.find_or_create_by({ number: '3412' })
    admit = Admit.create({ status: :currentlyAdmit, patient: @patient, room: @room })
    admit.update room: room

    @room.reload

    expect(admit.room).to eq room
    expect(room.status).to eq 'occupied'
    expect(@room.status).to eq 'available'
  end

  it 'should set room status to available-soon on pre-discharge' do
    admit = Admit.create({ status: :currentlyAdmit, patient: @patient, room: @room })
    admit.preDischarged!

    expect(admit.room).not_to be_nil
    expect(admit.status).to eq 'preDischarged'
    expect(admit.room.status). to eq 'availableSoon'
  end


end