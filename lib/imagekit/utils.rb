class Imagekit::Utils

  def self.imagekit_url(public_id, options = {})
    imagekit_endpoint = Imagekit::ENDPOINT
    imagekit_id = Imagekit.configuration.imagekit_id
    result = "#{imagekit_endpoint}/#{imagekit_id}/#{public_id}"
    return result
  end

  def self.random_public_id
    sr = defined?(ActiveSupport::SecureRandom) ? ActiveSupport::SecureRandom : SecureRandom
    sr.base64(20).downcase.gsub(/[^a-z0-9]/, "").sub(/^[0-9]+/, '')[0,20]
  end

  IMAGE_FORMATS = %w(ai bmp bpg djvu eps eps3 flif gif hdp hpx ico j2k jp2 jpc jpe jpg miff pdf png psd svg tif tiff wdp webp zip )

  def self.supported_image_format?(format)
    supported_format? format, IMAGE_FORMATS
  end

  def self.supported_format?( format, formats)
    format = format.to_s.downcase
    extension = format =~ /\./ ? format.split('.').last : format
    formats.include?(extension)
  end

  def self.resource_type_for_format(format)
    case
    when self.supported_format?(format, IMAGE_FORMATS)
      'image'
    when self.supported_format?(format, VIDEO_FORMATS)
      'video'
    when self.supported_format?(format, AUDIO_FORMATS)
      'audio'
    else
      'raw'
    end
  end

end
