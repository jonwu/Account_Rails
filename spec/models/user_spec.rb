require 'rails_helper'

describe "validations" do
    it "Username and password should be present" do
        pass = User.new(user: '', password: 'pass')
        pass.valid?
        user = User.new(user: 'user', password: '')
        user.valid?
        both = User.new(user: '', password: '')
        both.valid?
        expect(user.errors.size + pass.errors.size + both.errors.size).to eq 4
    end

    it "Username should be unique" do
        user = User.new(user: 'jon', password: 'pass')
        user.save
        user_2 = User.new(user: 'jon', password: 'pass')
        user_2.valid?
        expect(user_2.errors.size).to eq 1
    end
end