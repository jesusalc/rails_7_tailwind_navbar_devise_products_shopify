# frozen_string_literal: true

require 'shopify/shopify_api'

class ProductsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_product, only: %i[show edit update destroy]
  before_action :require_login
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :clear_flash_errors

  # GET /products or /products.json
  def index
    @products = Product.all.order(created_at: :desc)
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('index_turbo_new_product',
                              partial: 'products/article_form',
                              locals: { product: @product }),
          turbo_stream.update('flash_turbo_shared_flash_notice',
                              partial: 'shared/flash_notice',
                              locals: { flash: })
        ]
      end
    end
  end

  # POST /products or /products.json
  def create
    if api_create(product_params)
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('index_turbo_new_product',
                                  partial: 'products/article_form',
                                  locals: { product: Product.new }),
              turbo_stream.prepend('index_turbo_products',
                                   partial: 'products/product',
                                   locals: { product: @product }),
              turbo_stream.update('flash_turbo_shared_flash_notice',
                                  partial: 'shared/flash_notice',
                                  locals: { flash: }),
              turbo_stream.update('index_turbo_count', html: Product.count)
            ]
          end
          format.html do
            redirect_to product_url(@product), notice: 'Produkt wurde erfolgreich in der Datenbank gespeichert'
          end
          format.json { render :show, status: :created, location: @product }
        else
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('index_turbo_new_product',
                                  partial: 'products/article_form',
                                  locals: {
                                    product: @product,
                                    status: :unprocessable_entity
                                  },
                                  status: :unprocessable_entity),
              turbo_stream.update('flash_turbo_shared_flash_notice',
                                  partial: 'shared/flash_notice',
                                  locals: { flash: })
            ]
          end
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('index_turbo_new_product',
                                partial: 'products/article_form',
                                locals: {
                                  product: Product.new(product_params),
                                  status: :unprocessable_entity
                                },
                                status: :unprocessable_entity),
            turbo_stream.update('flash_turbo_shared_flash_notice',
                                partial: 'shared/flash_notice',
                                locals: { flash: })
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    if api_update(product_params)
      respond_to do |format|
        if @product.update(product_params)
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('index_turbo_new_product',
                                  partial: 'products/article_form',
                                  locals: { product: Product.new }),
              turbo_stream.update('flash_turbo_shared_flash_notice',
                                  partial: 'shared/flash_notice',
                                  locals: { flash: })
            ]
          end
          format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('index_turbo_new_product',
                                  partial: 'products/article_form',
                                  locals: {
                                    product: @product,
                                    status: :unprocessable_entity
                                  },
                                  status: :unprocessable_entity),
              turbo_stream.update('flash_turbo_shared_flash_notice',
                                  partial: 'shared/flash_notice',
                                  locals: { flash: })
            ]
          end
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('index_turbo_new_product',
                                partial: 'products/article_form',
                                locals: {
                                  product: @product,
                                  status: :unprocessable_entity
                                },
                                status: :unprocessable_entity),
            turbo_stream.update('flash_turbo_shared_flash_notice',
                                partial: 'shared/flash_notice',
                                locals: { flash: })
          ]
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    if api_destroy(@product.id)
      @product.destroy

      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove(dom_id(@product)),
            turbo_stream.update('index_turbo_count', html: Product.count)
          ]
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('index_turbo_new_product',
                                partial: 'products/article_form',
                                locals: {
                                  product: @product,
                                  status: :unprocessable_entity
                                },
                                status: :unprocessable_entity),
            turbo_stream.update('flash_turbo_shared_flash_notice',
                                partial: 'shared/flash_notice',
                                locals: { flash: })
          ]
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def api_update(params)
    new_product = product_template(params)
    shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com"
    flash[:error] = 'Das Produkt war noch nicht erfolgreich an Shopify gesendet'
    response = RestClient.put "#{shop_url}/admin/api/#{ENV['SHOPIFY_API_VERSION']}/products.json",
                              product: new_product
    return false if response.nil?

    flash[:notice] = 'Das Produkt wurde erfolgreich an Shopify gesendet'
    true
  rescue RestClient::UnprocessableEntity
    false
  rescue SocketError
    flash[:error] = 'Es gibt keine Internet nach Shopify'
    false
  end

  def api_destroy(product_id)
    # new_product = product_template(params)
    #                                                                                                                                     DELETE /admin/api/2021-07/products/632910392.json
    response = RestClient.delete "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin/api/#{ENV['SHOPIFY_API_VERSION']}/products/#{product_id}.json"
    if response.nil?
      flash[:error] = 'Das Produkt war noch nicht erfolgreich an Shopify gesendet'
      return false
    end
    flash[:notice] = 'Das Produkt wurde erfolgreich an Shopify gesendet'
    true
  rescue RestClient::Unauthorized
    flash[:error] = 'Shopify sagt 401 Nicht autorisiert'
    false
  rescue RestClient::UnprocessableEntity
    flash[:error] = 'Das Produkt war noch nicht erfolgreich an Shopify gesendet'
    false
  rescue SocketError
    flash[:error] = 'Es gibt keine Internet nach Shopify'
    false
  rescue RestClient::BadRequest
    flash[:error] = 'Schlechte Anfrage'
    false
  end

  def api_create(params)
    new_product = product_template(params)
    response = RestClient.post "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin/api/#{ENV['SHOPIFY_API_VERSION']}/products.json",
                               product: new_product
    if response.nil?
      flash[:error] = 'Das Produkt war noch nicht erfolgreich an Shopify gesendet'
      return false
    end
    flash[:notice] = 'Das Produkt wurde erfolgreich an Shopify gesendet'
    true
  rescue RestClient::Unauthorized
    flash[:error] = 'Shopify sagt 401 Nicht autorisiert'
    false
  rescue RestClient::UnprocessableEntity
    flash[:error] = 'Das Produkt war noch nicht erfolgreich an Shopify gesendet'
    false
  rescue SocketError
    flash[:error] = 'Es gibt keine Internet nach Shopify'
    false
  rescue RestClient::BadRequest
    flash[:error] = 'Schlechte Anfrage'
    false
  end

  def product_template(params)
    {
      "title": params['title'],
      "body": params['description'],
      "vendor": 'New', # params["vendor"],
      "product_type": 'New', # params["prod_type"],
      "published": false,
      "variants":
        [
          { "option1": params['title'], # params["var1"],
            "price": params['price'],
            "sku": "#{rand(100...10_000)}NEW", # "123",
            "inventory_quantity": '1' } # params["qty1"]
        ]
    }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Cannot find record for: '#{params[:id]}'"
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@product)) }
    end
  end

  def clear_flash_errors
    flash = {}
    flash[:error] = ''
    flash[:notice] = ''
    flash
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:id, :title, :description, :image, :price)
  end
end
