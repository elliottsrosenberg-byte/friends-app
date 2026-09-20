# MapMoment — manual setup (Elliott only)

The repo builds a runnable app, but the steps below need your Apple/Google
accounts. Do them in order. Everything else is already wired.

**Working codename:** MapMoment / `com.elliottrosenberg.mapmoment`. Display
name is a placeholder — real name comes later; changing it later is a
one-line edit in `project.yml` + a new Firebase iOS app.

## 0. Prerequisites (this machine)

- [ ] Install Xcode from the App Store (this Mac currently has only Command
      Line Tools — **nothing iOS can build until Xcode is installed**), then:
      `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`
- [ ] Install the Firebase CLI: `npm install -g firebase-tools`, then
      `firebase login`
- [ ] (Only if you add/remove files outside Xcode) `brew install xcodegen`,
      then `xcodegen generate` at repo root regenerates `MapMoment.xcodeproj`

## 1. Firebase project (console.firebase.google.com)

- [ ] Create project (suggested id: `mapmoment-beta`). Google Analytics: off
      (we wire our own metric events in slice 4).
- [ ] Add an **iOS app** with bundle id `com.elliottrosenberg.mapmoment`
- [ ] Download `GoogleService-Info.plist` and put it at
      `MapMoment/Resources/GoogleService-Info.plist` (it's gitignored)
- [ ] Add it to the Xcode target: either run `xcodegen generate`, or drag it
      into the MapMoment group in Xcode (check "MapMoment" target membership)
- [ ] **Authentication** → Sign-in method → enable **Apple**
- [ ] **Firestore Database** → Create database → production mode (rules come
      from this repo in step 4), region `us-central1` (or nearest)
- [ ] **Upgrade to the Blaze plan** — required for Cloud Functions. Free tier
      covers a 12-person beta; set a budget alert at ~$5 anyway.

## 2. Apple Developer / Xcode signing

- [ ] Open `MapMoment.xcodeproj` → target MapMoment → Signing & Capabilities
      → set your **Team** (Automatic signing)
- [ ] Verify capabilities are present (they're in the committed entitlements
      /Info.plist; Xcode may ask to register them on your account):
      **Sign in with Apple**, **Push Notifications**,
      **Background Modes → Location updates + Remote notifications**
- [ ] developer.apple.com → Certificates, IDs & Profiles → **Keys** → create
      an **APNs authentication key** (.p8). Note the Key ID and your Team ID.
      Download the .p8 (one-time download — keep it somewhere safe).

## 3. Connect APNs to Firebase

- [ ] Firebase console → Project settings → **Cloud Messaging** → iOS app →
      upload the APNs **.p8 key** with its Key ID + Team ID

## 4. Deploy backend from this repo

- [ ] `cd functions && npm install`
- [ ] At repo root: `firebase use --add` → pick the project → alias `default`
      (this creates `.firebaserc`; commit it)
- [ ] `firebase deploy` — deploys Firestore rules + the `sendTestPing`
      function

## 5. The slice-1 end-to-end test (two iPhones)

Push and Sign in with Apple do NOT work in the Simulator — this needs two
real devices signed into different Apple accounts (yours + one friend's).

- [ ] Build to iPhone #1: sign in with Apple → allow notifications → allow
      location "While Using" → tap "Change to Always Allow" when prompted
- [ ] Repeat on iPhone #2
- [ ] Both dots visible on both phones' maps
- [ ] Tap **Test ping** on either phone → both phones get the push
- [ ] Walk a few blocks (significant-change ≈ cell-tower granularity, so
      expect ~500 m before an update) → the dot moves on the other phone

If all four boxes check, slice 1 is done and slice 2 (the moment loop) starts.

## What is verified vs. not (honest status)

Verified locally without your accounts:
- XcodeGen project generation, Swift file syntax, Cloud Function syntax +
  `npm install`, and mock mode design (fake friends, no Firebase needed:
  Simulator scheme argument `--mock`, or just run without
  GoogleService-Info.plist — it falls back to mock automatically).

NOT verified (impossible without the steps above / Xcode installed):
- An actual `xcodebuild` compile (no Xcode on this Mac yet — do step 0 first
  and expect possible small compile fixes; the Firebase SPM fetch on first
  build takes several minutes)
- Sign in with Apple, live Firestore sync between devices, push delivery
