class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  has_many :owned_d11_teams, class_name: :D11Team, foreign_key: :owner_id, dependent: :restrict_with_exception
  has_many :co_owned_d11_teams, class_name: :D11Team, foreign_key: :co_owner_id, dependent: :restrict_with_exception

  def self.new_with_session(params, session)
    # This adds the email to the email field in the signup page if a user tries to sign up with an
    # account with an email that is already in use.
    super.tap do |user|
      email = session["devise.email"]
      if !email.blank?
        user.email = email if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      # Twitter doesn't provide email so we'll add a dummy email for Twitter logins.
      user.email ||= "#{auth.info.nickname}@twitter.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end         
end
