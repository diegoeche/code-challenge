# Challenge Notes

## Testing:

Here is my solution to the challenge. To setup you should be able to
simply run:

```
bundle install
rspec spec
```

## Comments on my Solution:

I started with a naive approach using Nokogiri. Since classes are
mostly obfuscated, I rely on detecting the "structure" of the
carrousel items.

After doing so, noticed that the image seem to point to a gif
image. And is replaced later through JS. The easiest thing here was to
run the javascript using Ferrum. This solution makes it much slower
than the original pure Nokogiri parsing.

Since is a bit slow, I decided to cache the evaluation throughout the
tests, this I'd say is not something I typically do. And feels
non-idiomatic.

I added additional files for other google searches. When I added an
example for a books result that uses the same carrousel, I noticed the
structure is different, but maybe still possible to use a
generalization. For this, I "flatten" and used nokogiri to generate
the terminal nodes of the matched anchors. This seem to work for both
books/artworks.

TODOs/Questions:

1. Should the key of the result "artworks" reflect the title? Not
   clear. Makes sense and should be easy to do.
2. Movies seem to follow a different structure. Unsure if it's _the
   same carousel_ Might work on it to get some interview brownie points.


---

# Extract Van Gogh Paintings Code Challenge (Original)

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready.

Programming language wise, Ruby (with RSpec tests) is strongly suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages to make sure it works against different layouts. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

The suggested time for this challenge is 4 hours. But, you can take your time and work more on it if you want.
