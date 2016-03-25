require 'rails_helper'

RSpec.describe CheckOutStep, type: :model do
  let(:admit) { Admit.create({ status: :preDischarged }) }

  it 'must not allow record without necessary attribute' do
    expect(CheckOutStep.create.valid?).to be_falsey
    expect(CheckOutStep.create({step: 0}).valid?).to be_falsey
    expect(CheckOutStep.create({admit: admit}).valid?).to be_falsey
    expect(CheckOutStep.create({step: 0, admit: admit}).valid?).to be_truthy
  end

  it 'must not create duplicate step for each admit' do
    expect(CheckOutStep.create({step: 0, admit: admit}).valid?).to be_truthy
    expect(CheckOutStep.create({step: 0, admit: admit}).valid?).to be_falsey
    expect(CheckOutStep.create({step: 1, admit: admit}).valid?).to be_truthy
    expect(CheckOutStep.create({step: 1, admit: admit}).valid?).to be_falsey
  end
end
