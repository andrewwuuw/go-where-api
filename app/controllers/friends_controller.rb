class FriendsController < ApplicationController
  before_action :authorize

  def apply
    if current_user.applicants_apply_for_friend.map{|val| val.user_id}.index(params[:user_id].to_i) 
      # 如果對方已經先申請好友的話，回傳「請確認好友申請」
      return json_response({message: "Please recheck friend application list."})
    end
    res = current_user.users_apply_for_friend.create(apply_id: params[:user_id])
    json_response({message: 'Apply for friend success.', id: res.id})
  end

  def applicant
    json_response({
      my_apply: current_user.users_apply_for_friend.map{|val| val.apply_id},
      apply_me: current_user.applicants_apply_for_friend.map{|val| val.user_id}
    })
  end

  def reject
    apply_form = ApplyForFriend.find(params[:id])
    unless [apply_form.user_id, apply_form.apply_id].index current_user.id
      return status_404(nil, {message: "This application doesn't exist."}) 
    end
    apply_form.destroy
    json_response({message: "Reject Apply Success."})
  end

  def index
    json_response({
      friends: current_user.users_friend
    })
  end

  def create
    return status_422(nil, [message: 'Miss params: all or applicants.']) unless params['all'] || params['applicants']
    if params['all'] && params['all'] === true
      current_user.applicants_apply_for_friend.map{ |applicant|
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
    friend = current_user.users_friend.find_by(friend_id: params[:id])
    return status_404(nil, {message: "Your friend doesn't exist."}) unless friend
    friend.destroy
    json_response({message: "Remove Friend Success."})
  end
end
