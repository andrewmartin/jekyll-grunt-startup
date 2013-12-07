# Grunt, Bower, and Jekyll

I love Ruby, and I love Node equally. I thought it would be awesome to leverage the powers of the better asset optimization management tool `Grunt` with the more proven and experienced `Jekyll` for static, blog-aware site building.  Yes, I'm aware of the very exciting up and coming [lineman](https://github.com/testdouble/lineman-blog), but it's not quite there yet.

This is a simple starter project that is a work in progress.

It uses the default `jekyll new` but adds some default config and settings to ignore and use `grunt` within.

To start, clone this project, then:

1. `npm install -g grunt-cli` if you don't have Grunt yet.
2. `npm install` required dependencies.
3. `grunt` to boot up the Jekyll server and open it.
4. Configure `Gruntfile.coffee` to your personal liking.

I've ripped out the defaul `syntax.css` and plan to add `highlightjs`, which I've installed as a bower dependency.

Bower dependencies found in `_assets/components`.

I'm working on this currently, so it's not done yet.