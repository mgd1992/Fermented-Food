require "rails_helper"
require "securerandom"

RSpec.describe Comment, type: :model do
  before(:each) do
    # Usuario único para cada test
    @user = User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "1234567",
      first_name: "Marco",
      last_name: "Gonzalez"
    )

    # Fermento asociado al usuario
    @ferment = Ferment.create!(
      user: @user,
      name: "Kimchi",
      instructions: "Fermentar repollo",
      ingredients: "Repollo, sal",
      revisar_fermentos: 5,
      start_date: Date.today
    )
  end

  context "validaciones" do
    it "es válido con title y content" do
      comment = Comment.new(
        user: @user,
        ferment: @ferment,
        title: "Primer comentario",
        content: "Se ve que va bien"
      )
      expect(comment).to be_valid
    end

    it "no es válido sin title" do
      comment = Comment.new(
        user: @user,
        ferment: @ferment,
        content: "Falta título"
      )
      expect(comment).not_to be_valid
    end

    it "no es válido sin content" do
      comment = Comment.new(
        user: @user,
        ferment: @ferment,
        title: "Falta contenido"
      )
      expect(comment).not_to be_valid
    end
  end

  context "asociaciones" do
    it "pertenece a un usuario" do
      assoc = Comment.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it "pertenece a un ferment" do
      assoc = Comment.reflect_on_association(:ferment)
      expect(assoc.macro).to eq(:belongs_to)
    end
  end
end
