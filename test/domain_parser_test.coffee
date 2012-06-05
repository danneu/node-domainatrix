DomainParser = require "../src/domainatrix/domain_parser"

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
