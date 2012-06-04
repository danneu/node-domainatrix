fs = require "fs"
Url = require "./domainatrix/url"
DomainParser = require "./domainatrix/domain_parser"

fileName = "#{__dirname}/effective_tld_names.dat"
DOMAIN_PARSER = new DomainParser fileName

class Domainatrix
  @parse: (url) -> new Url(DOMAIN_PARSER.parse(url))

exports.parse = Domainatrix.parse
