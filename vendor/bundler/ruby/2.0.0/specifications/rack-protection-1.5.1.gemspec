# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rack-protection"
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Konstantin Haase", "Alex Rodionov", "Patrick Ellis", "Jeff Welling", "ITO Nobuaki", "Matteo Centenaro", "David Kellum", "Egor Homakov", "Florian Gilcher", "Fojas", "Mael Clerambault", "Martin Mauch", "SAKAI, Kazuaki", "Stanislav Savulchik", "Steve Agalloco", "TOBY", "Akzhan Abdulin", "brookemckim", "Bj\u{f8}rge N\u{e6}ss", "Chris Heald", "Chris Mytton", "Corey Ward", "Dario Cravero"]
  s.date = "2013-10-21"
  s.description = "You should use protection!"
  s.email = ["konstantin.mailinglists@googlemail.com", "p0deje@gmail.com", "patrick@soundcloud.com", "jeff.welling@gmail.com", "bugant@gmail.com", "daydream.trippers@gmail.com", "homakov@gmail.com", "florian.gilcher@asquera.de", "developer@fojasaur.us", "mael@clerambault.fr", "martin.mauch@gmail.com", "kaz.july.7@gmail.com", "s.savulchik@gmail.com", "steve.agalloco@gmail.com", "toby.net.info.mail+git@gmail.com", "akzhan.abdulin@gmail.com", "brooke@digitalocean.com", "bjoerge@bengler.no", "cheald@gmail.com", "self@hecticjeff.net", "coreyward@me.com", "dario@uxtemple.com", "dek-oss@gravitext.com"]
  s.homepage = "http://github.com/rkh/rack-protection"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "You should use protection!"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
  end
end
