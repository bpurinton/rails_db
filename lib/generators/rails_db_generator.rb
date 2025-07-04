class RailsDbGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def copy_initializer
    template 'rails_db.rb', 'config/initializers/rails_db.rb'
  end
  
  def create_manifest_if_needed
    if Rails::VERSION::MAJOR >= 8
      manifest_path = 'app/assets/config/manifest.js'
      unless File.exist?(manifest_path)
        empty_directory 'app/assets/config'
        create_file manifest_path, <<~MANIFEST
          //= link_tree ../images
          //= link_directory ../javascripts .js
          //= link_directory ../stylesheets .css
        MANIFEST
        say "Created #{manifest_path} for Rails 8 compatibility", :green
      end
    end
  end
end