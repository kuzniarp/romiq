class Post < ActiveRecord::Base

      named_scope :active, :conditions => {:status => true}
#      named_scope :recent, :lambda {|exclude_id| :conditions => ["id != ?", exclude_id], :order => "created_at desc"}

      def self.newest
      	  active.find(:first, :order => "created_at desc")
      end   

      def self.recent exclude_id=nil, limit=10
      	  active.find(:all, :order => "created_at desc", :conditions => ["id != ?", exclude_id.to_i], :limit => limit)
      end
end
