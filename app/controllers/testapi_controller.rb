class TestapiController < ApplicationController
	def resetFixture
		User.TESTAPI_resetFixture
	end

	def unitTests
		value = %x( rspec )
		render :json  => value
	end
end
