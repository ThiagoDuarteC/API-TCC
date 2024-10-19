class User < ApplicationRecord
  has_secure_password

  has_many :accounts
  has_many :goals

  validates :full_name, presence: { message: "O nome é obrigatório" }
  # validates :username, presence: { message: "O nome de usuario é obrigatório" }
  validates :email, presence: { message: "O email é obrigatório" }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "O email não é válido" }
end
