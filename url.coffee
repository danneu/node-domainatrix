String::reverse = (delimiter="") -> @.split(delimiter).reverse().join(delimiter)

class Url
  constructor: (keys = {}) ->
    valid_keys = [ "auth", "host", "hostname", "href", "path", "pathname", "port", "protocol", "query", "search", "domain", "publicSuffix", "subdomain" ]
    @[key] = keys[key] or "" for key in valid_keys
    @canonical = @buildCanonical()

  buildCanonical: ->
    sets = [@publicSuffix, @domain, @subdomain]
    canonical = (set.reverse(".") for set in sets when set isnt "").join(".") 
    canonical += @path unless @path is "/"
    canonical

  domain_with_public_suffix: ->
    (part for part in [@domain, @public_suffix] when part isnt "").join(".")

module.exports = Url
