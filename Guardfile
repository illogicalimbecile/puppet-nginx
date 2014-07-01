# A sample Guardfile
# More info at https://github.com/guard/guard#readme

notification :growl

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
  watch('spec/spec.opts')       { "spec" }
  watch(%r{^manifests/.+\.rb$}) { "spec" }
  watch(%r{^templates/.+\.rb$}) { "spec" }
  watch(%r{^lib/.+\.rb$})       { "spec/functions" }
end
