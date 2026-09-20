# Friends App — venture context

> The shared context. Every department and skill reads this first. Keep it current and under ~80 lines; history lives in decisions.md and git.

## One-liner
The fun version of Find My: a social location app for friend groups — FindMy/SnapMap is already being used as social media, but it's built like a utility.

## Problem & who has it (ICP)
- Problem: friend groups use Find My as a de facto social app (keeping up with people, seeing where everyone is/goes) but it's a sterile utility — no playfulness, no social features, no history, no control over presence.
- ICP (be narrow): Elliott's own friend group first — iPhone-carrying friends who already share Find My locations with each other. Founding beta = real friends, real density.
- Where they are today (the alternative they'd switch from): Apple Find My (built into iMessage — Apple's distribution advantage), Snap Map inside Snapchat, Life360 (family-skewed utility).

## Feature hypotheses (from Elliott's pitch — to be pruned by validation)
- Fun-first UI (anti-utility) — the core bet
- Pings when someone's "spying" on you (checking your location)
- Smart insights: potential new friends from location patterns
- "Time travel" — see where people were earlier
- Invisibility windows: go dark for chunks of time

## Positioning (Dunford)
- Not yet run — strategy kickoff research in progress (see departments/strategy.md).

## Offer & revenue model
- Offer: TBD after validation
- Pricing (hypothesis + as-of 2026-09-20): free during validation — social density before dollars; monetization decided once sticky.
- Value metric: TBD

## Current riskiest assumption
- Assumption: TBD — being set by strategy's kickoff research (candidate: "friends will switch their location sharing to a separate non-Apple app for fun features")
- Smallest test: TBD
- Pass/fail threshold (pre-committed): TBD

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
