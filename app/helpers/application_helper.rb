# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

       def link_to_page page
       	   if page
	      case page.class
	      when HomePage then root_path 
	      when ProductPage then products_path
	      when WorkPage then works_path
	      else page_path(page)
	      end
       	   end    
       end
end
