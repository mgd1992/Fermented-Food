# == Schema Information
#
# Table name: ferments
#
#  id                   :bigint           not null, primary key
#  description          :text
#  fermentation_time    :string
#  ingredients          :text
#  instructions         :text
#  name                 :string
#  review_date          :date
#  review_reminder_sent :boolean          default(FALSE), not null
#  revisar_fermentos    :integer
#  share_token          :string
#  start_date           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_ferments_on_share_token  (share_token) UNIQUE
#  index_ferments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"
require "securerandom"

RSpec.describe Ferment, type: :model do
  before(:each) do
    @user = User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "1234567",
      first_name: "Marco",
      last_name: "Gonzalez"
    )
  end

  context "validaciones" do
    it "es válido con todos los atributos correctos" do
      ferment = Ferment.new(
        user: @user,
        name: "Kimchi",
        description: "Un fermento coreano picante",
        instructions: "Mezclar miel y agua",
        ingredients: "Miel, agua",
        revisar_fermentos: 7,
        start_date: Time.zone.today
      )
      expect(ferment).to be_valid
    end

    it "no es válido sin nombre" do
      ferment = Ferment.new(
        user: @user,
        instructions: "Fermentar",
        ingredients: "Repollo",
        revisar_fermentos: 7,
        start_date: Time.zone.today
      )
      expect(ferment).not_to be_valid
    end

    it "no es válido sin instrucciones" do
      ferment = Ferment.new(
        user: @user,
        name: "Sauerkraut",
        ingredients: "Repollo",
        revisar_fermentos: 7,
        start_date: Time.zone.today
      )
      expect(ferment).not_to be_valid
    end

    it "no es válido sin ingredientes" do
      ferment = Ferment.new(
        user: @user,
        name: "Kimchi",
        instructions: "Fermentar",
        revisar_fermentos: 7,
        start_date: Time.zone.today
      )
      expect(ferment).not_to be_valid
    end

    it "no es válido sin usuario" do
      ferment = Ferment.new(
        name: "Kimchi",
        instructions: "Fermentar",
        ingredients: "Repollo",
        revisar_fermentos: 7,
        start_date: Time.zone.today
      )
      expect(ferment).not_to be_valid
    end

    it "no es válido con revisar_fermentos <= 0" do
      ferment = Ferment.new(
        user: @user,
        name: "Kimchi",
        instructions: "Fermentar",
        ingredients: "Repollo",
        revisar_fermentos: 0,
        start_date: Time.zone.today
      )
      expect(ferment).not_to be_valid
    end
  end

  context "asociaciones" do
    it "pertenece a un usuario" do
      assoc = Ferment.reflect_on_association(:user)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it "puede tener muchos comentarios" do
      assoc = Ferment.reflect_on_association(:comments)
      expect(assoc.macro).to eq(:has_many)
    end

    it "puede tener muchas fotos adjuntas" do
      expect(Ferment.new.respond_to?(:photos)).to be(true)
    end
  end

  context "métodos" do
    it "calcula review_date correctamente" do
      ferment = Ferment.create!(
        user: @user,
        name: "Kimchi",
        description: "Un fermento coreano picante",
        instructions: "Fermentar",
        ingredients: "Repollo",
        revisar_fermentos: 5,
        start_date: Time.zone.today
      )
      expect(ferment.review_date.to_date).to eq(Time.zone.today + 5.days)
    end

    it "needs_review? devuelve true si review_date <= hoy" do
      ferment = Ferment.new(
        user: @user,
        name: "Kimchi",
        description: "Un fermento coreano picante",
        instructions: "Fermentar",
        ingredients: "Repollo",
        revisar_fermentos: 0,
        start_date: Time.zone.today
      )
      ferment.review_date = Date.yesterday
      expect(ferment.needs_review?).to be(true)
    end

    it "needs_review? devuelve false si review_date > hoy" do
      ferment = Ferment.new(
        user: @user,
        name: "Kimchi",
        instructions: "Fermentar",
        ingredients: "Repollo",
        revisar_fermentos: 5,
        start_date: Time.zone.today
      )
      expect(ferment.needs_review?).to be(false)
    end
  end
end
