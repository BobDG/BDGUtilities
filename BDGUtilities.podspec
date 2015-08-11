Pod::Spec.new do |s|
  s.name           	= 'BDGUtilities'
  s.version        	= '0.0.27'
  s.summary        	= 'xCode Utilities'
  s.homepage       	= 'https://github.com/BobDG/BDGUtilities'
  s.authors        	= {'Bob de Graaf' => 'graafict@gmail.com'}
  s.license 		= 'MIT'
  s.source         	= { :git => 'https://github.com/BobDG/BDGUtilities.git', :tag => '0.0.27' }
  s.source_files   	= '**/*.{h,m}'
  s.resources          = ['**/*.{png}', '**/*.lproj']
  s.frameworks 	    	= 'StoreKit', 'CoreLocation', 'MessageUI', 'OpenAl', 'AVFoundation', 'AudioToolbox'
  s.weak_frameworks	= 'Social'
  s.platform       	= :ios
  s.requires_arc   	= true
end
