class Track < ActiveRecord::Base
  #attr_accessible :title, :artist
   #acts_as_tsearch :fields => ["title","artist"]
   #
  #validates :title, presense: true, uniqueness: true
  #validates :artist, presense: true

  def self.search(query)
    #where ('title like ? or artist like ?', "%#{query}%", "%#{query}%")
    #where ('title like ?', "%#{query}%")
    if query
      #find(:all, :conditions => ['title LIKE ?', "%#{query}%"])
      #where ('title like ? or artist like ?', "%#{query}%", "%#{query}%")
      where('lower(title) like lower(?) or lower(artist) like lower(?)', "%#{query}%", "%#{query}%").order('artist')
    else
      #find(:all)
      all.order('artist')
    end
  end
end
