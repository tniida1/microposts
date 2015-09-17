# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
   include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #  storage :file
  # storage :fog

  # use Cloudinary strage service for production environment with Heroku
  
  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file
  end

  def public_id
    micropost.id
  end
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # add: set limti 700px
  process :resize_to_limit => [700, 700]
  
  # add: save using JPG format
  process :convert => 'jpg'
  
  # add: generate thumbnail
  version :thumb do
    process :resize_to_limit => [300, 300]
  end
  
  # accept jpg,jpeg,gif,png only
  def extention_white_list
    %w(jpg jpeg gif png)
  end
  
  ## change filename to (.jpg' to convert GIF to JPG)
  #def filename
  #  super.chomp(File.extname(super)) + '.jpg' if original_filename_present?
  #end
  
  #set filename using timestamp
  def filename
    time = Time.now
    name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
    name.downcase
  end

end
