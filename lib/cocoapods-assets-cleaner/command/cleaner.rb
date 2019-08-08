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
          ['--project-path', 'Projects path (default: ./)']
        ].concat(super)
      end

      def initialize(argv)
        @assets_path = argv.option('assets-path')
        @project_path = argv.option('project-path', './')
        super
      end

      def run
        assets_cleaner = CocoapodsAssetsCleaner::AssetsCleaner.new(@project_path, @assets_path)
        assets_cleaner.init_clean()
      end
    end
  end
end
