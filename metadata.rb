name             'docker-images'
maintainer       'Clinton Freeman'
maintainer_email 'YOUR_EMAIL'
license          'The MIT License'
description      'Installs/Configures docker-image'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports		 'ubuntu'
recipe			 'docker-images', 'Pulls docker images and creates matching containers from metadata specified in node attributes'
