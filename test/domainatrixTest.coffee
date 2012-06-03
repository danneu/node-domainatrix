cl = console.log
assert = require("chai").assert
domainatrix = require "../domainatrix"
{urlParser, DomainParser, Url} = domainatrix.test

describe "String methods", ->
  describe ".reverse()", ->
    it "reverses the string when given no split", ->
      assert.equal "hello".reverse(), "olleh"
    it "reverses the string at split given in", ->
      assert.equal "dot.com.co.uk".reverse("."), "uk.co.com.dot"

describe "DomainParser", ->
  fileName = "#{__dirname}/test.dat"
  domainParser = new DomainParser fileName

  describe ".readDatFile(fileName)", ->
    it "generates the correct hash", ->
      correctHash = 
        "com": {} 
        "biz": {"webhop": {}}
        "us": {"pa": {"cc": {}}}
        "fk": {"*": {}}
        "jp": {"tokyo": {"!metro": {}}}
      assert.deepEqual domainParser.readDatFile(fileName), correctHash

describe "Domainatrix", ->

  describe ".parse(url)", ->
    it "has all its necessary properties", ->
      url = "http://user:pass@foo.bar.lol.pauldiz.co.uk:3000/a/b/c/index.html?q=arg&hello=world"
      uri = domainatrix.parse url
      # from node-url
      assert.property uri, "auth"
      assert.property uri, "host" 
      assert.property uri, "hostname" 
      assert.property uri, "href" 
      assert.property uri, "path" 
      assert.property uri, "pathname" 
      assert.property uri, "port" 
      assert.property uri, "protocol" 
      assert.property uri, "query" 
      assert.property uri, "search" 
      # from ruby domainatrix
      assert.property uri, "canonical" 
      assert.property uri, "domain" 
      assert.property uri, "publicSuffix" 
      assert.property uri, "subdomain" 

    it "correctly handles a superficially comprehensive-looking example", ->
      url = "http://user:pass@foo.bar.lol.pauldiz.co.uk:3000/a/b/c/index.html?q=arg&hello=world"
      uri = domainatrix.parse url
      assert.propertyVal uri, "auth",     "user:pass"
      assert.propertyVal uri, "host",     "foo.bar.lol.pauldiz.co.uk:3000"
      assert.propertyVal uri, "hostname", "foo.bar.lol.pauldiz.co.uk"
      assert.propertyVal uri, "href",     url
      assert.propertyVal uri, "path",     "/a/b/c/index.html?q=arg&hello=world"
      assert.propertyVal uri, "pathname", "/a/b/c/index.html"
      assert.propertyVal uri, "port",     "3000"
      assert.propertyVal uri, "protocol", "http:"
      assert.propertyVal uri, "query",    "q=arg&hello=world"
      assert.propertyVal uri, "search",   "?q=arg&hello=world"
      assert.propertyVal uri, "canonical",    "uk.co.pauldiz.lol.bar.foo/a/b/c/index.html?q=arg&hello=world"  
      assert.propertyVal uri, "domain",       "pauldiz"
      assert.propertyVal uri, "publicSuffix", "co.uk"
      assert.propertyVal uri, "subdomain",    "foo.bar.lol"

    it "properly builds canonical", ->
      assert.equal domainatrix.parse("http://pauldix.net").canonical, "net.pauldix"
      assert.equal domainatrix.parse("http://pauldix.net/foo.html").canonical, "net.pauldix/foo.html"
      assert.equal domainatrix.parse("http://pauldix.net/foo.html?asdf=bar").canonical, "net.pauldix/foo.html?asdf=bar"
      assert.equal domainatrix.parse("http://foo.pauldix.net").canonical, "net.pauldix.foo"
      assert.equal domainatrix.parse("http://foo.bar.pauldix.net").canonical, "net.pauldix.bar.foo"
      assert.equal domainatrix.parse("http://pauldix.co.uk").canonical, "uk.co.pauldix"

    it "parses into a Url object", ->
      assert.instanceOf domainatrix.parse("http://google.com"), Url


