require 'rails_helper'

describe "validations" do
    it "Username should be present" do
        user = User.new(user: '', password: 'pass')
        user.valid?
        expect(user.errors.size).to eq 4
    end

    it "Username should be unique" do
        user = User.new(user: 'jon', password: 'pass')
        user.save
        user_2 = User.new(user: 'jon', password: 'pass')
        user_2.valid?
        expect(user_2.errors.size).to eq 1
    end
end