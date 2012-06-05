fs = require "fs"
urlParser = require "url"

class DomainParser
  constructor: (fileName) ->
    @publicSuffixes = {}
    @readDatFile(fileName)

  readDatFile: (fileName) ->
    datFile = fs.readFileSync fileName, "utf8"
    for line in datFile.split "\n"
      line = line.trim()
      unless line.match(/\/\//) or line.length is 0
        parts = line.split(".").reverse()
        subHash = @publicSuffixes
        for part in parts
          subHash = (subHash[part] or= {})
    @publicSuffixes

  parse: (url) ->
    return {} unless url?.trim()
    url = "http://#{url}" unless url.match /:\/\//
    uri = urlParser.parse url
    path = uri.path

    # extend uri with a basename
    pathParts = uri.pathname.split("/") 
    pathParts = (part for part in pathParts when part.length isnt 0)
    uri.basename = pathParts[pathParts.length - 1]

    if uri.hostname is "localhost"
      uriHash =
        publicSuffix: ""
        domain: "localhost"
        subdomain: ""
    else
      uriHash = @parseDomainsFromHost uri.hostname or uri.basename

    # mop up all the properties into one hash
    uriHash[prop] = uri[prop] for prop of uri
    uriHash.url = url
    uriHash

  parseDomainsFromHost: (hostname) ->
    return {} unless hostname
    parts = hostname.split(".").reverse()
    publicSuffix = []
    domain = ""
    subdomains = []
    subHash = @publicSuffixes

    for part, i in parts
      subHash = subParts = subHash[part] or {} 
      if "*" of subParts 
        publicSuffix = publicSuffix.concat part
        publicSuffix = publicSuffix.concat parts[i+1]
        domain = parts[i+2]
        subdomains = parts.slice(i+3, parts.size) or []
        break
      else if subParts.length is 0 or parts[i+1] not of subParts
        publicSuffix = publicSuffix.concat part
        domain = parts[i+1]
        subdomains = parts.slice(i+2, parts.size) or []
        break
      else
        publicSuffix = publicSuffix.concat part

    publicSuffix: publicSuffix.reverse().join(".")
    domain: domain
    subdomain: subdomains.reverse().join(".")

module.exports = DomainParser
