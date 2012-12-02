class Advertisement < ActiveRecord::Base
  attr_accessible :height, :image, :width, :x_location, :y_location
  attr_protected :board_id, :user_id

  has_many :payment_details, as: :payable
  has_many :tiles
  belongs_to :board 
  belongs_to :user

  validates :x_location, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
  validates :y_location, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0}
  validates :width, presence: true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1}
  validates :height,  presence: true, :numericality => { :only_integer => true , :greater_than_or_equal_to => 1}
  validates :image, presence: true

  validates :board, presence: true

  validate :size_check

  #Do stuff
  def charge
  end

  def image_contents=(image)
	image.read()
  end

  private 
  def size_check
		if x_location.is_a?(Integer) && y_location.is_a?(Integer) && width.is_a?(Integer) && height.is_a?(Integer)
			if x_location >= board.width
				errors.add(:x_location, "can't be larger than the board width")
			end

			if y_location >= board.height
				errors.add(:y_location, "can't be larger than the board height")
			end

			if width > board.width
				errors.add(:width, "can't be larger than the board width")
			end

			if height > board.height
				errors.add(:height, "can't be larger than  the board height")
			end

			if x_location + width > board.width
				errors.add(:x_location, "combined can't be larger than the board width")
			end

			if y_location + height > board.height
				errors.add(:y_location, "combined can't be larger than the board height")
			end
		end
	end

end
