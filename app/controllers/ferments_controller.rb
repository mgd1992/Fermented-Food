class FermentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_ferment, only: [:show, :edit, :update, :destroy]

  def index
    # Si el parámetro de búsqueda está presente, se buscará en MeiliSearch
    if params[:query].present?
      client = MeiliSearch::Client.new('http://127.0.0.1:7700', 'Xt4aJ3W1ztSVjuoZ098gP3ZUl6Bo2_KFrcGOrd0ODHQ')
      index = client.index('ferments')

      # Realiza la búsqueda en MeiliSearch con el parámetro de consulta
      search_result = index.search(params[:query], limit: 10)

      # Accede a los 'hits' dentro del hash devuelto por MeiliSearch
      @ferments = search_result["hits"]
    else
      # Si no hay búsqueda, simplemente cargamos todos los fermentos
      @ferments = Ferment.includes(:user).all
    end
  end

  def show
    @comments = @ferment.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @ferment = Ferment.new
  end

  def create
    @ferment = Ferment.new(ferment_params)
    @ferment.user = current_user

    if @ferment.save
      # Indexar el fermento en MeiliSearch
      index = MeiliSearch::Client.new('http://127.0.0.1:7700', 'Xt4aJ3W1ztSVjuoZ098gP3ZUl6Bo2_KFrcGOrd0ODHQ').index('ferments')

      # Crear un documento que se añadirá al índice de MeiliSearch
      document = {
        id: @ferment.id,
        name: @ferment.name,
        description: @ferment.description,
        ingredients: @ferment.ingredients,
        user_id: @ferment.user.id,
        user_name: @ferment.user.full_name
      }

      # Agregar el documento al índice
      index.add_documents([document])

      redirect_to @ferment, notice: 'Your ferment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    nuevas_fotos = params[:ferment][:photos] if params[:ferment][:photos].present?

    nuevas_fotos.each { |foto| @ferment.photos.attach(foto) } if nuevas_fotos.present?

    if @ferment.update(ferment_params.except(:photos))
      # Indexar el fermento actualizado en MeiliSearch
      index = MeiliSearch::Client.new('http://127.0.0.1:7700', 'Xt4aJ3W1ztSVjuoZ098gP3ZUl6Bo2_KFrcGOrd0ODHQ').index('ferments')

      # Crear un documento que se añadirá al índice de MeiliSearch
      document = {
        id: @ferment.id,
        name: @ferment.name,
        description: @ferment.description,
        ingredients: @ferment.ingredients,
        user_id: @ferment.user.id,
        user_name: @ferment.user.full_name
      }

      # Actualizar el documento en el índice
      index.update_documents([document])

      redirect_to @ferment, notice: 'Your ferment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ferment.destroy
    redirect_to ferments_path, notice: 'Your ferment was successfully destroyed.'
  end

  private

  def set_ferment
    @ferment = Ferment.find(params[:id])
  end

  def ferment_params
    params.require(:ferment).permit(:name, :description, :user_id, :ingredients, photos: [])
  end
end
