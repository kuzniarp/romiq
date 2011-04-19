class Post < ActiveRecord::Base

  named_scope :active, :conditions => {:status => true}
  named_scope :for_month, lambda {|date| {:conditions => ["created_at between :from and :to", {:from => date, :to => date}]}}

  MONTHS = ["Styczen", "Luty", "Marzec", "Kwiecien", "Maj", "Czerwiec", "Lipiec", "Sierpien", "Wrzesien", "Pazdziernik", "Listopad", "Grudzien"]
  
  def self.newest
    active.find(:first, :order => "created_at desc")
  end   
  
  def self.recent exclude_id=nil, limit=10
    active.find(:all, :order => "created_at desc", :conditions => ["id != ?", exclude_id.to_i], :limit => limit)
  end

  def self.months
    months = {}
    all(:order => "created_at").group_by{|p| p.created_at.year}.each do |year,posts|
      posts.each do |post|
        months[year] = [] unless months[year]
        month = MONTHS[post.created_at.month-1]
        months[year] << month unless months[year].include?(month)
      end
    end
    months
  end
end
