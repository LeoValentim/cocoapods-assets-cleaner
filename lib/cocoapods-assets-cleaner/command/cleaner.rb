require 'cocoapods'
require 'cocoapods-assets-cleaner/assets_cleaner'

include CocoapodsAssetsCleaner

module Pod
  class Command

    class Cleaner < Command
      self.summary = 'Short description of cocoapods-assets-cleaner.'

      self.description = <<-DESC
        Longer description of cocoapods-assets-cleaner.
      DESC

      # self.arguments = 'NAME'

      # def initialize(argv)
      #   @name = argv.shift_argument
      #   super
      # end

      # def validate!
      #   super
      #   help! 'A Pod name is required.' unless @name
      # end

      self.arguments = []

      def run
        #UI.puts "Add your implementation for the cocoapods-assets-cleaner plugin in #{__FILE__}"
        CocoapodsAssetsCleaner::AssetsCleaner.new.clean()
      end
    end
  end
end
