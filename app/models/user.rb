class User < ApplicationRecord
    attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :tweets
         has_one :profile

         has_many :active_relationships,  class_name:   "Relationship",
                                        foreign_key:  "follower_id",
                                        dependent:    :destroy
       has_many :passive_relationships, class_name:  "Relationship",
                                        foreign_key: "followed_id",
                                        dependent:   :destroy
       has_many :following, through: :active_relationships, source: :followed
       has_many :followers, through: :passive_relationships, source: :follower


  # Follows a user.
    def follow(other_user)
      active_relationships.create(followed_id: other_user.id)
    end

    # Unfollows a user.
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # Returns true if the current user is following the other user.
    def following?(other_user)
      followers.include?(other_user)
    end

    def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   login = conditions.delete(:login)
   where(conditions).where(['lower(nickname) = :value OR lower(email) = :value', { value: login.strip.downcase }]).first
 end

 def self.send_reset_password_instructions(attributes = {})
   recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
   recoverable.send_reset_password_instructions if recoverable.persisted?
   recoverable
 end

 def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error = :invalid)
   (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

   attributes = attributes.slice(*required_attributes)
   attributes.delete_if { |_key, value| value.blank? }

   if attributes.keys.size == required_attributes.size
     if attributes.key?(:login)
       login = attributes.delete(:login)
       record = find_record(login)
     else
       record = where(attributes).first
     end
   end

   unless record
     record = new

     required_attributes.each do |key|
       value = attributes[key]
       record.send("#{key}=", value)
       record.errors.add(key, value.present? ? error : :blank)
     end
   end
   record
 end

 def self.find_record(login)
   where(['username = :value OR email = :value', { value: login }]).first
 end
end
