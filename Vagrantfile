targets = {
  "debian7" => {
    "box" => "bento/debian-7.9"
  },
  "debian8" => {
    "box" => "bento/debian-8.2"
  },
  "centos6.5" => {
    "box" => "bento/centos-6.7"
  },
  "centos7.1"   => {
    "box" => "bento/centos-7.1"
  },
  "ubuntu12"  => {
    "box" => "ubuntu/precise64"
  },
  "ubuntu14"  => {
    "box" => "ubuntu/trusty64"
  },
  "ubuntu16"  => {
    "box" => "bento/ubuntu-16.04"
  }
}

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    if ENV['OSQUERY_BUILD_CPUS']
      v.cpus = ENV['OSQUERY_BUILD_CPUS'].to_i
    else
      v.cpus = 1
    end
    v.memory = 1024
  end

  targets.each do |name, target|
    box = target["box"]
    config.vm.define name do |build|
      build.vm.box = box
      build.vm.provision :shell, path: "./provision/#{name}.sh"
    end
  end
end
