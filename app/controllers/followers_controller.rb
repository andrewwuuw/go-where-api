class FollowersController < ApplicationController
  before_action :authorize

  def apply
    user = User.includes(:profile).find(params[:user_id])
    if user.is_public
      current_user.users_follower.create(follower_id: params[:user_id])
      json_response({message: 'Follow success.'})
    else
      current_user.users_apply_for_follower.create(apply_id: params[:user_id])
      json_response({message: 'Apply for follow success.'})
    end
  end

  def applicant
    json_response({
      my_apply: current_user.users_apply_for_follower.map{|val| val.apply_id},
      apply_me: current_user.applicants_apply_for_follower.map{|val| val.user_id}
    })
  end

  def index
    json_response({
      my_follow: current_user.users_follower.map{|val| val.follower_id},
      follow_me: current_user.followers_follower.map{|val| val.user_id}
    })
  end

  def create
    return status_422(nil, [message: 'Miss params: all or applicants.']) unless params['all'] || params['applicants']
    if params['all'] && params['all'] === true
      current_user.applicants_apply_for_follower.map{ |applicant|
        current_user.users_follower.create(follower_id: applicant.id)
        applicant.destroy
      }
      return json_response({message: "Add all success."})
    end
    
    applicants = params['applicants'].map{|applicant| applicant.to_i}
    applicants.each{ |applicant|
      current_user.users_follower.create(follower_id: applicant)
    }
    current_user.applicants_apply_for_follower.where("user_id in (?)", applicants).destroy_all
    return json_response({message: "Agree friend success.", agree_list: applicants})
  end

  def destroy
    user = current_user.users_follower.find_by(follower_id: params[:id])
    user.destroy
    return json_response({message: "Remove Follow Success."}) 
  end
end
