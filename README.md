# cocoapods-assets-cleaner

Assets-cleaner is a cocoapods-plugin that helps to clean assets from unused images on Xcode projects.

## Getting Started

### Installation

    $ gem install cocoapods-assets-cleaner
    
#### Or with Bundler:

* Install Bundler:

    `$ gem install bundler`
    
* Create a `Gemfile` in the project root folder and add this line to it:

    `gem 'cocoapods-assets-cleaner'`
    
* Run the Bundler installation command:

    `$ bundle install`


## Usage

Run `pod clean-unused-assets` command with `--assets-path` to indicate where is Assets.xcassets on your project:

    $ pod clean-unused-assets --assets-path=./path/to/Assets.xcassets
    
You can also define a specific directory for the plugin to search for unused assets. Just add  `--project-path`:

    $ pod clean-unused-assets --assets-path=./path/to/Assets.xcassets --project-path=./optional/path/
    
Use `--exclude-dir` define a directory to exclude from asset use search. (default: {project-path - assets-path: Assets.xcassets}):

    $ pod clean-unused-assets --assets-path=./path/to/Assets.xcassets --project-path=./optional/path/ --exclude-dir=path/to/exclude/dir/relative/to/projectpath
