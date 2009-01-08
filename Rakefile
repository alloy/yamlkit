desc "Default task is YAMLKit:build"
task :default => "YAMLKit:build"

desc "Clean builds and ext sources"
task :clean do
  sh "rm -rf build ext"
end

namespace :libYAML do
  LIB_YAML_VERSION = "0.1.2"
  URL = "http://pyyaml.org/download/libyaml/yaml-#{LIB_YAML_VERSION}.tar.gz"
  FILE = File.basename(URL)
  DIR = File.basename(URL, '.tar.gz')
  
  directory 'ext'
  
  desc "Downloads and unpacks the sources"
  task :fetch => :ext do
    sh "cd ext && curl -O #{URL} && tar -zxvf #{FILE}"
  end
  
  desc "Builds libYAML"
  task :build => :fetch do
    sh "cd ext/#{DIR} && CFLAGS='-arch x86_64' ./configure && make"
  end
  
  desc "Installs libYAML in /usr/local"
  task :install do
    sh "cd ext/#{DIR} && make install"
  end
end

namespace :YAMLKit do
  INSTALL_DIR = '/Library/Frameworks'
  
  desc "Builds YAMLKit"
  task :build do
    sh "xcodebuild -target YAMLKit -configuration Release"
  end
  
  desc "Installs YAMLKit in #{INSTALL_DIR}"
  task :install do
    sh "cp -R build/Release/YAMLKit.framework #{INSTALL_DIR}"
  end
  
  desc "Run the YAMLKit test suite"
  task :test do
    sh "xcodebuild -target 'Run Tests' -configuration Release"
  end
end