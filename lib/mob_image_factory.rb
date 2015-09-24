class MobImageFactory
  def initialize(args)
    @args = args
  end

  def produce
    if @args.empty? || @args.size < 2
      return usage
    end
    @type = @args[0]
    @infilename = @args[1]
    @outfilename = @args[2].nil? ? @infilename : @args[2]

    system "identify #{@infilename}"

    if @type == 'android_icon'
      #Android App icons
      convert 192, "android", "xxxhdpi"
      convert 144, "android", "xxhdpi"
      convert 96, "android", "xhdpi"
      convert 72, "android", "hdpi"
      convert 48, "android", "mdpi"
    elsif @type == 'android_notification_icon'
      #Android Notification icons
      convert_greyscale 96, "android", "xxxhdpi"
      convert_greyscale 72, "android", "xxhdpi"
      convert_greyscale 48, "android", "xhdpi"
      convert_greyscale 36, "android", "hdpi"
      convert_greyscale 24, "android", "mdpi"
    else
      return usage
    end

    "Done"
  end

private
  def convert_greyscale(size, platform, folder, filename_prepend = "")
    convert size, platform, folder, filename_prepend, "-colorspace Gray"
  end

  def convert(size, platform, folder, filename_prepend = "", extra_cmd_options = "")
    system "mkdir #{platform}"
    system "mkdir #{platform}/#{folder}"
    system "convert #{@infilename} #{extra_cmd_options} -resize #{size}x#{size} #{platform}/#{folder}/#{filename_prepend}#{@outfilename}"
    puts "convert #{@infilename} #{extra_cmd_options} -resize #{size}x#{size} #{platform}/#{folder}/#{filename_prepend}#{@outfilename}"
  end

  def usage
    "\n"+
    "Usage: mob_image_factory convert_type <filename> <optional_output_filename>\n\n"+
    "convert_types: android_icon, android_notification_icon"+
    "\n\n"
  end
end
