require 'rails_helper'

describe "validations" do
    it "Username should be present" do
        user = User.new(user: '', password: 'pass')
        user.valid?
        expect(user.errors.size).to eq 1
    end

    it "Username should be unique" do
        User.TESTAPI_resetFixture
        user = User.new(user: 'jon', password: 'pass')
        user.save
        user_2 = User.new(user: 'jon', password: 'pass')
        user_2.valid?
        expect(user_2.errors.size).to eq 1
    end

    it "Username should return nil if user and password don't match" do
        User.TESTAPI_resetFixture
        user = User.new(user: 'jon', password: 'pass')
        user.save
        username = User.login("jon", "wrongpass")
        expect(username).to eq nil
    end

    it "Password should be less than length MAX_PASSWORD_LENGTH" do
        user = User.new(user: 'user', password: '*'*129)
        user.save
        expect(user.errors.size).to eq 1
    end


    it "Username should be less than length MAX_USERNAME_LENGTH" do
        user = User.new(user: '*'*129, password: 'pass')
        user.save
        expect(user.errors.size).to eq 1
    end

    it "Password can be empty" do
        User.TESTAPI_resetFixture
        user = User.new(user: 'jon', password: '')
        user.save
        expect(user.errors.size).to eq 0
    end

    it "Proper sign up should add a user" do
        User.TESTAPI_resetFixture
        user = User.add("jon","pass")
        expect(User.all.length).to eq 1
    end

    it "Add should iterate count" do
        User.TESTAPI_resetFixture
        user = User.add("jon","pass")
        expect(user[:count]).to eq 1
    end

    it "Proper login should iterate count" do
        User.TESTAPI_resetFixture
        user = User.add("jon","pass")
        username = User.login("jon","pass")
        expect(username[:count]).to eq 2
    end

    it "TESTAPI_resetFixture should destroy all data" do
        user = User.new(user: 'jon', password: 'pass')
        user.save
        user = User.TESTAPI_resetFixture
        expect(User.all.length).to eq 0
    end

    it "Login fields should always return no match" do
        user = User.new(user: '', password: '')
        user.save
        username = User.login("","")
        expect(username).to eq nil
    end



end