## wordcloud

Simple word cloud which displays topics in different sizes and colors
according to their popularity and sentiment. By clicking on a topic
an info box shows the total mentions and how they break down to positive, neutral and negative.

#### Version

1.0.0

#### Dependencies

- [node.js and npm](https://gist.github.com/isaacs/579814)
- [bower](http://bower.io/)
- [compass](http://compass-style.org/install/)

#### Installation

    git clone git@github.com:francesko/wordcloud.git
    cd wordcloud
    npm install
    bower install

#### Running development version

    grunt serve # run app in default browser

#### Running production version

    grunt # build production version in dist folder
    google-chrome dist/index.html # open with a browser

#### Running tests

    grunt test

#### Generating Documentation

    npm install -g docco # install docco
    docco app/scripts/{,*/}*.coffee # generate docs folder
    google-chrome docs/main.html # open with a browser
