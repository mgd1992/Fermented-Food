class FermentPolicy < ApplicationPolicy
  def show?    = true
  def new?     = true
  def create?  = true
  def edit?    = owner?
  def update?  = owner?
  def destroy? = owner?
  def destroy_photo? = owner?
  def restart? = owner?

  private

  def owner?
    record.user == user
  end
end
