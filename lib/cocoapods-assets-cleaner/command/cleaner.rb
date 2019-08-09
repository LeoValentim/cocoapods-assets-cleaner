require 'cocoapods'
require 'cocoapods-assets-cleaner/assets_cleaner'

include CocoapodsAssetsCleaner

module Pod
  class Command

    class CleanUnusedAssets < Command
      self.summary = 'Cocoapods-plugin that helps to clean unused assets on Xcode projects.'

      self.description = <<-DESC
        Assets-cleaner is a Cocoapods-plugin that helps to clean unused assets on Xcode projects.
      DESC

      def validate!
        super
        help! 'Define the assets path.' unless @assets_path
      end

      self.arguments = []

      def self.options
        [
          ['--assets-path', 'Assets path'],
          ['--project-path', 'Projects path (default: ./)'],
          ['--exclude-dir', 'Define a directory to exclude from asset use search. (default: {project-path - assets-path: Assets.xcassets})']
        ].concat(super)
      end

      def initialize(argv)
        @assets_path = argv.option('assets-path')
        @project_path = argv.option('project-path', './')
        @excluded_dir = argv.option('exclude-dir', 'Assets.xcassets')
        super
      end

      def run
        excluded_dir = @excluded_dir || @assets_path.gsub(@project_path, "")
        if excluded_dir[0] == "/"
          excluded_dir[0] = ""
        end

        assets_cleaner = CocoapodsAssetsCleaner::AssetsCleaner.new(@project_path, @assets_path, excluded_dir)
        assets_cleaner.init_clean()
      end
    end
  end
end
