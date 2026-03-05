require "rails_helper"
require "securerandom"

RSpec.describe ReviewReminderJob, type: :job do
  include ActiveJob::TestHelper

  let(:user) do
    User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "1234567",
      first_name: "Marco",
      last_name: "Gonzalez"
    )
  end

  def create_ferment(overrides = {})
    f = Ferment.create!(
      user: user,
      name: "Kimchi",
      description: "Fermento coreano picante",
      instructions: "Fermentar repollo",
      ingredients: "Repollo, sal",
      revisar_fermentos: 5,
      start_date: Time.zone.today
    )
    f.update!(**overrides) if overrides.any?
    f
  end

  before { Ferment.find_each { |f| f.update!(review_reminder_sent: true) } }

  describe "#perform" do
    it "marca review_reminder_sent como true después de enviar" do
      ferment = create_ferment(review_date: Date.yesterday, review_reminder_sent: false)
      ReviewReminderJob.new.perform
      expect(ferment.reload.review_reminder_sent).to be(true)
    end

    it "no cambia fermentos que ya recibieron recordatorio" do
      ferment = create_ferment(review_date: Date.yesterday, review_reminder_sent: true)
      ReviewReminderJob.new.perform
      expect(ferment.reload.review_reminder_sent).to be(true)
    end

    it "no procesa fermentos con review_date futura" do
      ferment = create_ferment(review_date: Date.tomorrow, review_reminder_sent: false)
      ReviewReminderJob.new.perform
      expect(ferment.reload.review_reminder_sent).to be(false)
    end

    it "encola el email para fermentos que necesitan revisión" do
      create_ferment(review_date: Date.yesterday, review_reminder_sent: false)
      expect { ReviewReminderJob.new.perform }.to have_enqueued_mail(FermentMailer, :review_reminder)
    end
  end
end
