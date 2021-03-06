class UsersController < ApplicationController

	before_filter :authenticate_user!
	load_and_authorize_resource

	respond_to :html, :js, :json
	
	def show
		@user = User.find(params[:id])
		# @units = Unit.current
		@lectures = Lecture.released
	end

	def index
		@user = current_user
		@users = User.all
	end

	def update
		current_user.remove_role :quiz_taker
		render :json => { :updated => true }
	end

end
