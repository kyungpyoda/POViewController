Pod::Spec.new do |spec|
  spec.name         = "POViewController"
  spec.version      = "1.0.0"
  spec.summary      = "Pio's Awesome Customizable ViewController"
  spec.homepage     = "https://github.com/kyungpyoda/POViewController"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "kyungpyoda" => "rudvy9620@gmail.com" }

  spec.source       = { :git => "https://github.com/kyungpyoda/POViewController.git",
			:tag => spec.version.to_s }
  spec.source_files  = "Sources/POViewController/*.swift"

  spec.swift_version = "5.5"
  spec.ios.deployment_target = "13.0"
end

