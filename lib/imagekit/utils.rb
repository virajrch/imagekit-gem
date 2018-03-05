class Imagekit::Utils

  PREDEFINED_TRANSFORMATION = {
    "crop"                 => "c",
    "quality"              => "q",
    "format"               => "f",
    "progressive_jpeg"     => "pr",
    "image_metadata"       => "md",
    "color_profile"        => "cp",
    "rotate"               => "rt",
    "radius"               => "r",
    "background"           => "bg",
    "blur"                 => "bl",
    "border"               => "b",
    "dpr"                  => "dpr",
    "overlay_image"        => "oi",
    "named_transformation" => "n",
    "contrast"             => "e-contrast",
    "sharpen"              => "e-sharpen",
    "height"               => "h",
    "width"                => "w",
    "focus"                => "fo"
  }

  def self.imagekit_url(public_id, options = {})
    imagekit_endpoint = Imagekit::ENDPOINT
    imagekit_id = Imagekit.configuration.imagekit_id
    cname       = Imagekit.configuration.cname
    source = if cname.present?
      "https://#{cname}.imagekit.io"
    else
      "#{imagekit_endpoint}/#{imagekit_id}"
    end
    url = imagekit_transformed_url(source, options)
    result = "#{url}/#{public_id}"
    return result
  end

  def self.random_public_id
    sr = defined?(ActiveSupport::SecureRandom) ? ActiveSupport::SecureRandom : SecureRandom
    sr.base64(20).downcase.gsub(/[^a-z0-9]/, "").sub(/^[0-9]+/, '')[0,20]
  end

  IMAGE_FORMATS = %w(ai bmp bpg djvu eps eps3 flif gif hdp hpx ico j2k jp2 jpc jpe jpg miff pdf png psd svg tif tiff wdp webp zip auto )

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

  private

    def self.imagekit_transformed_url(source, transformations)
      return source unless transformations.present?
      array = []
      transformations.except(:resource_type, :type, :version).each do |k, v|
        key = Imagekit::Utils::PREDEFINED_TRANSFORMATION[k.to_s]
        array << "#{key}-#{v}"
      end
      transformation_string = array.size > 0 ? "tr:#{array.join(',')}" : nil
      source = "#{source}/#{transformation_string}" if transformation_string
      source
    end
    private_class_method :imagekit_transformed_url

end
