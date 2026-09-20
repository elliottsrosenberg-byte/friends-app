# Friends App — venture context

> The shared context. Every department and skill reads this first. Keep it current and under ~80 lines; history lives in decisions.md and git.

## One-liner
The fun version of Find My: a social location app for friend groups — FindMy/SnapMap is already being used as social media, but it's built like a utility.

## Problem & who has it (ICP)
- Problem: friend groups use Find My as a de facto social app (keeping up with people, seeing where everyone is/goes) but it's a sterile utility — no playfulness, no social features, no history, no control over presence.
- ICP (be narrow): Elliott's own friend group first — iPhone-carrying friends who already share Find My locations with each other. Founding beta = real friends, real density.
- Where they are today (the alternative they'd switch from): Apple Find My (built into iMessage — Apple's distribution advantage), Snap Map inside Snapchat, Life360 (family-skewed utility).

## Product direction (affirmed by Elliott 2026-09-20)
Memory-first, adult-native: a map of your friend group's life, not teen surveillance. Analog/real-photo sensibility (Retro is the reference for what 22–30s want); "location-based Snapchat at times," never public reviews. Candidate core loop: the **daily map moment** — at a synced time everyone posts a photo of where they are, rendered as a map view (BeReal mechanic × map canvas); each day's moment auto-builds the time-travel archive.

## Feature hypotheses (pruned by strategy validation, 2026-09-20 — details in departments/strategy.md)
- Fun-first UI (anti-utility) — validated by prior art (Zenly, whoo, Jagat) but now table stakes in the category; foundation, not differentiator
- Spying ping (who checked your location) — KEEP, MVP, **hero feature** (deep-dive 2026-09-20): the only MVP feature Apple won't copy and the only in-category feature with demonstrated willingness-to-pay (whoo charges ¥390/mo for it)
- Invisibility windows — KEEP, MVP: the trust feature that makes Always-on tolerable — but being commoditized: Apple ships custom-duration + pause-sharing in Find My fall 2026; trust table stakes, not differentiation
- "Time travel" — RESHAPED: self-only history first (Zenly Footprints precedent); friend-history later, per-friend consent-gated (Life360 precedent)
- Smart friend insights from location patterns — CUT from MVP: no successful precedent in category, privacy-heavy (stays on Later list)

## Positioning (Dunford)
- Full Dunford not yet run. Competitive-alternative facts (strategy, 2026-09-20):
  - This idea is effectively a Zenly revival. Zenly: ~40M active users, killed by Snap 2023-02 for making no revenue — desirability proven, viability unproven.
  - Post-Zenly wave shows demand refills fast: whoo (10M downloads in 3 months, Japan, teen-skewed), Jagat (10M+ users, SE Asia), Bump by amo (the actual Zenly founders, VC-backed, live in 2026).
  - Bump reality check (deep-dive 2026-09-20): entirely free, no IAP, no disclosed user numbers; ~7.9M lifetime Android installs (estimate), #38 US Social / #9 FR; $18M seed, no follow-on found, amo consolidating its app portfolio. Alive and shipping daily, but pre-revenue with modest US traction — campus-targeted ("claim your frat or sorority"), not competing for post-college adults.
  - Incumbents: Find My (Apple default; no social layer, but fall-2026 Find My adds custom-duration + pause-sharing — a native basic invisibility window; Gen Z uses it as social media — Slate 2025-12), Snap Map (~435M MAU inside Snapchat, now an ad surface), Life360 (~98M MAU, family-safety subs $650M+ FY26 run rate + fast-growing map ads).
  - Unserved slot: post-college 22–30 friend groups — Bump is campus, whoo/Jagat are teens, Life360 is parents. But the wedge must be an adult-native job (coordination, dispersed friends, consent-forward episodic sharing), not a calmer skin; this cohort's real incumbent is free built-in Find My.
  - No API access to Find My friend locations exists for third parties (accessory program is hardware-only; reverse-engineered libs violate Apple ToS) — cold start is total, every friend must install fresh.

## Offer & revenue model
- Offer: TBD after validation
- Revenue hypothesis (Elliott, 2026-09-20): free = live map + spying ping + a taste of history; paid = deeper time travel / more features (precedent: Life360 sells history depth, whoo sells who-viewed at ~$2/mo); ads = someday-line only, requires Snap/Life360 scale.
- Win condition (Elliott, 2026-09-20): a large active user base counts as a win even unpaid — with the Zenly caveat that dead installs are vanity; retention is the bar.
- Pricing (hypothesis + as-of 2026-09-20): free during validation — social density before dollars; monetization decided once sticky.
- Value metric: TBD (likely history depth)

## Current riskiest assumption
- Assumption: friends who already share via Find My will move location sharing to a separate app AND still be actively sharing in week 4 (switching + post-novelty retention). Set by strategy 2026-09-20; prior art proves the category for teens/Asia, not for this group.
- Smallest test: TestFlight beta to Elliott's own friend group; MVP = live map + invisibility windows + spying ping only. Ship by 2026-10-20, measure through week 4.
- Pass/fail threshold (pre-committed): PASS = ≥8 of ~12 invited friends install and grant Always location in week 1, AND ≥50% of installers still have sharing ON and open the app ≥3 days in week 4. Either miss = FAIL.

## Current goal
- Goal: validate the idea against prior art (Zenly, Snap Map, etc.) and get a TestFlight build into the friend group by the deadline.
- One metric that matters (stage-appropriate): TBD — likely weekly active friends sharing location.

## Stack (confirmed with Elliott — never assumed)
- Platform: iOS-first, native (confirmed 2026-09-20)
- Stack: SwiftUI + MapKit + CoreLocation; backend TBD at MVP scoping (needs live location sync + push)
- Hosting / distribution: TestFlight for the friend-group beta

## Status snapshot
- Stage: validating
- Ship deadline: 2026-10-20 (30 days — scope bends, the date doesn't)
- As of: 2026-09-20
