class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :quiz_taker
      # can [:read, :update], Attempt, :user_id => user.id
    else
      can :read, User
      cannot :read, User do |this_user|
        this_user.id != user.id
      end
      can :read, Gradebook, :user => { :id => user.id }
      can :create, Attempt, :user_id => user.id, :released? => true, :attempted? => false

    end
  end
end
