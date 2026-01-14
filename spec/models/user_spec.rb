require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(
      first_name: "marco",
      last_name: "garbini",
      email: "marco@example.com",
      password: "1234567"
    )
  end

  context "validaciones" do
    it "es válido con todos los atributos correctos" do
      expect(@user).to be_valid
    end

    it "no es válido sin first_name" do
      @user.first_name = nil
      expect(@user).not_to be_valid
      @user.first_name = "Marco" # reset
    end

    it "no es válido sin last_name" do
      @user.last_name = nil
      expect(@user).not_to be_valid
      @user.last_name = "Garbini" # reset
    end

    it "no es válido sin email" do
      @user.email = nil
      expect(@user).not_to be_valid
      @user.email = "test@example.com" # reset
    end

    it "no es válido con email duplicado" do
      duplicate_user = User.new(
        first_name: "Marco",
        last_name: "Garbini",
        email: @user.email,
        password: "1234567"
      )
      expect(duplicate_user).not_to be_valid
    end

    it "no es válido sin password al crear" do
      user = User.new(
        first_name: "Test",
        last_name: "User",
        email: "new@example.com"
      )
      expect(user).not_to be_valid
    end

    it "es válido si password es nil al actualizar" do
      @user.password = nil
      expect(@user).to be_valid
    end
  end

  context "asociaciones" do
    it "tiene muchos fermentos" do
      assoc = described_class.reflect_on_association(:ferments)
      expect(assoc.macro).to eq(:has_many)
    end

    it "tiene muchos comentarios" do
      assoc = described_class.reflect_on_association(:comments)
      expect(assoc.macro).to eq(:has_many)
    end

    it "puede tener una foto adjunta" do
      expect(@user.respond_to?(:photo)).to be(true)
    end
  end

  context "métodos" do
    it "full_name devuelve el nombre completo capitalizado" do
      expect(@user.full_name).to eq("Marco Garbini")
    end
  end
end
