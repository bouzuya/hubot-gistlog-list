# hubot-gistlog-list

A Hubot script that lists gistlog

![](http://img.f.hatena.ne.jp/images/fotolife/b/bouzuya/20140925/20140925234428.gif)

## Installation

    $ npm install git://github.com/bouzuya/hubot-gistlog-list.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-gistlog-list.git#TAG'

## Example

    bouzuya> hubot help gistlog list
      hubot> hubot gistlog list - lists gistlog

    bouzuya> hubot gistlog list
      hubot> 2014-09-25 gistlog https://gist.github.com/1d74c963a1a3d30e7fb8

## Configuration

See [`src/scripts/gistlog-list.coffee`](src/scripts/gistlog-list.coffee).

## Development

`npm run`

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]
[![Coverage Status][coveralls-badge]][coveralls]

[travis]: https://travis-ci.org/bouzuya/hubot-gistlog-list
[travis-badge]: https://travis-ci.org/bouzuya/hubot-gistlog-list.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-gistlog-list
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-gistlog-list.png
[coveralls]: https://coveralls.io/r/bouzuya/hubot-gistlog-list
[coveralls-badge]: https://img.shields.io/coveralls/bouzuya/hubot-gistlog-list.svg
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
