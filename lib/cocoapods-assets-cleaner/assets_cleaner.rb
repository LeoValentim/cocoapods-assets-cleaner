require "cocoapods"
require "fileutils"

module CocoapodsAssetsCleaner
  class AssetsCleaner
    def initialize(main_project_path_param, assets_path_param, excluded_dir_param)
      @main_project_path = main_project_path_param
      @assets_path = assets_path_param
      @excluded_dir = excluded_dir_param

      @spinner = Enumerator.new do |e|
        loop do
          e.yield "|"
          e.yield "/"
          e.yield "-"
          e.yield '\\'
        end
      end
    end

    def init_clean
      Pod::UI.puts "Getting images from assets...".yellow
      imagesets = get_images_from_path(@assets_path)
      Pod::UI.puts "#{imagesets.count} images founded"

      Pod::UI.puts "Searching for unused images...".yellow
      unused_imagesets = check_and_extact_unsed_images(imagesets, @main_project_path, @excluded_dir)
      Pod::UI.puts "#{unused_imagesets.count} unused images founded"

      Pod::UI.puts "Removing unused images...".yellow
      removed_imagesets = unused_imagesets.map { |image_name, image_path| remove_unused_image(image_name, image_path) }
      Pod::UI.puts "Removed #{removed_imagesets.count} from #{unused_imagesets.count} unused images."
    end

    def show_indicator_percentage(i)
      printf("\r%d%% %s", i, @spinner.next)
    end

    def remove_unused_image(image_name, image_path)
      FileUtils.remove_dir(image_path)

      if File.directory?(image_path)
        Pod::UI.puts "Failure on removing #{image_name} Asset".red
        return false
      else
        return true
      end
    end

    def check_and_extact_unsed_images(images, path, excluded_dir)
      unused_images = {}
      count = 0

      images.each do |image_name, image_path|
        command_sh = `grep -R -l --exclude-dir=#{excluded_dir} "#{image_name}" #{path}`
        if command_sh == ""
          Pod::UI.puts "\r#{image_name} is not used.".yellow
          unused_images[image_name] = image_path
        else
          Pod::UI.puts "\r#{image_name} is used.".green
        end

        percentage = (100 * count) / images.count
        show_indicator_percentage(percentage)
        count += 1
      end
      return unused_images
    end

    def get_images_from_path(path)
      result = get_images_directories_from_path(path)
      imagesets = result[:images]
      directories = result[:directories]

      while directories.count > 0
        current_directories = directories
        directories = []

        current_directories.each do |directory|
          new_result = get_images_directories_from_path(directory)
          new_result[:images].each { |key, value| imagesets[key] = value }
          directories += new_result[:directories] || []
        end
      end

      return imagesets
    end

    def get_images_directories_from_path(path)
      all_dir = Dir.entries(path)
        .select { |entry| File.directory? File.join(path, entry) and !(entry == "." || entry == "..") }

      images = {}
      all_non_images_dir = []
      all_dir.each do |directory|
        new_path = File.join(path, directory)
        if directory.include? ".imageset"
          images[directory.gsub(".imageset", "")] = new_path
        else
          all_non_images_dir.push(new_path)
        end
      end

      return {
               :images => images,
               :directories => all_non_images_dir,
             }
    end
  end
end
