class ClothingItemsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

before_action :authenticate, only: [:create, :update, :delete]

    def index 
        clothing_items = ClothingItem.all
        render json: clothing_items, except: [:clothing_category_id], include: [:clothing_category => {only: [:name]}]
    end 

    def show 
        clothing_item = ClothingItem.find(params[:id])
        render json: clothing_item, except: [:clothing_category_id], include: [:clothing_category => {only: [:name]}]
    end 

    def create 
        clothing_item = ClothingItem.create(clothing_item_params)
        render json: clothing_item, except: [:clothing_category_id], include: [:clothing_category => {only: [:name]}]
    end 

    def update 
        clothing_item = ClothingItem.find(params[:id])
        clothing_item.update(clothing_item_params)
        render json: clothing_item, except: [:clothing_category_id], include: [:clothing_category => {only: [:name]}]
    end 

    def destroy
        clothing_item = ClothingItem.find(params[:id])
        clothing_item.destroy
        render json: {status: 204, message: "One of your clothing items has been destroyed."}
    end 

    private 

    def clothing_item_params
        params.require(:clothing_item).permit(:image_url, :clothing_type, :color, :clothing_category_id, :user_id)
    end 

    def handle_record_not_found(exception)
        render json: {error: exception.message}, status: :not_found
    end 

    def handle_record_invalid(exception)
        render json: {error: exception.record.errors}, status: :unprocessable_entity
    end 
end
