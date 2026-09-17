# IME.md — Spoke: eidolonenterprises.com

> This repo is a spoke in the IME system.
> Hub: ioTus/ime — read IME.md there for identity, roles,
> principles, permissions, write discipline, and workflows.

---

## What This Repo Is

The company website for Eidolon Enterprises LLC at
eidolonenterprises.com: a static site (plain HTML and CSS, assembled
by a small shell build) with a home page, `/privacy`, and `/support`.
It exists so the company has a functional public site on its own
domain, and to host the privacy and support URLs its App Store
listings point at. Brief: hub
`knowledge/projects/eidolon-enterprises/eidolon-website-brief.md`.

- Repo: ioTus/eidolonenterprises.com
- Platform: static files on Bluehost (addon domain on the existing
  account), deployed by rsync over SSH, HTTPS via AutoSSL
- License: site copy and identity © Eidolon Enterprises LLC; fonts
  under the SIL Open Font License (see `src/fonts/OFL.txt`)

---

## Governance Files

| File | What it is |
|------|-----------|
| IME.md | This file — spoke bootstrap |
| IME-AGENTS.md | Multi-agent overview and index |
| IME-AGENTS-claude-code.md | Claude Code workspace boundaries |
| IME-docs/plans/ | Plan documents |
| IME-docs/decisions/ | Decision log |

---

## Project Principles

- Eidolon is a software company on this site. It publishes TrackBack,
  Eatezy, and GitBridge MCP and stewards IME. No consulting language
  anywhere on the site, ever.
- Facts only. Copy comes from the hub brief and product files. No
  invented products, claims, or numbers.
- No external requests at runtime. Fonts are self-hosted; no
  analytics, no CDNs, no embeds.
- Period letterforms, never a specific company's mark. v1 is a
  typographic identity only; ornament and engraved marks wait for a
  design session with Geoff.
- The host is a target, never a source of truth. The repo is the
  site; `deploy.sh push` overwrites the server.
- Copy changes go through Geoff before DNS moves and before any
  later edit ships.
