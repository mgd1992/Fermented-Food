require "rails_helper"
require "securerandom"

RSpec.describe FermentMailer, type: :mailer do
  let(:user) do
    User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "1234567",
      first_name: "Marco",
      last_name: "Gonzalez"
    )
  end

  let(:ferment) do
    Ferment.create!(
      user: user,
      name: "Kimchi",
      description: "Fermento coreano picante",
      instructions: "Fermentar repollo",
      ingredients: "Repollo, sal",
      revisar_fermentos: 5,
      start_date: Time.zone.today
    )
  end

  describe "#review_reminder" do
    let(:mail) { FermentMailer.review_reminder(ferment) }

    it "se envía al email del usuario" do
      expect(mail.to).to eq([user.email])
    end

    it "tiene el asunto correcto" do
      expect(mail.subject).to include("Kimchi")
    end

    it "menciona el nombre del fermento en el cuerpo" do
      expect(mail.body.encoded).to include("Kimchi")
    end
  end
end
