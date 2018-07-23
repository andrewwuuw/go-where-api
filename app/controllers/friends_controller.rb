class FriendsController < ApplicationController
  before_action :authorize

  def apply
    current_user.users_apply_for_friend.create(apply_id: params[:id])
    json_response({message: 'Apply for friend success.'})
  end

  def applicant
    json_response({
      my_apply: current_user.users_apply_for_friend.map{|val| val.apply_id},
      apply_me: current_user.applicants_apply_for_friend.map{|val| val.user_id}
    })
  end

  def index
    json_response({
      friends: current_user.users_friend
    })
  end

  def create
    return status_422(nil, [message: 'Miss params: all or applicants.']) unless params['all'] || params['applicants']
    if params['all'] && params['all'] === 'true'
      current_user.applicants_apply_for_friend.each{ |applicant|
        current_user.users_friend.create(friend_id: applicant.id)
        applicant.destroy
      }
      return json_response({message: "Add all success."})
    end

    applicants = params['applicants'].map{|applicant| applicant.to_i}
    applicants.each{ |applicant|
      current_user.users_friend.create(friend_id: applicant)
    }
    current_user.applicants_apply_for_friend.where("user_id in (?)", applicants).destroy_all
    return json_response({message: "Agree friend success.", agree_list: applicants})
  end

  def destroy
    current_user.users_friend.find_by(friend_id: (params[:user_id]) ? params[:user_id] : params[:id]).destroy
    json_response({message: "Delete success."})
  end
end
