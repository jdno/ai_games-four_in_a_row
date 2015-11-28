# AIGames::FourInARow

Library and starter bot for [The AI Games'](http://theaigames.com) new
competition [Four in a Row](http://theaigames.com/competitions/four-in-a-row/).

## Dependencies

This gem relies on:

- **[AIGames::Logger](https://github.com/jdno/ai_games-logger)**
- **[AIGames::Parser](https://github.com/jdno/ai_games-parser)**

Install these gems before trying to run **AIGames::FourInARow**

## Installation

Since [The AI Games'](http://theaigames.com) environment does not support gems
yet, you have to download and extract the library yourself.

There are two ways to do this: manually and semi-manually. To do it manually,
download the ZIP archive of this repository, and copy the _lib/_ folder into
the folder in which you have your bot. Or follow the more convenient method to
get the most up-to-date version from [RubyGems](http://rubygems.org).

### From RubyGems

To download the most current version of the library, enter the following command
in the shell of your choice:

```bash
gem fetch ai_games-four_in_a_row
```

Next, extract the gem to get its source code. Replace VERSION with the gem's
actual version (e.g. 0.4.0):

```bash
gem unpack ai_games-four_in_a_row-VERSION.gem
```

And last but not least, copy the library into the _lib/_ directory:

```bash
cp -r ai_games-four_in_a_row-VERSION/lib .
```

If you want, you can clean up your folder by deleting both the gem and the
extracted folder now:

```bash
rm ai_games-four_in_a_row-VERSION.gem
rm -r ai_games-four_in_a_row-VERSION
```

## Usage

To be able to use the library, your bot must require it. Add the following line
at the top of your bot's file:

```ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
```

Now, you can use the library just like you would've if you installed it as a
gem.

When **uploading your bot**, remember to include the _lib/_ directory in the
archive!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jdno/ai_games-four_in_a_row. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
