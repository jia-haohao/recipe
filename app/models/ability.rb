# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.try(:admin?) 
      can :access, :rails_admin
      can :manage, :all
      # can [:create, :destroy], Favorite, cook_id: @cook.id
      # can [:create, :destroy], Relationship, follower_id: user.id
    #   can :create, Conversation, sender_id: user.id, recipient_id: user.id
    #   can :manage, Conversation, sender_id: user.id
    #   can :manage, Conversation, recipient_id: user.id
    #   can :create, Message do |message|
    #     conversation = message.conversation
    #     conversation.sender_id == user.id || conversation.recipient_id == user.id
    #   end
    # elsif user == User.guest
    #   can :read, :all
    #   cannot :create, Cook # 禁止创建 Cook 资源
    #   cannot :update, Cook # 禁止更新 Cook 资源
    #   cannot :destroy, Cook 
    else
      can :manage, :all
      cannot :access, :rails_admin
    end

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
