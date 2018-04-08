# 1. Sample Podspec

This project demonstrates creation and linting (dry run consumption) of a pod framework.

Reference: http://www.yudiz.com/creating-your-own-ios-framework-and-distributed-using-cocoapods/

<!-- TOC -->

- [1. Sample Podspec](#1-sample-podspec)
	- [1.1. Prerequisites](#11-prerequisites)
	- [1.2. Creation](#12-creation)
	- [1.3. Dry Run Consumption](#13-dry-run-consumption)
		- [1.3.1. Example URL](#131-example-url)
		- [1.3.2. Remote Tag Not Found](#132-remote-tag-not-found)
		- [1.3.3. Unable to Read License](#133-unable-to-read-license)
		- [1.3.4. Version Mismatch](#134-version-mismatch)
		- [1.3.5. Swift Version](#135-swift-version)
		- [1.3.6. Deployment Target](#136-deployment-target)

<!-- /TOC -->

## 1.1. Prerequisites

Tested on below configuration
- Mac OS X 10.12 Sierra 
- XCode 9.2

Make sure cocoapods is installed.

```
gem install cocoapods
```

NOTE: `brew` version is outdated, use `gem`

## 1.2. Creation

Create the pod spec 

```
pod spec create YLogging
```

Fill in the details as below:

```ruby
...
Pod::Spec.new do |s|

  s.name         = "YLogging"
  s.version      = "0.0.1"
  s.summary      = "Logging framework for the Generation Y"

  s.description  = <<-DESC
    Allows us to conditionally log messages based on a debug flag.
                   DESC

  s.homepage     = "http://github.com/vijayvepa/YLogging"

  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author             = { "Vijay Vepakomma" => "vijay.vepakomma@philips.com" }
  
  s.source_files  = "YLogging", "YLogging/**/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"

end

```

- Make sure `version`, `license`, `source` and `source_files` are accurate.




## 1.3. Dry Run Consumption 

Dry run the consumption by running the following command

```
pod spec lint

```


### 1.3.1. Example URL

ERROR:
```
source: The Git source still contains the example URL.
```
See [here](ScreenLogs/1.LintFirstPass.log) for details.

FIX: Change the source repo as below:

```ruby
  s.source       = { :git => "https://github.com/vijayvepa/YLogging.git", :tag => "0.0.2" }
```

### 1.3.2. Remote Tag Not Found 

ERROR:
```
Remote branch v0.0.1 not found in upstream origin
```

See [here](ScreenLogs/2.LintSecondPass.log) for details.


The repository needs to exist and the tag on the repository needs to exist as well.

```
git tag v0.0.1
git push --tags
```

### 1.3.3. Unable to Read License

ERROR:
```
Unable to read license file
```
See [here](ScreenLogs/3.LicenseMissing.log) for details.

FIX:

- Add a LICENSE.md file and push to the repo.
- Set a new tag and push the tag as well

```
git tag 0.0.2
git push --tags
```

NOTE: Tried just removing the license field but got [this](ScreenLogs/4.RemoveLicense.log) error


### 1.3.4. Version Mismatch

ERROR:
```
WARN  | source: The version should be included in the Git tag.
```

FIX:

Change the `version` in podspec to match git tag as below:

```ruby
  s.version      = "0.0.2"
```

### 1.3.5. Swift Version

ERROR:

```
    - WARN  | swift: The validator used Swift 3.2 by default because no Swift version was specified. To specify a Swift version during validation, add the `swift_version` attribute in your podspec. Note that usage of the `--swift-version` parameter or a `.swift-version` file is now deprecated.
```

FIX:

Update the `swift_version` as below:

```ruby
  s.swift_version = "4.0"
```

### 1.3.6. Deployment Target

ERROR:

```
    - ERROR | [iOS] swift: Swift support uses dynamic frameworks and is therefore only supported on iOS > 8.
```

Fix:

```ruby
  s.ios.deployment_target = "9.0"
```

Other Notes:

Tried the following change but didn't help. See [here](ScreenLogs/6.PlatformVersion.log) for details.

```ruby
   s.platform     = :ios, "9.0"
```


After above changes, pod spec lint output is as below:

```
MACC02RR83AG8WP:YLogging vijayvepakomma$ pod spec lint 

 -> YLogging (0.0.2)

Analyzed 1 podspec.

YLogging.podspec passed validation.
```