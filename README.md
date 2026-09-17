# eidolonenterprises.com

The company site for Eidolon Enterprises LLC. Static HTML and CSS,
assembled by a small shell build; no framework, no external requests
at runtime. This repo is an IME spoke (hub: ioTus/ime); read
`IME.md` first.

## Pages

| Path | Source |
|------|--------|
| `/` | `src/pages/index.html` |
| `/privacy/` | `src/pages/privacy/index.html` |
| `/support/` | `src/pages/support/index.html` |

Shared header and footer live in `src/partials/`. Each page file
starts with a `title:` / `description:` header, then `---`, then
the page body. Copy marked `<!-- DRAFT -->` is awaiting approval.

## Build

```sh
./build.sh
```

Writes `dist/` (ignored by git). Preview locally with any static
server, for example:

```sh
cd dist && python3 -m http.server 8080
```

## Deploy

```sh
./deploy.sh push      # build, then rsync dist/ to Bluehost
./deploy.sh verify    # fetch https://eidolonenterprises.com/ with a browser UA
./deploy.sh diff      # dry run
```

Deploy path on the Bluehost account: `~/public_html/eidolonenterprises/`,
the document root of the `eidolonenterprises.com` addon domain. The
scripts use the `retrotuned` SSH alias from `~/.ssh/config`; no
credentials are in this repo.

One-time hosting setup, in order:

1. DNS at GoDaddy: A records for `@` and `www` pointing at the
   Bluehost server IP (the same address `retrotuned.com` resolves to).
2. Once the domain resolves there, add the addon domain:
   `./deploy.sh domain` (cPanel refuses until DNS points at the
   server). Or in cPanel: Domains → Create A New Domain →
   `eidolonenterprises.com`, document root
   `public_html/eidolonenterprises`.
3. `./deploy.sh ssl` asks AutoSSL to issue the certificate; it also
   runs on its own within a day.

## Fonts

Old Standard TT (Regular, Italic, Bold) as woff2, under the SIL Open
Font License (`src/fonts/OFL.txt`). Served from this domain.
