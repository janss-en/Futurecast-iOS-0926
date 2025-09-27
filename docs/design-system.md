# Futurecast – Design System v1 (Standalone Spec)

> **Purpose**
> This document is a self-contained, implementation-ready design system for the Futurecast iOS app. It assumes **no prior context** and explains brand, tokens, components, patterns, and key flows. It is optimized for a dark default theme with an optional light theme.

---

## 1) Product Snapshot

**Futurecast** helps people manifest goals through a TikTok-style feed of **visualizations** paired with **affirmations** (user‑recorded or TTS). Users can loop visuals, organize them into boards, and listen on the go (including screen-off).

**Primary loop**: Create → Play/Loop → Share → Organize → Progress → Repeat.

---

## 2) Brand Foundations

* **Vibe:** Sleek/ambient with subtle playful accents; private-first; motivating and calm.
* **Themes:**

  * **Dark (default):** Warm Graphite base.
  * **Light (optional):** Warm Ivory base (user setting).
* **Accent:** Mint/Teal.
* **Corners:** Major surfaces 28pt; FAB 18–20pt; buttons 14–16pt; chips 12pt.
* **Spacing:** Cozy rhythm, 12pt base grid.
* **Elevation (matte cards):** soft shadow **+** hairline stroke for crisp edges.

---

## 3) Color & Tokens (starters)

* **Dark base:** Graphite `#0E0F10` / `#131416`; content text `#EDEFF1`.
* **Light base:** Warm Ivory; content text `#171819`.
* **Mint:** 400 `#6FE3D8`, 500 `#2ED3C6`, 600 `#18C8B4`.
* **Hairline:** dark = white@10–12%; light = graphite@12–14%.
* **Danger:** accessible salmon/tomato range.
* **Glass tint:** dark = white@10–14%; light = graphite@10–12%; blur 24–32pt; saturation +1.2–1.4.

> **Usage rule:** Use **mint + soft glow** only on key actions and glass chrome. Default controls use flat mint; progress rings/sliders may use a subtle mint gradient.

---

## 4) Typography & Iconography

* **Body/UI:** Neutral Humanist Sans (e.g., SF Pro/Inter).
* **Display accents:** Rounded Sans (e.g., SF Rounded) for hero numerals, key CTAs, badges.
* **Headline (card title):** 22–24 pt / 1.2 lh / SemiBold.
* **Body:** 16 pt / 1.45 lh / Regular.
* **Meta/labels:** 13–14 pt / Medium.
* **Numerals:** tabular lining for timers.
* **Icons:** Rounded outline by default; filled variant for active states. Sizes: 24 pt (default), 28–32 pt (primary). Hit targets ≥48 pt.

---

## 5) Motion & Haptics

* **Style:** **Hybrid** — calm transitions, snappy interactions (Apple-like).
* **Durations:** buttons 160–220ms; sheets 280–360ms; card settle 600–700ms.
* **Parallax:** 2–4pt on card settle (disabled with Reduce Motion).
* **Haptics:** light (tap), soft (play/pause), medium (success), rigid (error).
* **Accessibility:** If Reduce Motion/Transparency is ON, disable parallax and glass; use matte crossfades (120–160ms).

---

## 6) Materials

* **Liquid Glass** for chrome (dock, bottom sheets, floating control strip, mini-player).

  * Blur 24–32pt; tint 10–14%; 1px hairline; slight opacity gain on busy content.
* **Matte** for content cards to guarantee contrast; pair soft shadow + hairline.

---

## 7) Information Architecture (iOS v1)

* **Tabs (2):**

  1. **Home** — single-card feed (tiny peek of next), Momentum strip above.
  2. **Library** — Boards + Saved + Playlists (segmented control).
* **Profile** via avatar flyout (account, Personal Visual Pack, theme, settings).
* **Smart "+"** floating action → opens quick-create sheet: **Record** or **Create Visualization**.
* **Now Playing mini-bar** pinned above dock → expands to full player.

---

## 8) Components

**Momentum Strip (Home):** Minutes-first progress summary (ring + bar). Collapses to chip on scroll; tap to open Progress Drawer.

**Feed Card:** Top = visual; below = affirmation (user's raw words, lightly tidied), 2-line clamp; meta row (board • duration). Floating **glass strip** with **Play/Pause • Loop • Share • More**. Share opens a small Share sheet.

**Quick-Create Sheet:** Two big choices — **Record Affirmation** or **Create Visualization**. Recent creations row at bottom.

**Full Player:** large cover, scrubber, queue, ambient controls.

**Library Grid:** Uniform 2-column board tiles. Tiles use **mini-collage** covers (fallback to single image).

**Board Detail:** Hero cover + **2-column grid** of items; top-right **Grid/List** toggle. **Loop Board** queues **starred** items by default (Include all optional).

**Progress Drawer:** streak ring, minutes listened, creations, per-board micro-rings, one-line insights.

**Edit Mode (Boards):** visible **Select**; batch Star/Move/Delete/Download; Sort (Most Played, Newest, A–Z).

---

## 9) Creation Flows (spec)

### A) Record Affirmation (audio-first)

1. Record → transcribe (light grammar tidy).
2. Instant **template cover** (mint gradient).
3. Inline **Enhance with Visual**: if likeness consent is ON, auto-apply best **Personal Visual Pack** (PVP) reference; else **No people**.
4. Background AI suggestions (3 variants) → **Set as Cover** or keep template.
5. If no recording, fallback to **pleasant TTS**.

### B) Create Visualization (photo-first)

1. Choose **Selfie** or **Goal image** (camera/library).
2. **Selfie defaults:** **Natural uplift** (realistic; preserve identity).
3. Style chips: **Natural / Stylized / Abstract**; scope chips: **Skin/Eyes/Hair**, **Background**, **Lighting/Color**, **Accessories**; Strength slider.
4. Generate 3 variants → **Set as Cover**.
5. Add affirmation by recording or typing; TTS if none.

> **Deferred "Generate from affirmation"** appears after recording as **Enhance with Visual** (keeps the sheet simple).

### Personal Visual Pack (PVP)

* **Nudge timing:** after first successful creation.
* **Minimum:** 3 selfies (quality coach).
* **Consent toggles:** Use likeness; light cosmetic enhancement; no body edits (default off).
* **Auto-apply:** ON selects best reference; chip shows **"Reference: Auto • Change"**.
* **Manage:** refresh suggestions ~ quarterly; one‑tap pause.

---

## 10) Playback & Audio

* **Autoplay audio in feed:** global toggle (default OFF); per-card tap-to-play; honors Silent Mode.
* **Lock screen:** Now Playing controls + cover; audio continues with screen off.
* **Ambient channel (v2):** ask on first use; **Lo‑fi** default if enabled; separate volume; duck −8 dB under voice; persists across cards.

---

## 11) Share & Virality

* **Default share:** short vertical video, 9:16 (1080×1920), 6–8s, normalized audio.
* **Branding:** **subtle logo bug** bottom-right (12–14px @60% opacity; auto-invert).
* **Sheet toggles:** 5s/10s, include/mute audio, safe-zone crop.
* **Caption helper:** editable one-liner.
* **Privacy:** strip EXIF; revocable short link.

---

## 12) Progress & Motivation

* **Daily goal:** 1 positive action/day (≥30s play or a creation).
* **Weekly goal:** minutes target (editable).
* **Grace tokens:** 2/month to protect streaks.
* **Reminders:** no push by default; after habit detection, offer **Encouraging** opt‑in.
* **Board-level progress:** minutes and days per board; Loop Board focuses on starred items.

---

## 13) Accessibility & Internationalization

* Text contrast ≥ 4.5:1; add 1px keyline on mint fills if needed.
* Dynamic Type up to 2×; clamp headlines; overflow wraps below image.
* VoiceOver order on strip: Play → Loop → Share → More (announce duration & loop state).
* RTL ready; Noto Sans fallback.
* Reduce Motion/Transparency respected.

---

## 14) Safety & Consent

* Selfie edits: **Natural uplift** by default; preserve identity; no body/age changes without explicit opt-in.
* Faces in goal images require consent; otherwise default to **No people**.
* Inclusive language in Prompt Assist; culture‑neutral defaults.

---

## 15) Metrics to Track

* Time to first creation (TTFC).
* % who set AI/photo cover vs. template.
* Minutes listened (week 1, week 4).
* Ambient channel adoption & retention.
* PVP opt‑in and refresh cadence.
* Share rate and open-through from shared links.

---

## 16) Implementation Notes (iOS)

* Prefer system **Liquid Glass** materials; fallback to matte if Reduce Transparency is ON.
* Lock safe areas for the floating strip; respect home indicator.
* Media loudness normalization; ducking for ambient channel; gapless loops.
* Export pipeline for share: GPU-friendly; safe-zone aware.

---

## 17) Glossary (quick)

* **Affirmation:** text + (optional) user voice or TTS.
* **Visualization:** cover art for the affirmation; may be template, photo, or AI-generated.
* **Board:** collection of visualizations; can be looped.
* **PVP:** Personal Visual Pack (reference selfies used for consistent, consented likeness).
* **Focused Queue:** starred items in a board used by Loop Board.

---

## 18) v1 Build Order (suggested)

1. Home feed + cards + strip + Smart "+" sheet.
2. Record/transcribe + template covers + photo‑first flow.
3. TTS + full player + lock screen.
4. Library/Boards (grid + detail + Loop Board starred).
5. Share sheet + short video export + logo bug.
6. Progress strip + Drawer + encouraging opt‑in reminders.
7. PVP nudge + manager.
8. v1.1: Async AI visual suggestions; Ambient channel ask‑on‑first‑use.