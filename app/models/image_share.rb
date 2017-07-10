class ImageShare < ApplicationRecord
	validate :is_image, on: :create
	def initialize(params = {})
  @image = params.delete(:image)
  super
  if @image
    self.image_name = sanitize_filename(@image.original_filename)
    self.image_type = @image.content_type
    self.image_content = @image.read
  end
end

private
  def sanitize_filename(filename)
    return File.basename(filename)
end
def is_image
	unless @image.content_type == "image/jpeg" || @image.content_type == "image/pjpeg" || @image.content_type == "image/png" || @image.content_type == "image/x-png" || @image.content_type == "image/gif"
		errors.add(:image, 'File must be image.')
	end
end
end
