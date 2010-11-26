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

       def category_list model
         root = model.root
	 content_tag(:ul, content_tag(:li, link_to(root.name, category_path(root)) + subcategory_list(root)))
      end

      def subcategory_list root
      	  list = ''
      	  root.children.each do |cat|
      	  	list += content_tag(:li, link_to(cat.name, category_path(cat)) + subcategory_list(cat))
      	  end  
      	  list.present? ? content_tag(:ul, list, :style => 'margin:0;') : ''
      end
end
