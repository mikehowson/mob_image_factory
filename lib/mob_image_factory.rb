class MobImageFactory
  def initialize(args)
    @args = args
  end

  def produce
    if @args.empty?
      return usage
    end
    @infilename = @args[0]
    @outfilename = @args[1].nil? ? @infilename : @args[1]

    system "identify #{@infilename}"

    #Android App icons
    convert 192, "android", "xxxhdpi"
    convert 144, "android", "xxhdpi"
    convert 96, "android", "xhdpi"
    convert 72, "android", "hdpi"
    convert 48, "android", "mdpi"

    #Android Notification icons
    convert_greyscale 96, "android", "xxxhdpi", "notification_"
    convert_greyscale 72, "android", "xxhdpi", "notification_"
    convert_greyscale 48, "android", "xhdpi", "notification_"
    convert_greyscale 36, "android", "hdpi", "notification_"
    convert_greyscale 24, "android", "mdpi", "notification_"

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
  end

  def usage
    "Usage: mob_image_factory <filename> <optional_output_filename>"
  end
end
