# Domainatrix

Work in progress.

I haven't made it into an NPM module yet, but:

    domainatrix = require "./domainatrix"
    domainatrix.parse "http://user:pass@foo.bar.lol.pauldiz.co.uk:3000/a/b/c/index.html?q=arg&hello=world"

    { auth: 'user:pass',
      host: 'foo.bar.lol.pauldiz.co.uk:3000',
      hostname: 'foo.bar.lol.pauldiz.co.uk',
      href: 'http://user:pass@foo.bar.lol.pauldiz.co.uk:3000/a/b/c/index.html?q=arg&hello=world',
      path: '/a/b/c/index.html?q=arg&hello=world',
      pathname: '/a/b/c/index.html',
      port: '3000',
      protocol: 'http:',
      query: 'q=arg&hello=world',
      search: '?q=arg&hello=world',
      domain: 'pauldiz',
      publicSuffix: 'co.uk',
      subdomain: 'foo.bar.lol',
      canonical: 'uk.co.pauldiz.lol.bar.foo/a/b/c/index.html?q=arg&hello=world' }

For comparison:

    url = require "url"
    url.parse "http://user:pass@foo.bar.lol.pauldiz.co.uk:3000/a/b/c/index.html?q=arg&hello=world"

    { protocol: 'http:',
      slashes: true,
      auth: 'user:pass',
      host: 'foo.bar.lol.pauldiz.co.uk:3000',
      port: '3000',
      hostname: 'foo.bar.lol.pauldiz.co.uk',
      href: 'http://user:pass@foo.bar.lol.pauldiz.co.uk:3000/a/b/c/index.html?q=arg&hello=world',
      search: '?q=arg&hello=world',
      query: 'q=arg&hello=world',
      pathname: '/a/b/c/index.html',
      path: '/a/b/c/index.html?q=arg&hello=world' }

  

