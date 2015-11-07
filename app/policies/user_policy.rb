class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def permitted_attributes
    if user.has_role?(:admin) || record.id == user.id
      [:updated_at]
    end
  end

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def show?
    user.has_role?(:admin) or record.id == user.id
  end

  def edit?
    user.has_role?(:admin) or record.id == user.id
  end

  def update?
    user.has_role?(:admin) or record.id == user.id
  end

  class Scope
    def resolve
      if user.has_role?(:admin)
        scope.all
      else
        scope.where(id: record.id)
      end
    end
  end

end
