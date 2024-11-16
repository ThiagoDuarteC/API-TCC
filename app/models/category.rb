class Category < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: { message: "O nome é obrigatório" }
end
