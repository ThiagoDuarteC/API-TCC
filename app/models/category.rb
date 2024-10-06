class Category < ApplicationRecord
  belongs_to :user

  validates :name, presence: { message: "O nome é obrigatório" }
end
