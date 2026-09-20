# Department notes — this file is copied to .cofounder/departments/{strategy,product,marketing,sales}.md

## Log (newest first)

### 2026-09-20 — Design direction one-pager shipped

`departments/design-direction.md` — the aesthetic contract for slices 2–4 (closes the 09-26 loop). Anti-maximalist, analog/memory-first: paper-neutral palette with one accent (hex tokens, light+dark), SF Pro + New York serif for memory surfaces only, map muted via iOS 17 `MapStyle.StandardEmphasis.muted` (verified real API), moments as bordered near-square prints with deterministic rotation jitter, 4 motion rules, and an explicit anti-Bump NOT list. Friend colors evolve slice 1's continuous-hue formula into a fixed 8-swatch muted table (same deterministic seed); self dot goes `Color.blue` → ink/paper. All slice-1 deltas are one-liners folded into slice-2 work — no redesign pass.

### 2026-09-20 — Slice 1 build notes (walking skeleton scaffolded)

Built exactly slice 1 of scope v2 — nothing from slices 2–5. Repo root now holds the full skeleton:

- **Xcode project:** `project.yml` (XcodeGen spec, committed) → generated `MapMoment.xcodeproj`. iOS 17+, SwiftUI lifecycle, bundle id `com.elliottrosenberg.mapmoment`, Firebase via SPM (`firebase-ios-sdk` 12.x: Auth, Firestore, Messaging, Functions). Regenerate with `xcodegen generate` after adding files outside Xcode.
- **App** (`MapMoment/`): `AuthService` (Sign in with Apple → Firebase Auth, nonce/SHA256 flow), `GroupStore` (hardcoded single group = the whole `users` collection, live snapshot listener), `LocationService` (When-In-Use → Always two-step upgrade, significant-change monitoring + foreground refresh, 30s publish throttle), `PushService` + `AppDelegate` (APNs → FCM token → user doc), `MapScreen` (iOS 17 Map API, initials avatar dots, deterministic muted per-friend color, "Test ping" button calling the function), `AppModel` orchestrator.
- **Mock mode:** `--mock` launch arg / `MAPMOMENT_MOCK=1` (DEBUG), and automatic fallback whenever GoogleService-Info.plist is absent — 5 fake friends drifting around the Mission, zero Firebase calls. The Simulator runs the UI with no credentials.
- **Backend:** `functions/index.js` (JS, functions v2, Node 22) — callable `sendTestPing` fans one push out to every registered device and prunes dead tokens; commented `onSchedule` stub marks where the slice-2 daily moment ping goes. `firestore.rules` (read = any authed member, write = own doc only), `firebase.json`.
- **Info.plist:** Always-location string written for Guideline 2.5.4 (names the user-visible feature, low-power method, private group, pause-anytime). Background modes: location + remote-notification. `ITSAppUsesNonExemptEncryption` pre-set for TestFlight.
- **SETUP.md:** literal checklist of the Elliott-only steps (Firebase console, plist download, signing team + capabilities, APNs key, deploy, two-phone test).

**Verified locally:** xcodegen generation clean; all 12 Swift files pass `swiftc -parse`; plists lint; `functions/` `npm install` + module `require()` load clean; pbxproj contains the SPM products/settings as intended.
**NOT verified (honest):** compilation and running — this Mac has no Xcode.app (Command Line Tools only), so `xcodebuild` for the Simulator is impossible until Elliott installs Xcode (open loop, due 09-23). Expect small compile fixes on first build. Sign in with Apple + push need real devices/accounts regardless (SETUP.md step 5 is the slice-1 exit test).

Decisions worth recording: XcodeGen over hand-rolled pbxproj (regenerable, reviewable diffs); JS over TS for functions (one fewer build step at this size); GoogleService-Info.plist gitignored. REVISIT WHEN team >1 or functions grow past ~3 files (then TS + typed schemas).

### 2026-09-20 — MVP scope v2 (hybrid loop: daily map moment + ambient live map)

# Friends App — MVP scope (2026-09-20)

Assumption this tests (re-derived for the hybrid, supersedes the always-on-only D2):
**"~12 post-college friends will install a separate app, grant Always-on location, answer the daily map-moment ping, and still be posting AND sharing in week 4."** Two retention loops, measured separately, so a partial fail tells us which half of the hybrid is the product.

Pre-committed pass/fail (written before building):
- **Week 1 PASS:** ≥8 of ~12 invited friends install, grant Always location, and post ≥1 moment.
- **Week 4 PASS:** ≥50% of installers post ≥3 of 7 daily moments that week, AND ≥50% still have live sharing ON.
- Any miss = FAIL overall. Diagnostic split: posting holds but sharing turned off → the ritual is the product, drop always-on; sharing holds but posting dies → we rebuilt Zenly, the moment was novelty.

The demo that proves it works: At 8:14pm every phone in the group buzzes. Within 10 minutes the map fills with photos pinned where each friend actually is — one at the gym, one at a bar, one home cooking. Swipe the date scrubber back and the map rewinds to yesterday's moment, and last Tuesday's. Outside moment time, opening the app shows the live map of where everyone is right now, and you can see who peeked at your moment.

## In (the 80% version)
- Sign in with Apple + join-the-group invite link; ONE hardcoded friend group (demo: everyone is on the same map)
- Live map: friends as avatar dots at current location, Always-on background updates, MVP-grade fidelity (significant-change based; Zenly-grade battery polish is not the bar) (demo: "opening the app shows where everyone is")
- Global share on/off toggle in settings — one switch, the minimum trust valve (App Store + ethics floor; replaces invisibility windows)
- Daily map moment: server schedules one ping/day inside an evening window → push → in-app camera → photo posts pinned at auto-captured location → today's shared moment-map; late posts allowed and marked late (demo: the 8:14pm scene)
- Archive v0: date scrubber over past moment-maps, group-visible; moments only, NOT continuous location history (demo: "the map rewinds")
- Who-viewed (spying ping, adapted): list of who viewed your moment / your live pin (demo: "see who peeked"; the category's only proven willingness-to-pay feature — whoo ¥390/mo)
- Metrics wired from build one: install_activated, always_granted, daily sharing_heartbeat, moment_posted (+ latency from ping), app_open, moment_viewed
- Backend (proposed, needs Elliott's confirm per stack rule): Firebase — Auth (Sign in with Apple), Firestore (locations + moments), Storage (photos), Cloud Functions + APNs (moment ping). Rationale: fastest path to live sync + scheduled push for a solo builder; swap-out risk acceptable at 12 users.

## Out (the cut list — copied to status.md Later)
- Invisibility windows (precise/frozen/blurred) — CUT: Apple ships native pause-sharing fall 2026; friends-only beta has baseline trust; global toggle covers the floor. Revisit at public launch.
- @-location posting outside the moment — later: the moment IS posting v1; free-posting dilutes the ritual before it's proven.
- Reactions/comments on moments — later: the group chat is the comment thread during beta (concierge beats built); revisit if week-2 feels dead.
- Continuous location history / paid time-travel depth — later: it's the monetization layer, pointless before retention.
- Audio moments / prompts (Hum-style) — later: Elliott's friend built Hum (humtoday — daily audio + prompt ritual); adjacent mechanic worth a conversation and maybe cross-pollination, but a second capture medium doubles MVP surface. Talk to founder ≠ build.
- Smart friend insights — stays cut (no precedent, privacy-heavy).
- Multiple groups / friend management, streaks/gamification, Android, custom moment timing, settings beyond the share toggle, moment-time editing — all later; a 12-person beta needs none of them.

## Sequence (~26 days left to 2026-10-20)
1. **Days 1–5 — walking skeleton (extends the existing feasibility spike):** two iPhones, Sign in with Apple, both dots live on a shared SwiftUI/MapKit map via Firebase, one push notification received. End-to-end or bust.
2. **Days 6–12 — the moment loop:** scheduled Function → push → camera → photo+pin upload → today's moment-map renders on all devices; late-post handling.
3. **Days 13–17 — archive + who-viewed:** date scrubber; viewed-by lists on moments and live pins.
4. **Days 18–21 — instrument + polish floor:** all six metric events verified end-to-end; empty states (pre-first-moment map, solo-user map); share toggle; app icon; battery sanity pass (a day of Always-on ≤ acceptable drain on Elliott's own phone).
5. **Days 22–26 — ship:** App Store Connect, TestFlight review (background-location justification per Guideline 2.5.4 ready), invite message drafted → hub queue for Elliott, buffer for review bounces.
Ship deadline sanity: fits ONLY with the cut list held — invisibility windows, reactions, and a second capture medium would each eat the buffer. The date doesn't move; the scope does.

## Measurement
OMTM: **weekly moment participation rate** (% of installed friends posting ≥3 moments/week). Secondary: sharing-ON rate (the hybrid's second loop). Events listed in "In," wired in slice 4, verified before invites go out — a launch you can't measure is an open loop.

<!-- Each department keeps its working notes here: strategy = research findings & briefs;
     product = build notes; marketing = growth log (channel, hypothesis, time box, KEEP/KILL);
     sales = pipeline (account, stage, next action, date). -->
