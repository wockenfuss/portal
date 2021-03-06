class QuizzesController < ApplicationController
	before_filter :store_location
	before_filter :authenticate_user!
	before_filter :parse_quiz_params, :only => [:create, :update]
	before_filter :check_for_cancel, :only => [:create, :update]


	load_and_authorize_resource
	respond_to :html, :json, :js

	def index
		@quizzes = Quiz.order("release_date ASC")
		@quiz = Quiz.new
		respond_with do |format|
			format.html { render 'shared/manage',
						  										:locals => {
		  														:resource_name => "quiz",
		  														:resources => @quizzes
		  														} }
		end
	end

	def new
		@quiz = Quiz.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@quiz = Quiz.new(params[:quiz])
		if @quiz.save
			@quizzes = Quiz.order('release_date, created_at')
			respond_with @quizzes
		else
			js_alert(@quiz)
		end
	end

	def show
		@quiz = Quiz.find(params[:id])
	end

	def edit
		@quiz = Quiz.find(params[:id])
		@questions = @quiz.questions
		respond_to do |format|
      format.html
      format.js { render 'edit.js.erb', :locals => { :data => params[:data] } }
    end
	end

	def update
		@quiz = Quiz.find(params[:id])
		if @quiz.update_attributes(params[:quiz])
			flash[:notice] = "Quiz successfully updated"
			js_redirect_to(quizzes_path)
		else
			js_alert(@quiz)
		end
	end

	def destroy
		@quiz = Quiz.find(params[:id])
		@quiz.destroy
		@quizzes = Quiz.order('release_date, created_at')
		respond_with @quizzes
	end

	private

  def parse_quiz_params
  	parse_dates(params[:quiz])
  end

	def check_for_cancel
		if params[:commit] == 'Cancel'
			flash[:alert] = "Canceled"
	 		js_redirect_to quizzes_path
		end
	end

end
