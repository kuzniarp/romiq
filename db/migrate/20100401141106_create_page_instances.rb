class CreatePageInstances < ActiveRecord::Migration
  def self.up
    HomePage.create(:name => "Home", :item_order => 0)
    StaticPage.create(:name => "O nas", :item_order => 1)
    StaticPage.create(:name => "Oferta", :item_order => 2)
    Portfolio.create(:name => "Portfolio", :item_order => 3)
    ContactPage.create(:name => "Kontakt", :item_order => 4)
  end

  def self.down
    pages = []
    pages << HomePage.find_by_name("Home")
    pages << StaticPage.find_by_name("O nas")
    pages << StaticPage.find_by_name("Oferta")
    pages << Portfolio.find_by_name("Portfolio")
    pages << ContactPage.find_by_name("Kontakt")
    for page in pages do
      page.destroy if page
    end
  end
end
