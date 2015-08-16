class Event < ActiveRecord::Base
	belongs_to :organizers, class_name: "User"
	has_many :taggings
	has_many :tags, through: :taggings
	extend FriendlyId
  	friendly_id :title, use: :slugged


  	def all_tags=(names)
  		self.tags = names.split(",").map do |t|
  			Tag.where(name: t.strip).first_or_create!
  		end
  	end

  	def all_tags
  		tags.map(&:name).join(", ")
  	end

  	def self.tagged_with(tag_name)
      Tag.find_by_name!(tag_name).events
    end

    def self.tag_counts
      Tag.select("tags.name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
    end

end
