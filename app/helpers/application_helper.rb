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

       def category_list model, admin = false
       	 list = ''
         roots = model.roots
	 roots.each do |root|
	 	    list += content_tag(:ul, content_tag(:li, link_to(root.name, (admin ? edit_admin_category_path(root) : category_path(root))) + (link_to(" +", new_admin_category_path(:parent_id => root, :type => model)) if admin).to_s + subcategory_list(root, admin)))
         end
	 list += link_to("Dodaj kategorie glowna", new_admin_category_path(:type => model)) if admin
	 list
      end

      def subcategory_list root, admin
      	  list = ''
      	  root.children.each do |cat|
      	  	list += content_tag(:li, link_to(cat.name, (admin ? edit_admin_category_path(cat) : category_path(cat))) + (link_to(" +", new_admin_category_path(:parent_id => cat, :type => cat.class)) if admin).to_s + subcategory_list(cat, admin))
      	  end  
#	  list += content_tag(:li, link_to("Nowa", new_admin_category_path)) if admin
      	  list.present? ? content_tag(:ul, list, :style => 'margin:0;') : ''
      end
end
