# Design direction — the aesthetic contract for slices 2–4

2026-09-20 · product · Closes the 09-26 open loop. This is a contract, not a brand system: no logo, no name work (codename MapMoment stands until the naming loop closes). Slice-1 code is NOT redesigned; where it already agrees, noted; where it must evolve, flagged with a one-line change.

**The sentence:** a quiet paper map that real photos live on — the opposite of Bump's sticker-bomb. Adult (22–30), analog (Retro is the reference), memory-first. If a screen would look at home in a teen app's TikTok ad, it's wrong.

## 1. Palette

Warm-neutral "print stock" base, one accent, friend colors muted and deterministic. Define all as asset-catalog colors with light/dark variants; never hardcode hex in views.

| Token | Light | Dark | Use |
|---|---|---|---|
| `paper` | `#F5F2EC` | `#15130F` | app background, sheets, photo borders |
| `surface` | `#FFFFFF` | `#201D17` | cards, scrubber, pills |
| `ink` | `#1C1B18` | `#EDEAE2` | primary text, self dot |
| `inkSecondary` | `#6B675E` | `#9B968A` | metadata, timestamps, late marks |
| `hairline` | `#E3DFD6` | `#2E2B24` | borders, dividers (1px, never shadows-as-borders) |
| `accent` | `#B04E2E` | `#D9764A` | ONE per screen: primary action (post moment), unread who-viewed count. Never decorative. |

**Friend-identity colors** — evolve slice-1, don't contradict: keep the deterministic seed (sum of id scalars) but map it into a fixed 8-swatch muted palette instead of a continuous hue wheel (`swatch[seed % 8]`). Continuous hue yields occasional neon greens/purples; fixed swatches guarantee taste and give photos/pins stable owner colors across map, archive, and who-viewed list. Same hexes both modes; white initials + `paper` stroke keep them legible.

Swatches: clay `#A15E43` · moss `#6E7A4A` · ochre `#A67C33` · pine `#4A7367` · slate `#54708A` · plum `#7C5E77` · rose `#9E5F68` · stone `#6E6A5E`

**Self:** the one neutral dot — `ink` fill, `paper` initials (you are the fixed point; friends are the color). One-line change from slice-1's `Color.blue` in `AvatarDot.fillColor`. Keep the existing white→`paper` 2.5pt stroke and soft shadow.

## 2. Typography

System fonts only, nothing bundled. Two designs, five roles — SF Pro for UI, New York (`.fontDesign(.serif)`, ships with iOS, zero cost) ONLY for memory surfaces: the archive date and moment-day headers. Serif = the past; sans = the present. Never SF Rounded (reads teen). Use Dynamic Type styles, not fixed sizes.

| Role | Font | Style |
|---|---|---|
| Archive/date header ("Tue, Sep 16") | New York | `.title2` semibold, `ink` |
| Screen titles / friend names | SF Pro | `.headline` semibold |
| Body / UI text | SF Pro | `.body` regular |
| Metadata (timestamps, "posted 22m late", viewed-by) | SF Pro | `.footnote` regular, `inkSecondary`, `.monospacedDigit()` on times |
| Avatar initials / badges | SF Pro | `.caption` semibold (matches slice 1) |

## 3. Map treatment (the single highest-leverage choice)

```swift
.mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))
```

`StandardEmphasis.muted` is real iOS 17 API (verified against Apple docs 2026-09-20): it desaturates the standard map and flattens street/building color contrast — Apple's cartography stops competing with the photos. Combined with POI exclusion (slice 1 already does this — add `emphasis: .muted` + `elevation: .flat`, a one-line change) and zero Apple UI chrome (no compass, no user-tracking button; keep `.ignoresSafeArea()`), the map reads as our quiet paper, not a default Apple map. Dark mode comes free — muted standard follows the system scheme.

**Not doing:** custom tile overlays (`MKTileOverlay` needs a `UIViewRepresentable` MKMapView rewrite), full-screen tint/blend layers over `Map` (hit-testing + perf risk), any third-party map SDK. All are stretches that don't fit the timeline; `emphasis: .muted` is the ship choice. REVISIT WHEN the beta passes and polish becomes the work.

## 4. Photo-on-map language

Moments are **small prints, not pins**: the photo in a 3pt `paper` border, corner radius 2pt (near-square — a print, not an app bubble), a 1.5pt hairline of the owner's friend swatch inside the border, soft shadow (black 15%, radius 4, y 2). Deterministic rotation jitter per moment id: −3° to +3° (`seed % 7 − 3`), so the day's map looks hand-laid, and identically hand-laid on every device. No tape, no torn edges, no film-grain filters — the analog feel is real photos on paper tokens, not skeuomorphic props.

- **Size:** ~64pt on the map; tap → full-screen moment (photo, name, place, time, viewed-by).
- **Clusters:** when prints overlap, a pile — top print full, one behind offset 4pt and counter-rotated, `+N` badge in `surface`/`ink`. V0 fallback if piles fight the clock: top print + `+N` badge only; the fanned pile is polish.
- **Late posts:** metadata only — "posted 22m late" in `inkSecondary`. No red, no shame UI, no desaturation.
- **Archive / date scrubber:** a `surface` bar over the map's bottom edge, days as serif labels, today rightmost. Scrubbing crossfades the day's prints in place (~200ms); the camera does not fly. Feel: flipping album pages, not time-travel VFX. Empty day: "No moment this day" in `inkSecondary` — quiet, no illustration.

## 5. Motion + feel

Restraint is the default: when nobody is touching the screen, nothing moves.

1. **Dots glide, never teleport.** Live-pin position changes animate `.easeInOut` ≥ 1s. No pulsing, no bouncing idle states.
2. **The moment reveal settles like laid-down prints.** Each print fades in scaling 0.96→1.0 into its jittered rotation, staggered ~50ms, once per day-load. No confetti, no spring overshoot.
3. **Scrubbing crossfades.** 200ms opacity between days; camera stays put.
4. **One haptic.** Light impact when your own moment posts. Nowhere else.

## 6. What we will NOT do (the anti-Bump list — check every slice against it)

- No stickers, emoji reactions rendered on the map, or cartoon avatars — initials or real photos only
- No gradients as decoration; flat token colors only (a gradient may exist solely as a legibility scrim under text on photos)
- No SF Rounded / bubbly display type; no more than the two designs above
- No streaks, badges, XP, confetti, or celebration animations
- No neon or saturated candy colors; nothing outside the token table; max one `accent` element per screen
- No countdown-pressure UI on the moment ping — the late mark is neutral metadata, not a scold
- No skeuomorphic kitsch (tape, polaroid frames with fake shadows, film grain, light leaks)
- No dark map-styling hacks (tile overlays, blend layers) inside slices 2–4

**Slice-1 deltas this contract asks for (all trivial, fold into slice-2 work, no dedicated pass):** add `emphasis: .muted, elevation: .flat` to `mapStyle`; swap `AvatarDot` continuous hue → 8-swatch table; self dot `Color.blue` → `ink`/`paper`; move hardcoded `.white`/`.blue` to tokens as the asset catalog lands.
