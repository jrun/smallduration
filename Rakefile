require 'config/requirements'
require 'config/hoe' # setup Hoe + all gem configuration

Dir['tasks/**/*.rake'].each { |rake| load rake }

namespace :gem do
  desc "Repackage gem, uninstall and install again"
  task :refresh => :repackage do
    system "sudo gem uninstall smallduration -v #{VERS}"
    system "sudo gem install pkg/smallduration-#{VERS}.gem"
  end
  
  desc "Create a gemspec file"
  task :spec do
    File.open("#{GEM_NAME}.gemspec", "w") do |file|
      file.puts $hoe.spec.to_ruby
    end
  end
end

