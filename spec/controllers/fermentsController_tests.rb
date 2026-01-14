require "rails_helper"
require "securerandom"

RSpec.describe FermentsController, type: :request do
  before(:each) do
    # Usuario único para cada test
    @user = User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "1234567",
      first_name: "Marco",
      last_name: "Gonzalez"
    )
    sign_in @user

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

  describe "GET #index" do
    it "devuelve status 200" do
      get ferments_path
      expect(response).to have_http_status(200)
    end

    it "filtra por query" do
      get ferments_path, params: { query: "Kimchi" }
      expect(response.body).to include("Kimchi")
    end
  end

  describe "GET #show" do
    it "devuelve status 200 y muestra el fermento" do
      get ferment_path(@ferment)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Kimchi")
    end
  end

  describe "GET #new" do
    it "devuelve status 200" do
      get new_ferment_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "crea un fermento válido" do
      expect {
        post ferments_path, params: { ferment: {
          name: "Sauerkraut",
          instructions: "Fermentar repollo",
          ingredients: "Repollo, sal",
          revisar_fermentos: 3,
          start_date: Date.today
        } }
      }.to change(Ferment, :count).by(1)
      expect(response).to redirect_to(Ferment.last)
    end

    it "no crea fermento inválido" do
      expect {
        post ferments_path, params: { ferment: { name: "" } }
      }.not_to change(Ferment, :count)
      expect(response.body).to include("error") # depende de tu vista
    end
  end

  describe "GET #edit" do
    it "devuelve status 200" do
      get edit_ferment_path(@ferment)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH #update" do
    it "actualiza fermento válido" do
      patch ferment_path(@ferment), params: { ferment: { name: "Kimchi modificado" } }
      expect(@ferment.reload.name).to eq("Kimchi modificado")
      expect(response).to redirect_to(@ferment)
    end
  end

  describe "DELETE #destroy" do
    it "elimina un fermento propio" do
      expect {
        delete ferment_path(@ferment)
      }.to change(Ferment, :count).by(-1)
      expect(response).to redirect_to(@user)
    end

    it "no permite eliminar fermento de otro usuario" do
      other_user = User.create!(
        email: "user_#{SecureRandom.hex(4)}@example.com",
        password: "1234567",
        first_name: "Otro",
        last_name: "Usuario"
      )
      sign_in other_user
      expect {
        delete ferment_path(@ferment)
      }.not_to change(Ferment, :count)
      expect(response).to redirect_to(ferments_path)
    end
  end

  describe "DELETE #destroy_photo" do
    it "elimina una foto adjunta" do
      # Adjuntamos una foto de prueba
      @ferment.photos.attach(io: File.open(Rails.root.join("spec/fixtures/files/test_image.jpg")), filename: "test_image.jpg", content_type: "image/jpeg")
      photo_id = @ferment.photos.first.id

      expect {
        delete destroy_photo_ferment_path(@ferment, photo_id: photo_id)
      }.to change(ActiveStorage::Attachment, :count).by(-1)
      expect(response).to redirect_to(ferment_path(@ferment))
    end
  end
end
