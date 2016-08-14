require 'spec_helper'

describe 'lampstack::default' do

	describe command('curl http://localhost:80') do
  		its(:stdout) { should match /apache2/ }
  	end

	describe package ('apache2') do
		it { should be_installed }
	end

	describe service('apache2') do
  		it { should be_running }
	end

	describe service('apache2') do
  		it { should be_enabled }
	end

	# tests for the virtual file to exists

	describe file('/etc/apache2/sites-available/example.org.conf') do
  		it { should exist }
	end

	describe file('/var/www/html/example.org/public_html') do
  		it { should be_directory }
  		it { should exist }
	end

	describe file('/var/www/html/example.org/logs') do
  		it { should be_directory }
  		it { should exist }
	end

	describe file('/etc/apache2/mods-available/mpm_event.conf') do
  		it { should be_file }
  		it { should be_mode 644}
	end

	describe command('cat /etc/apache2/mods-available/mpm_event.conf') do
  		its(:stdout) { should match /MaxConnectionsPerChild  3000/ }
  	end
	
end
