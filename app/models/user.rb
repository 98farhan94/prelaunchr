require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 5,
        'html' => 'Handmade<br>Joey gifts',
      'class' => 'two',
      'image' =>  ActionController::Base.helpers.asset_path(
          'assets/refer/joey_logo.jpg')
    },
    {
      'count' => 10,
        'html' => 'Oops! The Parenting Handbook<br>by Erik Robertson',
      'class' => 'three',
      'image' => ActionController::Base.helpers.asset_path(
        'assets/refer/oops.jpg')
    },
    {
      'count' => 25,
        'html' => 'Bundle<br>Includes The fat loss puzzle eBook + personalized 30 min consulting on optimal nutrition for nursing moms by Clarke Russell',
      'class' => 'four',
      'image' => ActionController::Base.helpers.asset_path(
        'assets/refer/fat_loss.png')
    },
    {
      'count' => 50,
      'html' => ' $50 Amazon or ToysrUs<br> gift card',
      'class' => 'five',
      'image' => ActionController::Base.helpers.asset_path(
        'assets/refer/cards.png')
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.signup_email(self).deliver
  end
end
