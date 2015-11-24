# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ai_games/four_in_a_row/version'

Gem::Specification.new do |spec|
  spec.name          = 'ai_games-four_in_a_row'
  spec.version       = AIGames::FourInARow::VERSION
  spec.authors       = ['Jan David Nose']
  spec.email         = ['jandavid@awesometechnology.de']

  spec.summary       = <<-EOF
    Framework and starter bot for The AI Games' 'Four in a Row' competition"
EOF
  spec.description   = <<-EOF
This gem provides a framework that can be used to implement a bot for The
AI Games' competition 'Four in a Row'. It handles the communication with the
game engine, so that you can focus on your bot.
  EOF
  spec.homepage      = 'https://github.com/jdno/ai_games-four_in_a_row'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ai_games-logger', '~> 0.1'
  spec.add_runtime_dependency 'ai_games-parser', '~> 0.1'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'rubocop', '~> 0.35'
end
