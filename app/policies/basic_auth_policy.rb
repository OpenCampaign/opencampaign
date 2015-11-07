class BasicAuthPolicy < ApplicationPolicy
  attr_reader :user, :basic_auth

  def permitted_attributes
    if user.has_role?(:admin) || basic_auth.email == user.email
      [:password, :password_confirmation, :email]
    elsif basic_auth.email == user.email
      [:password, :password_confirmation]
    end
  end

  def initialize(user, basic_auth)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @basic_auth = basic_auth
  end

  def edit?
    user.has_role?(:admin) or basic_auth.email == user.email
  end

  def update?
    user.has_role?(:admin) or basic_auth.email == user.email
  end

  class Scope
    def resolve
      if user.has_role?(:admin)
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

end
