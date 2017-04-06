class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
     if @wiki.private
        @user.premium? || @user.admin?
     else
        @user.standard? || @user.premium? || @user.admin?
     end
   end

   def update?
     @user.present?
   end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
       if @user.admin?
         @scope.all
       elsif @user.standard?
         @scope.where(private: false)
       elsif @user.premium?
         wikis = []
         all_wikis = @scope.all
         all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == @user
            wikis << wiki
          end
         end
          wikis
        end
     end
  end
end
