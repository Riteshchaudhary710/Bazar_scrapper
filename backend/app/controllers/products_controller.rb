# frozen_string_literal: true

class ProductsController < ApplicationController
    before_action :validate_url, only: :search
  
    def index
      products = Product.all.order(id: :desc)
      render json: { data: products, success: true }
    end
  
    def search
      @result = Product.find_by(url: params[:search])
  
      # Refetch record if record expired or no record
      @result = ScraperService.new(params[:search]).call if @result.nil? || (@result && @result.expired?)
  
      render json: { data: @result, success: true }
    end
  
    private
  
    def validate_url
      if params[:search].match(%r{https://hamrobazaar.com/(.*).html}).present?
        return
      end
  
      raise CustomExceptions::InvalidUrl, 'Url must be a hamro bazar ad url'
    end
  end
  