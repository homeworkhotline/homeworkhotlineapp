class Principal < ApplicationRecord
	def initialize(params = {})
  nab = params.delete(:nab)
  snl = params.delete(:snl)
  nice = params.delete(:nice)
  super
  if nab
    self.nab_filename = sanitize_filename(nab.original_filename)
    self.nab_content_type = nab.content_type
    self.nab_contents = nab.read
  end
  if snl
    self.snl_filename = sanitize_filename(snl.original_filename)
    self.snl_content_type = snl.content_type
    self.snl_contents = snl.read
  end
  if nice
    self.nice_name = sanitize_filename(nice.original_filename)
    self.nice_type = nice.content_type
    self.nice_content = nice.read
  end
end
private
  def sanitize_filename(filename)
    return File.basename(filename)
  end
end
