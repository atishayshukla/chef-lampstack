# Install Apache2 package using package resource


# Default action is to install
package 'apache2'

# Start the service once installed

service 'apache2' do	
	action [:start, :enable]	
	#subscribes :reload, 'template["/etc/apache2/sites-available/#{sitename}.conf"]', :immediately
end

# Virtual Host file

node["lampstack"]["sites"].each do |sitename,data|
	document_root = "/var/www/html/#{sitename}"

	directory document_root do
		mode "0755"
		recursive true
	end

	execute "enable-sites" do
    command "a2ensite #{sitename}"
    action :nothing
  end

	template "/etc/apache2/sites-available/#{sitename}.conf" do
    source "virtualhosts.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => data["port"],
      :serveradmin => data["serveradmin"],
      :servername => data["servername"]
    )
    notifies :run, "execute[enable-sites]"
    notifies :restart, "service[apache2]"    
  end
  
  directory "/var/www/html/#{sitename}/public_html" do
    action :create
  end

  directory "/var/www/html/#{sitename}/logs" do
    action :create
  end

end

#Apache Configuration

execute "keepalive" do
  command "sed -i 's/KeepAlive On/KeepAlive Off/g' /etc/apache2/apache2.conf"
  action :run
end

execute "enable-event" do
  command "a2enmod mpm_event"
  action :nothing
end

cookbook_file "/etc/apache2/mods-available/mpm_event.conf" do
  source "mpm_event.conf"
  mode "0644"
  notifies :run, "execute[enable-event]"
end

