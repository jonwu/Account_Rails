class TestapiController < ApplicationController
	def resetFixture
		User.TESTAPI_resetFixture
		render :json => { :message => "database reset successful"}
	end

	def unitTests
		value = `rspec`
		render :json  => value
	end
end
