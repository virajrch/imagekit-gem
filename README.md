# Imagekit

Imagekit provides intelligent real time image optimization, resizing, cropping and super fast delivery.

Imagekit offers comprehensive APIs and administration capabilities and is easy to integrate with any web application, existing or new.

Imagekit provides URL and HTTP based APIs that can be easily integrated with any Web development framework. 

For Ruby on Rails, Imagekit provides a GEM for simplifying the integration even further.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imagekit', github: 'imagekit-developer/imagekit-gem'
```

And then execute:

    $ bundle

And then run generator:

    $ rails generate imagekit:install

Or install it yourself as:

    $ gem install imagekit

## Try it right away

Sign up for a [free account](https://imagekit.io/registration) so you can try out image transformations and seamless image delivery through CDN.

## Usage

For plenty of transformation options, see our [image transformations documentation](https://docs.imagekit.io/#transformations).

### Configuration

Login to your imagekit dashboard and find the `public key`, `private key` and `imagekit id`(Imagekit id is your account id).

After executing of the gerenrator command `rails generate imagekit:install`, you will get a file named as `imagekit.rb` under `config/initializers`.

Replace the corresponding values

```
Imagekit.configure do |config|
  config.public_key =  'E/bDwTissZtxxxxxxxxxxxxxxxxx'
  config.private_key = 'WMXM/R+8g8Lxxxxxxxxxxxxxxxxx'
  config.imagekit_id = 'b1wxxxxxx'
end

```

### Embedding and transforming images

Any image uploaded to Imagekit can be transformed and embedded using powerful view helper methods:

The following example generates an image of an uploaded `default-image` image while transforming it to crop a 100x150 rectangle:

```
im_image_tag("https://ik.imagekit.io/demo/default-image.jpg", transformation: { height: 150, width: 100 })
```

The following example generates an image of an uploaded `default-image` image while change the image quality to 80:

```
im_image_tag("https://ik.imagekit.io/demo/default-image.jpg", transformation: { quality: 80 })
```

Here are the possible transformation options with valid values.
```
1.  height
2.  width
3.  crop (Valid values: maintain_ratio, force, at_least, at_max)
4.  quality (Valid values: 0-100)
5.  format (Valid values: auto, webp, jpg, jpeg, png)
6.  progressive_jpeg (Valid values: true, false)
7.  image_metadata (Valid Values: true, false)
8.  color_profile (Valid Values: true, false)
9.  rotate (Valid Values: 0, 90, 180, 270, 360, auto)
10. radius (Valid Values: any positive integer or “max”)
11. background (Valid Values: a valid RGB hex code Default: Black (000000))
12. blur (Valid Values: Integers from 1 to 100)
13. border (A valid value would look like b-10_FF0000. This would add a constant border of 10px with color code #FF0000 around the image. If the original image dimension is 200x200, then after applying the border, the dimensions would be 220x220.)
14. dpr (Valid Values: 0.1 to 5.0)
15. overlay_image (Valid value: any uploaded image e.g. http://ik.imagekit.io/demo/logo-white_SJwqB4Nfe.png)
16. named_transformation
17. contrast (Valid Values: e-contrast)
18. sharpen (Valid Values: e-sharpen)
```

`NOTE - You can provide the imagekit transformation options inside the transformation hash of im_image_tag`

### Upload

Assuming you have your Imagekit configuration parameters defined (`public key`, `private key`, `imagekit id`), uploading to Imagekit is very simple.
    
The following example uploads a local JPG to the cloud: 

    Imagekit::Uploader.upload("my_picture.jpg", filename: 'my_picture')


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/imagekit.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
