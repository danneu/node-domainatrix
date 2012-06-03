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
  url = "http://user:pass@foo.bar.lol.pauldiz.co.uk:3000/a/b/c/index.html?q=arg&hello=world"
  uri = domainatrix.parse url

  describe ".parse(url)", ->
    it "has all correct properties", ->
      # from node-url
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

      # from ruby domainatrix
      assert.propertyVal uri, "canonical",    "uk.co.pauldiz.lol.bar.foo/a/b/c/index.html?q=arg&hello=world"  
      assert.propertyVal uri, "domain",       "pauldiz"
      assert.propertyVal uri, "publicSuffix", "co.uk"
      assert.propertyVal uri, "subdomain",    "foo.bar.lol"
