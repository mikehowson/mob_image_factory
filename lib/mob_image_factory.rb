class MobImageFactory
  def initialize(args)
    @args = args
  end

  def produce
    if @args.empty?
      return usage
    end
    filename = @args[0]

    system "identify #{filename}"

    convert filename, 144, "android", "xxhdpi"
    "Done"
  end

private
  def convert(filename, size, platform, folder)
    system "mkdir #{platform}"
    system "mkdir #{platform}/#{folder}"
    system "convert #{filename} -resize #{size}x#{size} #{platform}/#{folder}/#{filename}"
  end

  def usage
    "Usage: mob_image_factory <filename>"
  end
end
