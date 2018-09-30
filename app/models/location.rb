class Location < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings 

  def self.tagged_with(name)
  	# name_array.each do |name|
  	# 	Tag.where(name: name).each do |tag|
  	# 		# Tag(tag.id).locations

  	joins(:tags).where(:tags => { :name => name }).having("count(tags.name) = ?", name.count).group('locations.id')
  end

end
