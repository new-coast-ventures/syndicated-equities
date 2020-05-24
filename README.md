# syndicated-equities
Syndicated Equities project

To pull production to staging:
If you don't have parity: `brew install parity`

`production backup`
`staging restore production`
For local restore
`development restore production`

This app uses foreman to run
`foreman start -f procfile.dev`
