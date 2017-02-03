targets = {
  "ubuntu12"  => {
    "box" => "ubuntu/precise64"
  },
  "ubuntu14"  => {
    "box" => "ubuntu/trusty64"
  },
  "ubuntu16"  => {
    "box" => "ubuntu/xenial64"
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
      build.vm.provision :shell, path: "./provision/#{name}/base.sh"
    end
  end
end
