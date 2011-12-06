ZSImageView
=============

This is a replacement for UIImageView. Unlike UIImageView, ZSImageView supports loading a remote image
as well as providing a default image while the remote image is loading.  You can also round any of the
edges individually as well as set borders individually.

![ZSImageView](http://f.cl.ly/items/0i1b0V0Q0q3e0l0C0204/screen-shot.jpg "ZSImageView")

How It Works
---

Create a ZSImageView and set the remote and default image:

```objective-c
ZSImageView *imageView = [[[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)] autorelease];
imageView.imageUrl = @"http://www.indiaonrent.com/forwards/b/beautiful-mountains/res/593qen.jpg";
imageView.defaultImage = [UIImage imageNamed:@"no-image.png"];
imageView.contentMode = UIViewContentModeScaleAspectFill;
[self.view addSubview:imageView];
```

If you want to round three of the edges and give the view a cornerRadius of 10 it is pretty easy:

```objective-c
ZSImageView *imageView2 = [[[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)] autorelease];
imageView2.imageUrl = @"http://www.desktopwallpaperhd.com/wallpapers/3/4501.jpg";
imageView2.defaultImage = [UIImage imageNamed:@"no-image.png"];
imageView2.corners = ZSRoundCornerTopLeft | ZSRoundCornerBottomLeft | ZSRoundCornerTopRight;
imageView2.cornerRadius = 10;
[self.view addSubview:imageView2];
```
If you want to give only some of the edges a border:

```objective-c
ZSImageView *imageView3 = [[[ZSImageView alloc] initWithFrame:CGRectMake(140, 300, 100.0f, 100.0f)] autorelease];
imageView3.imageUrl = @"http://www.taramtamtam.com/wallpapers/Sport/M/Mountain_biking/images/Mountain_biking_3.jpg";
imageView3.defaultImage = [UIImage imageNamed:@"no-image.png"];
imageView3.contentMode = UIViewContentModeScaleAspectFill;
imageView3.borders = ZSBorderRight | ZSBorderLeft | ZSBorderTop;
imageView3.borderWidth = 3.0;
imageView3.borderColor = [UIColor redColor];
imageView3.clipsToBounds = YES;
[self.view addSubview:imageView3];
```

Round Edges
---
There are five options you can use to round the edges of your `ZSImageView`. `ZSRoundCornerTopLeft`, `ZSRoundCornerTopRight`, `ZSRoundCornerBottomLeft`, `ZSRoundCornerBottomRight`, `ZSRoundCornerAll`. These can be combined to round a few edges or you can use `ZSRoundCornerAll` to round all of the edges. `ZSRoundCornerNone` is also available to reset the corners to none when reusing a `ZSImageView`, such as when using it in a `UITableViewCell`.

Borders
---
The great thing about using `ZSImageView` is that you can choose to only add a few borders if you would like. There are five options for this, `ZSBorderTop`, `ZSBorderRight`, `ZSBorderBottom`, `ZSBorderLeft`, and `ZSBorderAll`. There is also `ZSBorderNone` if you need to reset them when using cell reuse. There are defaults for `borderWidth` and `borderColor` but obviously you can set those as well.

How to use in your App
---
`ZSImageView` requires the `QuartzCore.framework`. Once you have that added you need to copy `ZSImageView.h`, `ZSImageView.m`, `ZSLineView.h` and `ZSLineView.m` as well as `JMImageCache.h` and `JMImageCache.m` to your project. Then `#import` the `ZSImageView.h`
header file where you need it and start using it.

Notes
---

ZSImageView uses [JMImageCache](https://github.com/jakemarsh/JMImageCache) to load and cache the remote image.
