# Department notes — strategy

## Log (newest first)

### 2026-09-20 (later) — Deep-dive synthesis: Bump health, category monetization, 22–30 target, Apple kill-trigger check

**Net: TEST IT stands; riskiest assumption unchanged (D2). One material shift: spying ping is now the lead differentiator; invisibility windows are being commoditized by Apple.** Inputs: three research agents (full sourced reports in the main session transcript) + direct check of Apple newsroom.

**Q1 — Is Bump (the Zenly founders' revival) winning?** No proven win. No paid tier (US App Store v2.115.0, no IAP listed — verified 2026-09-20); no first-party user numbers anywhere; best third-party signal ~7.9M lifetime Android installs, ~720K in last 30 days (AppBrain, ESTIMATE). $18M seed (2023, ~€100M valuation per Sifted); no follow-on round found 2024–2026. Portfolio churn at amo: Capture apparently discontinued (store URL 404s — INFERENCE), new app Sugar launched ~Oct 2025. App healthy: actively maintained, #38 US Social Networking, 4.8★/6.6K US ratings. Read: three years in, the best-credentialed team in the category is pre-revenue with modest traction — desirability persists, viability still unproven.

**Q2 — Has anyone monetized fun social location?** Charging now exists; proven revenue doesn't. Jagat runs a live IAP stack (Super Jagat $6.99–$69.99, Couple Membership $12.99/mo, ad-free pass $9.99, stickers) — zero disclosed revenue, no credible estimates. whoo charges ¥390/mo (~$1.99) for premium "see who viewed you" — the one in-category feature with a demonstrated price tag is the spying ping. Correction to kickoff log: MIXI *invested* in LinQ (whoo), never acquired it; LinQ raised ~¥1.1B Series A June 2026 → still venture-fed, INFERENCE: not self-sustaining. The two proven adjacent models: safety subscriptions (Life360 Q1 2026: $143.1M revenue +38% YoY, 3.0M Paying Circles, ARPPC $143, FY26 guide $650–685M) and map advertising (Life360 ads $19.7M Q1 2026, +329% YoY, ~$100M+ guided for 2026; Snap Sponsored Places on a ~400M-user map since Q4 2024). Zenly's $0 at 40M MAU stands. Bump: still free, no IAP found.

**Q3 — Is 22–30 a viable differentiated target?** Real and unserved — but only with an adult-native job. Behavior exists in-band: 70–75% of Gen Z/Millennials location-share (AllAboutCookies Aug 2025 n=1,000; CivicScience Apr 2025); Find My-as-social documented at ages 22–27 (Slate Dec 2025; i-D May 2023, ~20 checks/day). Nobody targets post-college: Bump is explicitly campus ("claim your frat or sorority"), whoo/Jagat ~85% school-age, Life360 skews 35–55 parents — the slot is empty. Cautions: friend-sharing (vs. partner-sharing) skews Gen Z (only 27% of sharers share with friends overall); users age OUT of playful apps (BeReal 73.5M→~16M MAU); the slot is being probed from above (Instagram Friend Map 2025; Mmotion NYC beta Nov 2025, TechCrunch). Adult analogies that worked (Partiful ~500K MAU +400% YoY; Strava/run clubs) won on a real job — events, fitness — not calmer aesthetics. The true 22–30 incumbent is free, built-in Find My.

**Q4 — Apple kill-trigger check (REVISIT WHEN: "Apple ships social features into Find My").** NOT fired — but eroding one MVP feature. Apple newsroom 2026-06-09 (shipping fall 2026, i.e. during/just after our beta window): custom-duration location sharing and pause sharing "until the end of the day for specific people" — a native, basic invisibility window. Still zero social layer: no who-viewed, no playful UI, no history. Second trigger check (REVISIT WHEN: "a monetization wedge appears anywhere in the category"): warm, not fired — paid tiers exist (Jagat, whoo) but no proven revenue; wedge-if-ever looks like premium social-curiosity features + map ads, not safety subs.

**What this changes (ranked):**
1. Spying ping becomes the hero feature — the only MVP feature Apple won't copy and the only one with demonstrated in-category willingness-to-pay (whoo ¥390/mo). Keep invisibility windows for Always-on trust, but stop counting them as differentiation; don't over-polish that UI while Apple ships its own pause mid-beta.
2. ICP note hardens: the underserved slot is post-college 22–30 friend groups — matches Elliott's founding beta exactly — but the wedge must be an adult-native job (coordination, dispersed friends, ambient closeness), consent-forward, not "teen app with calmer skin." Adult usage may be episodic rather than always-on; the beta should watch for that pattern instead of forcing constant sharing.
3. Viability (V1) is unchanged as the structural kill-risk, with sharper contours: first pricing anchor exists (~$2/mo, whoo), and the only at-scale money in adjacent maps is safety subs and map ads.

**Per-department briefs:** Product — MVP scope unchanged (live map + invisibility windows + spying ping), but design spying ping as the hero loop; instrument whether adult usage is always-on or episodic (opens around meetups). Marketing — invite pitch leads with spying ping + "our whole group" density, not privacy controls; hold the "Zenly is dead, Apple won't build this" frame until the beta passes and note Apple's fall release narrows "Apple won't build this." Sales — stays parked; record whoo ¥390/mo as the category's first willingness-to-pay anchor.

### 2026-09-20 — Validation kickoff: assumption map, prior art, riskiest assumption, verdict

**Verdict: TEST IT.** Deciding fact: the category's desirability is already proven — Zenly hit ~40M MAU before Snap killed it, and whoo did 10M downloads in 3 months filling the vacuum — so the only cheap unknown is whether Elliott's own friend group installs and *stays* sharing after novelty fades, which the planned TestFlight beta answers in 30 days for ~$0. What would change my mind: week-4 beta retention below threshold, or Apple shipping social features into Find My before then.

#### 1. Prior art (the critical context — this idea is a Zenly revival, and Zenly's story cuts both ways)

- **Zenly** (Paris; Snap acquired 2017 for ~$213–250M; shut down 2023-02-03). Map-first, playful, beloved — top-10 social app in iOS charts, huge in Japan; ~40M active users at shutdown. Snap killed it anyway because it generated no meaningful revenue and Snap was cost-cutting. Sources: [TechCrunch](https://techcrunch.com/2022/12/05/zenly-was-the-best-social-app-and-it-will-sadly-shut-down-on-february-3rd/), [Pragmatic Engineer](https://blog.pragmaticengineer.com/zenly/), [Life360 blog](https://www.life360.com/en-ca/blog/what-happened-to-zenly), [Sifted](https://sifted.eu/articles/snaps-decision-shut-down-zenly).
- **Zenly already shipped most of Elliott's feature list**: "who viewed your location" check-ins (= the spying ping), Ghost Mode with precise/frozen/blurred (= invisibility windows), Footprints self-history fog-of-war (= time travel, self-only), fun-first map UI (= the core bet). Sources: [Zenly community docs — Footprints](https://community.zen.ly/hc/en-us/articles/360000420067-What-is-Footprints-), [privacy note](https://community.zen.ly/hc/en-us/articles/360000426308-Is-my-Footprints-information-private-), [PhoneArena feature review](https://www.phonearena.com/news/Zenly-is-a-live-location-tracking-app-with-a-lovely-interface-and-lots-of-features_id81546).
- **The post-Zenly wave proved demand refills fast**: **whoo** (Japan, LinQ) 10M downloads within 3 months of Dec 2022 launch, ~80% middle/high-schoolers, MIXI invested ~¥2B ([Business Insider Japan](https://www.businessinsider.jp/article/269370/), [Trendbites](https://trendbitesjp.kamenokoki.com/whoo-japans-location-sharing-app/)); **Jagat** claims 1M+ DAU in first month and 10M+ users, strongest in SE Asia ([PR Newswire](https://www.prnewswire.com/apac/news-releases/next-gen-location-sharing-social-app-gains-massive-traction-surpassing-1-million-daus-within-the-first-month-301823161.html)); **amo/Bump** — the actual Zenly founders (Antoine Martin) raised VC and rebuilt it as "Location by amo," now **Bump**, alongside ID and Capture; still operating as of 2026 ([TechCrunch](https://techcrunch.com/2023/12/19/with-amos-third-app-the-makers-of-zenly-release-a-zenly-like-app), [Sifted](https://sifted.eu/articles/amo-frances-hottest-social-media-app), [Crunchbase](https://www.crunchbase.com/organization/amo-d5fb)).
- **Incumbents at scale**: Snap Map ~435M MAU Q4 2025 ([Snap newsroom](https://newsroom.snap.com/2025-snap-map-mau)); Life360 95.8M MAU Dec 2025, monetizing family-safety subscriptions, not fun ([Life360 IR](https://investors.life360.com/news-releases/news-release-details/life360-reports-record-q4-2025-results)); Apple's Find My is now a documented Gen-Z social behavior in its own right ([Slate, Dec 2025](https://slate.com/technology/2025/12/apple-find-my-app-location-sharing-gen-z-trend.html)) — but Apple has added no playful/social layer to it as of iOS 26.
- **Find My API access: definitively no.** Apple exposes no API for third parties to read Find My friend locations — CoreLocation/MapKit only give your own device's position, and the Find My Network accessory program covers item-tracker hardware, not friends. The only "access" is reverse-engineered (e.g. FindMy.py, [HN discussion](https://news.ycombinator.com/item?id=42479233)), which violates Apple's terms and is unusable in an App Store app. Consequence: no import path — every friend must install and grant location fresh. Cold start is total.

#### 2. Assumption map (importance × uncertainty, 1–5 each)

**Desirability**
- D1. Friend groups feel Find My is socially sterile and want a fun layer — 5 × 2 = **10** (strong prior art: Zenly/whoo/Jagat + Slate trend piece; mostly proven for teens/Gen Z, thinner evidence for Elliott's demo).
- D2. Friends will install a separate app, grant Always-on location, AND still be sharing in week 4 (switching + post-novelty retention vs. built-in Find My) — 5 × 4 = **20 ← riskiest**.
- D3. Playfulness alone is a big-enough wedge (vs. table stakes) — 4 × 3 = 12. Zenly proved fun works; whoo/Jagat/Bump make it table stakes in the category. Inference: the wedge is fun + friend-group density, not fun alone.

**Viability**
- V1. This can ever make money — 5 × 4 = **20, but not cheaply testable now**. Nobody has monetized fun-location: Zenly died at 40M users with no revenue; whoo/Jagat monetization unproven; Life360 monetizes fear (family safety), not fun. This is the structural kill-risk; deferred, not dismissed (stage = empathy/stickiness, not revenue).
- V2. Channel exists at sane cost — 3 × 2 = 6. Friend-group-to-friend-group invite loops are the category's native channel (Zenly/whoo grew via schools); founding beta needs zero spend.

**Feasibility**
- F1. Solo founder can build live location sync small — 4 × 2 = 8. Proven pattern (SwiftUI + CoreLocation + a push/sync backend); Zenly's famous battery engineering shows polish is hard, but MVP-grade is routine.
- F2. App Store allows it — 4 × 1 = 4. Fully precedented: background location legal under Guideline 2.5.4 (intended purpose + battery-drain notice); who-viewed pings and consent-based location history both shipped in Zenly/Life360 for years. "Time travel" on *others* must be consent-gated; self-history (Footprints-style) is safest.
- F3. Battery drain won't get the app deleted — 4 × 3 = 12. Always-on location costs real battery (~20–25% worse than while-using per [field reports](https://www.cyberdb.co/does-sharing-location-drain-your-iphone-battery-heres-the-truth/)); Zenly's low-drain stack was a moat ([Pragmatic Engineer](https://blog.pragmaticengineer.com/zenly/)). Folded into D2 — the beta measures it as churn.

#### 3. THE riskiest assumption

**D2: "Friends who already share via Find My will move their location sharing to a separate app and still be actively sharing in week 4."** It kills the venture if false (no density → no social app), and it's the one prior art can't answer for this specific group — Zenly/whoo skew school-age Asia/EU; Elliott's group are US adults inside Apple's default.

#### 4. Smallest test (pre-committed)

- **Test**: TestFlight beta to Elliott's own friend group (the founding beta), MVP = live map + invisibility windows + spying ping only. Time box: ship by 2026-10-20, measure through week 4 post-install.
- **Pass/fail (written before running)**: PASS = ≥8 of ~12 invited friends install and grant Always location in week 1, AND ≥50% of installers still have sharing ON and open the app ≥3 days in week 4. FAIL = either miss. Instrument day-1 grant rate, weekly sharing-on rate, opens/week from the first build.
- **Cheaper pre-test (run first, costs one message)**: Elliott asks the group chat "if I build fun Find My, will you switch to it with me?" — Mom Test caveat: yeses are worthless, but *refusals* are cheap kill-signal. Any actual outreach beyond Elliott's own chat goes through hub queue/pending.

#### 5. What prior art did to the feature hypotheses

1. Fun-first UI — **validated but now table stakes** (Zenly, whoo, Jagat, Bump all do it). Keep as foundation, not differentiator.
2. Spying ping — **validated** (Zenly check-ins). Keep in MVP; it's the most gossip-generating, retention-driving feature.
3. Invisibility windows — **validated** (Zenly Ghost Mode: precise/frozen/blurred). Keep in MVP; it's the trust feature that makes Always-on tolerable.
4. Time travel — **reshape**: ship self-only history first (Zenly Footprints precedent); friend-history only later, per-friend consent-gated (Life360 precedent). Highest creep-factor item.
5. Smart friend insights — **cut from MVP** (no successful precedent anywhere in the category; privacy-heavy; already on the Later list). Revisit only post-density.

#### Per-department briefs

- **Product**: Scope MVP to exactly D2's test — live map, invisibility windows, spying ping; cut time travel (self-history at most) and all insights. Run the two-iPhone live-sync feasibility spike first (backend choice: needs live location + push). Instrument the three beta metrics (grant rate, sharing-on rate, opens/week) in build one — the test is worthless without them. Use `mvp-scope` skill.
- **Marketing**: Nothing to publish yet. One prep task: draft the friend-group invite message and a one-screen "why switch" pitch for the beta (goes to hub queue when ready to send). Note for later positioning: the honest frame is "Zenly is dead, Apple won't build this, we did" — but only after the beta passes.
- **Sales/monetization**: Explicitly parked. The category's unsolved problem is revenue (Zenly died at 40M users making $0). Reopen only when the beta passes and weekly-active-friends is stable.
