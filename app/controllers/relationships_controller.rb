class RelationshipsController < ApplicationController

	def create
		@relationship = current_user.relationships.build(:friend_id => params[:friend_id])
		if @relationship.save
			flash[:notice] = "Followed successfully."
			redirect_to profile_path(current_user.id)
		else
			flash[:notice] = "Unable to follow."
			redirect_to root_path
		end
	end

	def destroy
		# Current user looks through relationships to find the friend id
		@relationship = current_user.relationships.find(params[:id])
		@relationship.destroy
		flash[:notice] = "No longer following this user."
		redirect_to profile_path(current_user.id)
	end

	private

	def relationship_params
		# Params require in relationship to permit only user id and friend id
		params.require(:relationship).permit(:user_id, :friend_id)
	end

end
