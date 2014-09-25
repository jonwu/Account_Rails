class TestapiController < ApplicationController
	def resetFixture
		User.TESTAPI_resetFixture
	end
end
