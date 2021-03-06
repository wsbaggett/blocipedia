class WikisController < ApplicationController
  def index
    #@wikis = Wiki.order("created_at DESC")
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash.now[:alert] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:id])
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
  end

  def delete_collaborator
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:user_id])

     flash[:notice] = "Collaborating user was deleted successfully."

    @wiki.collaborating_users.delete(@user)
    redirect_to wiki_path
  end

  def add_collaborator
    @wiki = Wiki.find(params[:id])
    @user = User.find_by(email: params[:coll_email])

    if @user.nil?
      flash[:alert] = "User not found!"
      redirect_to wiki_path(@wiki)
      return
    end

    if @wiki.collaborating_users.include?(@user)
       flash[:alert] = "Already a collaborator on this wiki!"
       redirect_to wiki_path(@wiki)
    else
      @wiki.collaborating_users << @user
      redirect_to wiki_path(@wiki), notice: "Collaborating user was added successfully."
    end
  end

  private

    def wiki_params
        params.require(:wiki).permit(:title, :body, :private)
    end

end
