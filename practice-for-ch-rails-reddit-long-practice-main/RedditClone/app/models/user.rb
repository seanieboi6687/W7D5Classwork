class User < ApplicationRecord
    validates_presence_of :username, :password_digest, :session_token
    validates_uniqueness_of :username, :session_token
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :subs
    
    has_many :posts
        foreign_key: :author_id
        class_name: :Post
        
    before_validation :ensure_session_token
    attr_reader :password

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && is_password(password)
            user
        else
            nil
        end
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_digest.is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end
end
