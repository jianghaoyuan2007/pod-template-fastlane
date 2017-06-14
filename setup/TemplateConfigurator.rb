require 'fileutils'
require 'colored2'
require 'find'

module Pod

  class TemplateConfigurator
  	
  	attr_reader :pod_name, :homepage, :git_source

  	def initialize(pod_name)
      @pod_name = pod_name
      @message_bank = MessageBank.new(self)
    end

 	  def ask(question)
      answer = ""
      loop do
        puts "\n#{question}?"

        @message_bank.show_prompt
        answer = gets.chomp

        break if answer.length > 0

        print "\nYou need to provide an answer."
      end
      answer
    end

	  def run

      # @homepage = self.ask("What is your homepage").to_sym

      # @git_source = self.ask("What is your git source").to_sym

      remove_podfile_lock

      replace_variables_in_files

      rename_template_files

      reinitialize_git_repo
      
      run_pod_install
    end

    def remove_podfile_lock

      `rm -rf Podfile.lock`
    end

    def rename_template_files

      FileUtils.mv "POD_NAME.podspec", "#{@pod_name}.podspec"
      
      FileUtils.mv "Sources/POD_NAME.h", "Sources/#{@pod_name}.h"

      FileUtils.mv "POD_NAME.xcodeproj", "#{@pod_name}.xcodeproj"
      
      # FileUtils.mv "#{@pod_name}.xcodeproj/xcshareddata/xcschemes/POD_NAME.xcscheme", "#{@pod_name}.xcodeproj/xcshareddata/xcschemes/#{@pod_name}.xcscheme"
            
      # FileUtils.mv "#{@pod_name}.xcodeproj/xcshareddata/xcschemes/POD_NAMETests.xcscheme", "#{@pod_name}.xcodeproj/xcshareddata/xcschemes/#{@pod_name}Tests.xcscheme"
      
      FileUtils.mv "POD_NAMETests", "#{@pod_name}Tests"
      
      FileUtils.mv "#{@pod_name}Tests/POD_NAMETests.m", "#{@pod_name}Tests/#{@pod_name}Tests.m"
    end

    def replace_variables_in_files

      file_names = self.replace_variables_files
      	
	    file_names.each do |file_name|
        text = File.read(file_name)
        text.gsub!("${POD_NAME}", @pod_name)
        File.open(file_name, "w") { |file| file.puts text }
      end	

    end

    def replace_variables_files

	    file_names = ['POD_NAME.podspec', 'CHANGELOG.md', 'LICENSE', 'Podfile']

	    dirs = ['Example', 'POD_NAMETests', 'Sources', 'POD_NAME.xcodeproj', 'fastlane']

	    dirs.each do |dir|
  		  Find.find(dir) do |file_name|
  		    if File.file?(file_name)	
    	      file_names << file_name
    	    end
  	    end
	    end

	    return file_names
    end

    def reinitialize_git_repo
      `rm -rf .git`
      `git init`
      `git add -A`
    end

    def run_pod_install
      puts "\nRunning " + "pod install".magenta + " on your new library."
      puts ""

      system "pod install"

      `git add -A`
      `git commit -m "Initial commit"`
    end

  end

end























