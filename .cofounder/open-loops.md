# Open loops

Format: `- [ ] YYYY-MM-DD, <what>, next action: <concrete>, owner: <elliott|strategy|product|marketing|sales>, due: YYYY-MM-DD`

A loop missing any field is a zombie loop — fix it or kill it. Loops older than 7 days get called out at check-in.
- [x] 2026-09-20, strategy kickoff research (validate-idea), next action: review findings in departments/strategy.md, owner: strategy, due: 2026-09-21 — closed 2026-09-20 by deep-dive synthesis (same file)
- [ ] 2026-09-20, beta instrumentation must distinguish always-on vs episodic usage (adults may open around meetups, not all day — deep-dive finding), next action: fold into MVP scope's metrics spec, owner: product, due: 2026-10-20
- [x] 2026-09-20, MVP core-loop fork: always-on live map (as scoped) vs daily map moment (BeReal × map), owner: elliott — CLOSED 2026-09-20: Elliott chose hybrid (moment + archive core, live map ambient); see decisions.md
- [x] 2026-09-20, re-scope MVP for the hybrid loop, owner: product — CLOSED 2026-09-20: scope v2 in departments/product.md; riskiest assumption + pass/fail updated in venture.md
- [x] 2026-09-20, backend stack confirm — CLOSED 2026-09-20: Elliott confirmed Firebase
- [ ] 2026-09-20, working codename now / real name locked before App Store Connect record, next action: naming sprint (marketing) + Elliott picks, owner: elliott, due: 2026-10-10
- [x] 2026-09-20, design direction one-pager (palette, type, map style — anti-maximalist, analog/memory feel) before slice 2 UI work, owner: product — CLOSED 2026-09-20: departments/design-direction.md; slice-1 deltas (muted map emphasis, 8-swatch friend colors, self dot) fold into slice-2 build
- [ ] 2026-09-20, Xcode not installed on this Mac — slice-1 code is written but has never compiled; expect small compile fixes on first build, next action: Elliott installs Xcode from the App Store + `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`, then product runs the sim build in mock mode and fixes what surfaces, owner: elliott, due: 2026-09-23
- [ ] 2026-09-20, Firebase project + Apple signing manual setup (console project, GoogleService-Info.plist, Auth/Firestore enable, APNs key upload, signing team) — full checklist in SETUP.md at repo root, next action: Elliott works through SETUP.md steps 1–4, owner: elliott, due: 2026-09-24
- [ ] 2026-09-20, slice-1 end-to-end proof on two real iPhones (Apple sign-in, both dots live, one push) — blocked on the two loops above, next action: run SETUP.md step 5 checklist, owner: elliott, due: 2026-09-25
- [ ] 2026-09-20, Hum (humtoday) connection — Elliott's friend built a daily audio+prompt ritual app, next action: Elliott chats with the founder re: ritual retention learnings (and any collab angle), owner: elliott, due: 2026-10-04
- [ ] 2026-09-20, beta roster unnamed — pass/fail denominator is "~12 friends" but no list exists (who, all on iPhone?, already sharing Find My with each other?); the named list also supplies the ≥5 Mom Test interviews the validating gate in roadmap.md requires, next action: Elliott writes the 12 names into departments/strategy.md, then strategy preps the interview script, owner: elliott, due: 2026-09-27
