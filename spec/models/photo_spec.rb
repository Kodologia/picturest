require "rails_helper"

describe Photo do
  it 'has valid factory' do
    photo = build(:photo)
    expect(photo).to be_valid
  end

  it 'is invalid without title' do
    photo = build(:photo, title: '')
    expect(photo).to_not be_valid
  end

  it 'is invalid without description' do
    photo = build(:photo, description: '')
    expect(photo).to_not be_valid
  end

  it 'is invalid without user' do
    photo = build(:photo, user: nil)
    expect(photo).to_not be_valid
  end
end
