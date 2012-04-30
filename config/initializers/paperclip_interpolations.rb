module Paperclip
  module Interpolations
    def watermark attachment, style_name          
      attachment.instance.watermark
    end
    
    def watermark_2 attachment, style_name
      attachment.instance.watermark_2
    end
  end
end
