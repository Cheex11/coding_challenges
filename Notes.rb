//////////////////////////////////////////////
In the controller:
	instead of having:

	def index
		@posts = Post.where('published = ? AND published_on > ?', true, 2.days.ago)
	end

MOVE the logic to the model so that the controller looks like:
	def index
		@posts = Post.recent
	end

SO THE MODEL LOOKS LIKE:
	class Post < ActiveRecord
		def self.recent
			where('published = ? AND published_on > ?', true, 2.days.ago)
		end
	end

//////////////////////////////////////////////


This JOINS a published on query with an approved scope from the review model

class Item < ActiveRecord::Base
  has_many :reviews
  scope :recent, ->{
    where('published_on > ?', 2.days.ago).joins(:reviews).merge(Review.approved)
  }
end

/////////////////////////////////////////////////

scope with a variable!

Controller:

	def index
		@trending = Topic.tending(5)
	end


Model:

	class Topic < ActiveRecord::Base

		scope :trending, lambda { |num = nil| where('started_trending' > 1.day.ago).
																					order('mentions desc').
																					limit(num)	}

	end


/////////////////////////////////////////////////

PORO that sends an email without ActiveRecord

CONTROLLER:

ContactUsController < ApplicationController

	def new
		@contact_form = ContactForm.new
	end

	def send_email
		@contact_form = ContactForm.new(params[:contact_form])

		if @contact_form.valid?
			Notifications.contact_us(@contact_form).deliver
			redirect_to root_path, :notice => "Email sent, we'll get back to you"
		else
			render :new
		end
	end
end


VIEW:
<%= form_for @contact_form, :url => send_email_push do |f| %>       'dont mind this'>

# NOTE ->>>>> @contact_form is an instance variable

MODEL
class ContactForm
	include ActiveModel::Validations
	include ActiveModel::Conversion

	attr_accessor :name, :email, :body
	validates_presence_of :name, :email, :body

	def initialize(attributes = {})
		attributes.each do |name, value|
			send('#{name}=', value)
		end
	end

	def persisted?
		false
	end



/////////////////////////////////////////////////


validates_presence_of :status
validates_numericality_of :fingers
valiates_uniqueness_of :toothmarks
validates_confirmations_of :password
validates_acceptance_of :zombification
validates_length_of :password, minimum: 3
validates_format_of :email, with: /regex/i
validates_inclusion_of :age, in: 12..99
validates_exclusion_of :age, in: 0..21,
											 message: "Sorry you must be over 21"

Best Practice:

validates :status,
					presence: true,
					length: { minimum: 3 }


/////////////////////////////////////////////////


Pick.create(player: @player, team: @team)


/////////////////////////////////////////////////


/////////////////////////////////////////////////


/////////////////////////////////////////////////


/////////////////////////////////////////////////


/////////////////////////////////////////////////


/////////////////////////////////////////////////


/////////////////////////////////////////////////



