class Product < ApplicationRecord
    validates :url, presence: true, uniqueness: true
end
