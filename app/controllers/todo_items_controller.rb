class TodoItemsController < ApplicationController
  before_action :require_user
  before_action :find_todo_list
  before_action :find_todo_item, except: [ :index, :new, :create ]

  def index; end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "There was a problem adding the todo list item."
      render action: :new
    end
  end

  def edit; end

  def update
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = "Saved todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "The todo item could not be saved."
      render action: :edit
    end
  end

  def destroy
    if @todo_item.destroy
      flash[:success] = "The todo item was deleted."
    else
      flash[:error] = "The todo item could not be deleted."
    end
    redirect_to todo_list_todo_items_path
  end

  def complete
    @todo_item.toggle_completion!
    redirect_to todo_list_todo_items_path, notice: "Todo item updated."
  end

  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
  end

  private
  def find_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def find_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
