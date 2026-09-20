# Department notes — strategy

## Log (newest first)

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
