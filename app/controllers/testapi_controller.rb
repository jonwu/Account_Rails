class TestapiController < ApplicationController
	def resetFixture
		User.TESTAPI_resetFixture
		render :json => { :errCode => User::SUCCESS}
	end

	def unitTests
		value = `rspec`
		array = value.split(' ')
		hash = Hash[array.map.with_index.to_a] 
		example_index = hash['examples,'] - 1
		failures_index = hash['failures'] - 1

		totalTests = (array[example_index]).	to_i 
		nrFailed = (array[failures_index]).to_i

		render :json  => {:nrFailed => nrFailed, :output =>value, :totalTests =>totalTests}
	end
end
