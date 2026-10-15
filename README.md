# HKTCG Launch Teardown · HKTCG 開幕拆解

A password-protected, bilingual (中文 / English) dashboard reviewing how HKTCG (iSQUARE, Tsim Sha Tsui) launched on social media and in the press, 20 May – 20 July 2026. Prepared as competitor research for the Grade10 Pak Sha Road opening.

Live pages (same team password):

- HKTCG launch teardown: https://ladywakaka.github.io/hktcg-launch-teardown/
- Grade10 vs HKTCG comparison: https://ladywakaka.github.io/hktcg-launch-teardown/compare/

## The comparison page

Compares the Grade10 shop launch plan (Notion G10 Shop Launch Tracker and the G10 Shop Marketing Update, as of 15 Oct 2026 afternoon) with HKTCG's launch: status tiles, a days-to-opening chart of both launches, a 12-area side-by-side table (Gap / Partly covered / Covered) and 12 timed suggestions. Below that it repeats the full HKTCG review. It is a snapshot: re-run the comparison when the Notion tracker changes. Stored encrypted as `src/compare.html.enc`.

## What's on the HKTCG page

- Headline numbers (click a tile to jump to its section)
- Nine takeaways and the three top posts
- A timeline of every owned post, KOL post, YouTube video and press article (hover or tap for details, click to open the post)
- Content-lane performance and the tactics HKTCG used
- Five press waves (click a wave to see its articles)
- Sortable, filterable logs: HKTCG & Derek posts, KOLs, YouTube, press
- The 🌐 中 / EN button switches language. Add `#en` to the link to open in English.

## How it's protected

This repository is public, so the page is never stored in readable form.

1. `src/dashboard.html.enc` and `src/compare.html.enc` are the two pages, encrypted with AES-256. The key is the `SOURCE_KEY` repository secret, and a copy is kept in the owner's macOS Keychain (item `hktcg-dashboard-source-key`).
2. On every push to `main` (or **Run workflow** in the Actions tab), `.github/workflows/deploy.yml` decrypts the page, locks it with the team password using [StatiCrypt](https://github.com/robinmoisson/staticrypt), and publishes only the locked page to GitHub Pages.

## Secrets (Settings > Secrets and variables > Actions)

| Name | What it is |
|---|---|
| `SOURCE_KEY` | Key that decrypts `src/dashboard.html.enc`. Already set. Don't change it unless you re-encrypt the source with the new key. |
| `DASHBOARD_PASSWORD` | The password the team types to open the dashboard. Change it here, then run the workflow again. |

## Updating the dashboard

```sh
scripts/decrypt.sh                       # writes build/index.html
# edit build/index.html, or replace it with a new export
scripts/encrypt.sh build/index.html      # writes src/dashboard.html.enc
git commit -am "Update dashboard" && git push
```

## Private source code

The full source (data scripts, datasets, page code, build script and the original input files) is in `source/hktcg-source.tar.gz.enc`, encrypted with the same key. Only someone with that key can open it.

```sh
scripts/source-unpack.sh                 # unpacks to ./hktcg-source (ignored by git)
cd hktcg-source && python3 build.py      # rebuilds index.html and artifact.html
cd .. && scripts/source-pack.sh          # re-encrypts the source and the page
git add -A && git commit -m "Update source" && git push
```

Keep a backup of the key: if the Keychain item is lost, the source can't be decrypted.

## Data sources

Public Instagram and YouTube data collected through Apify on 14 Oct 2026, the KOL list in `HKTCG Research_KOL.xlsx`, and the press summary in `HKTCG_News.pdf`. Facebook and Threads are not covered yet.
