class Goal < ApplicationRecord
  belongs_to :user

  validates :name, presence: { message: "O nome é obrigatório" }
  #validates :icon_name, presence: { message: "O icone é obrigatório" }
end
