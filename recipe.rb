USER = ENV["USER_NAME"] || 'root'

package "git"

execute "Purge any older repositories." do
  command("sudo apt-get purge lxc-docker*")
  command("sudo apt-get purge docker.io*")
end

execute "Update package information" do
  command("sudo apt-get update")
  command("sudo apt-get install -y apt-transport-https ca-certificates")
end

execute "Add the new GPG key" do
  command("sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D")
end

execute "Add source list" do
  command("sudo touch /etc/apt/sources.list.d/docker.list")
  command("sudo echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/sources.list.d/docker.list")
end

execute "Update the APT package index" do
  command("apt-get update")
end

execute "Verify that APT is pulling from the right repository" do
  command("apt-cache policy docker-engine")
end

execute "Update and upgrade apt package" do
  command("sudo apt-get update")
  command("sudo apt-get -y upgrade")
end

execute "Install docker" do
  command("sudo apt-get install -y docker-engine")
end

service "docker" do
  action :start
end

execute "Install docker-compose" do
  command("sudo curl -L https://github.com/docker/compose/releases/download/1.6.2/run.sh > /usr/local/bin/docker-compose")
end

execute "Change docker-compose permission" do
  command("sudo chmod +x /usr/local/bin/docker-compose")
end

git "/home/#{USER}/docker-jiji2" do
  repository "https://github.com/unageanu/docker-jiji2.git"
  user USER
end

git "/home/#{USER}/letsencrypt" do
  repository "https://github.com/letsencrypt/letsencrypt.git"
  user USER
end

execute "Run letsencrypt help command" do
  command("/home/#{USER}/letsencrypt/letsencrypt-auto --help")
  user USER
end
