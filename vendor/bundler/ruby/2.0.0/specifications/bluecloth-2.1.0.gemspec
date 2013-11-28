# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bluecloth"
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Granger"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDLDCCAhSgAwIBAgIBADANBgkqhkiG9w0BAQUFADA8MQwwCgYDVQQDDANnZWQx\nFzAVBgoJkiaJk/IsZAEZFgdfYWVyaWVfMRMwEQYKCZImiZPyLGQBGRYDb3JnMB4X\nDTEwMDkxNjE0NDg1MVoXDTExMDkxNjE0NDg1MVowPDEMMAoGA1UEAwwDZ2VkMRcw\nFQYKCZImiZPyLGQBGRYHX2FlcmllXzETMBEGCgmSJomT8ixkARkWA29yZzCCASIw\nDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALy//BFxC1f/cPSnwtJBWoFiFrir\nh7RicI+joq/ocVXQqI4TDWPyF/8tqkvt+rD99X9qs2YeR8CU/YiIpLWrQOYST70J\nvDn7Uvhb2muFVqq6+vobeTkILBEO6pionWDG8jSbo3qKm1RjKJDwg9p4wNKhPuu8\nKGue/BFb67KflqyApPmPeb3Vdd9clspzqeFqp7cUBMEpFS6LWxy4Gk+qvFFJBJLB\nBUHE/LZVJMVzfpC5Uq+QmY7B+FH/QqNndn3tOHgsPadLTNimuB1sCuL1a4z3Pepd\nTeLBEFmEao5Dk3K/Q8o8vlbIB/jBDTUx6Djbgxw77909x6gI9doU4LD5XMcCAwEA\nAaM5MDcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0OBBYEFJeoGkOr9l4B\n+saMkW/ZXT4UeSvVMA0GCSqGSIb3DQEBBQUAA4IBAQBG2KObvYI2eHyyBUJSJ3jN\nvEnU3d60znAXbrSd2qb3r1lY1EPDD3bcy0MggCfGdg3Xu54z21oqyIdk8uGtWBPL\nHIa9EgfFGSUEgvcIvaYqiN4jTUtidfEFw+Ltjs8AP9gWgSIYS6Gr38V0WGFFNzIH\naOD2wmu9oo/RffW4hS/8GuvfMzcw7CQ355wFR4KB/nyze+EsZ1Y5DerCAagMVuDQ\nU0BLmWDFzPGGWlPeQCrYHCr+AcJz+NRnaHCKLZdSKj/RHuTOt+gblRex8FAh8NeA\ncmlhXe46pZNJgWKbxZah85jIjx95hR8vOI+NAM5iH9kOqK13DrxacTKPhqj5PjwF\n-----END CERTIFICATE-----\n"]
  s.date = "2011-03-12"
  s.description = "BlueCloth is a Ruby implementation of John Gruber's [Markdown][markdown], a\ntext-to-HTML conversion tool for web writers. To quote from the project page:\nMarkdown allows you to write using an easy-to-read, easy-to-write plain text\nformat, then convert it to structurally valid XHTML (or HTML).\n\nIt borrows a naming convention and several helpings of interface from\n[Redcloth][redcloth], Why the Lucky Stiff's processor for a similar\ntext-to-HTML conversion syntax called [Textile][textile].\n\nBlueCloth 2 is a complete rewrite using David Parsons' [Discount][discount]\nlibrary, a C implementation of Markdown. I rewrote it using the extension for\nspeed and accuracy; the original BlueCloth was a straight port from the Perl\nversion that I wrote in a few days for my own use just to avoid having to\nshell out to Markdown.pl, and it was quite buggy and slow. I apologize to all\nthe good people that sent me patches for it that were never released.\n\nNote that the new gem is called 'bluecloth' and the old one 'BlueCloth'. If\nyou have both installed, you can ensure you're loading the new one with the\n'gem' directive:\n\n\t# Load the 2.0 version\n\tgem 'bluecloth', '>= 2.0.0'\n\t\n\t# Load the 1.0 version\n\tgem 'BlueCloth'\n\trequire 'bluecloth'"
  s.email = ["ged@FaerieMUD.org"]
  s.executables = ["bluecloth"]
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["Manifest.txt", "History.md"]
  s.files = ["bin/bluecloth", "Manifest.txt", "History.md", "ext/extconf.rb"]
  s.homepage = "http://deveiate.org/projects/BlueCloth"
  s.licenses = ["BSD"]
  s.rdoc_options = ["--title", "Bluecloth Documentation", "--quiet"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "bluecloth"
  s.rubygems_version = "2.0.14"
  s.summary = "BlueCloth is a Ruby implementation of John Gruber's [Markdown][markdown], a text-to-HTML conversion tool for web writers"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe-mercurial>, ["~> 1.2.1"])
      s.add_development_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_development_dependency(%q<tidy-ext>, ["~> 0.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.4"])
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.7"])
      s.add_development_dependency(%q<hoe>, [">= 2.9.1"])
    else
      s.add_dependency(%q<hoe-mercurial>, ["~> 1.2.1"])
      s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_dependency(%q<tidy-ext>, ["~> 0.1"])
      s.add_dependency(%q<rspec>, ["~> 2.4"])
      s.add_dependency(%q<rake-compiler>, ["~> 0.7"])
      s.add_dependency(%q<hoe>, [">= 2.9.1"])
    end
  else
    s.add_dependency(%q<hoe-mercurial>, ["~> 1.2.1"])
    s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
    s.add_dependency(%q<tidy-ext>, ["~> 0.1"])
    s.add_dependency(%q<rspec>, ["~> 2.4"])
    s.add_dependency(%q<rake-compiler>, ["~> 0.7"])
    s.add_dependency(%q<hoe>, [">= 2.9.1"])
  end
end
