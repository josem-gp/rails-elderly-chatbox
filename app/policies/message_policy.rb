class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def create?
      record.user = user
    end
  end
end
