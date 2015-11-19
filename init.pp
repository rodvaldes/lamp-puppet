class lamp {
	
	#actualizar repos de yum
	exec { 'yum-makecache':
	command => '/usr/bin/yum makecache',
	}
	
	#APACHE==================
	#========================
	
	#instalar package de apache, requiere actualizar repos de yum
	package { 'httpd':
		require => 'Exec['yum-makecache']',
		ensure => 'present',
	}
	
	#iniciar servicio de apache, requiere package de apache
	service { 'httpd':
		require => 'Package['httpd']',
		ensure => 'running',
		enable => true,
	}
	
	#MARIA-SQL ============
	#======================
	
	#instalar package MariaDB, requiere actualizar repos de yum
	package { 'mariadb':
		require => 'Exec['yum-makecache']',
		ensure => 'present',
	}

	#instalar package MariaDB-server, requiere packete mariadb y actualizar repos de yum	
	package { 'mariadb-server':
		require => 'Exec['yum-makecache']',
		require => 'Package['mariadb']',
		ensure => 'present',
	}
	
	#iniciar servicio mysql, requiere package mariadb y mariadb-server
	service { 'mariadb':
		require => 'Package['mariadb']',
		require => 'Package['mariadb-server']',
		ensure => 'running',
		enable => 'true',
	}
	
	#PHP ============
	#======================
	
	#instalar package php, requiere actualizar repos de yum
	package { 'php':
		require => 'Exec['yum-makecache']',
		ensure => 'present',
	}
	
	#instalar package php-mysql, requiere actualizar repos de yum
	package { 'php-mysql':
		require => 'Exec['yum-makecache']',
		ensure => 'present',
	}
}