#!/usr/bin/env ruby
# frozen_string_literal: true

# Generate release notes template from pod update changes
# Usage: ./scripts/generate_release_notes.rb <version> [pod_changes_summary.txt]

require 'json'
require_relative 'parse_pod_update'

def read_podfile_lock
  return {} unless File.exist?('Podfile.lock')

  podfile_lock = File.read('Podfile.lock')
  versions = {}

  # Extract framework versions
  podfile_lock.scan(/^  - ([^\/\s]+)(?:\/[^\s]+)?\s+\(([^)]+)\):?/) do |name, version_str|
    if match = version_str.match(/([\d.\-\w]+)/)
      versions[name] = match[1]
    end
  end

  versions
end

def generate_release_notes(version, pod_changes_file = nil)
  # Read component changes if available
  changes_summary = if pod_changes_file && File.exist?(pod_changes_file)
    File.read(pod_changes_file).strip
  else
    "- Update to MLKit #{version}"
  end

  # Read current framework versions
  framework_versions = read_podfile_lock

  # Extract key framework versions
  mlkit_frameworks = {
    'MLKitLanguageID' => framework_versions['MLKitLanguageID'],
    'MLKitTranslate' => framework_versions['MLKitTranslate'],
    'MLKitSmartReply' => framework_versions['MLKitSmartReply'],
    'MLKitTextRecognition' => framework_versions['MLKitTextRecognition'],
    'MLKitNaturalLanguage' => framework_versions['MLKitNaturalLanguage'],
    'MLKitCommon' => framework_versions['MLKitCommon'],
    'GoogleToolboxForMac' => framework_versions['GoogleToolboxForMac']
  }.compact

  # Build release notes
  notes = []
  notes << "# MLKit #{version}"
  notes << ""
  notes << "## What's Changed"
  notes << ""
  notes << changes_summary
  notes << ""

  # Add dependency versions
  deps = {
    'GoogleDataTransport' => framework_versions['GoogleDataTransport'],
    'GoogleUtilities' => framework_versions['GoogleUtilities'],
    'GTMSessionFetcher' => framework_versions['GTMSessionFetcher'],
    'nanopb' => framework_versions['nanopb'],
    'PromisesObjC' => framework_versions['PromisesObjC']
  }.compact

  unless deps.empty?
    notes << "## Dependencies"
    notes << ""
    deps.each do |name, ver|
      notes << "- #{name}: #{ver}"
    end
    notes << ""
  end

  # Add framework versions
  unless mlkit_frameworks.empty?
    notes << "## Framework Versions"
    notes << ""
    mlkit_frameworks.each do |name, ver|
      notes << "- #{name}: #{ver}"
    end
    notes << ""
  end

  # Add XCFrameworks list
  notes << "## XCFrameworks"
  notes << ""
  notes << "This release includes the following assets:"
  notes << "- MLKitLanguageID.xcframework.zip"
  notes << "- MLKitTranslate.xcframework.zip"
  notes << "- MLKitSmartReply.xcframework.zip"
  notes << "- MLKitTextRecognition.xcframework.zip"
  notes << "- MLKitTextRecognitionCommon.xcframework.zip"
  notes << "- MLImage.xcframework.zip"
  notes << "- MLKitVision.xcframework.zip"
  notes << "- MLKitNaturalLanguage.xcframework.zip"
  notes << "- MLKitXenoCommon.xcframework.zip"
  notes << "- MLKitCommon.xcframework.zip"
  notes << "- GoogleToolboxForMac.xcframework.zip"
  notes << "- SSZipArchive.xcframework.zip"
  notes << ""

  notes << "## Installation"
  notes << ""
  notes << "See [README.md](https://github.com/d-date/google-mlkit-swiftpm/blob/main/README.md) for installation instructions."
  notes << ""
  notes << "🤖 Generated with [Claude Code](https://claude.com/claude-code)"

  notes.join("\n")
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  unless ARGV[0]
    puts "Usage: #{File.basename($PROGRAM_NAME)} <version> [pod_changes_summary.txt]"
    puts "Example: #{File.basename($PROGRAM_NAME)} 9.0.0 pod_changes_summary.txt"
    exit 1
  end

  version = ARGV[0]
  pod_changes_file = ARGV[1]

  # Validate version format. Accept an optional SemVer pre-release suffix
  # (e.g. "9.0.0-1") for wrapper repackages.
  unless version =~ /^\d+\.\d+\.\d+(-[0-9A-Za-z.-]+)?$/
    puts "Error: Invalid version format '#{version}'"
    puts "Expected semantic versioning format: X.Y.Z[-PRERELEASE]"
    exit 1
  end

  begin
    notes = generate_release_notes(version, pod_changes_file)
    puts notes

    # Save to file
    output_file = "release_notes_#{version}.md"
    File.write(output_file, notes)
    puts "\n✓ Release notes saved to #{output_file}"
  rescue => e
    puts "Error: #{e.message}"
    puts e.backtrace if ENV['DEBUG']
    exit 1
  end
end
