

# HouseBinder — Development Stages / Phased Plan (Flutter)

This document turns `HouseBinder.md` into an actionable build plan with clear phases, deliverables, and feature lists. The goal is a **cross-platform Flutter app** supporting:

- iOS
- Android
- macOS
- Windows
- Linux

Design principles:
- **Offline-first** by default.
- **Export everything** (user owns their data).
- **Fast capture** (scan/quick add).
- **Trustworthy history** (service log, receipts, warranties).
- **No forced AI workflows** (manual entry always available).

Status legend:
- [x] Done
- [~] Partial / in progress
- [ ] Not started

Status summary (based on current codebase):
- [~] Phase 0 — Foundations (Project Setup & Architecture)
- [~] Phase 1 — MVP Data Model & Offline Storage
- [~] Phase 2 — MVP UI: Inventory + Tasks + History
- [~] Phase 3 — Templates, Reminders, and Seasonal Checklists
- [~] Phase 4 — House Binder PDF Report
- [~] Phase 5 — “Export Everything” Package + Robust Import
- [ ] Phase 6 — Scan-to-Add (Label OCR) + Manual Lookup
- [ ] Phase 7 — Recall Monitoring (Opt-In) + Safety Features
- [~] Phase 8 — Multi-Property + Landlord Mode + Collaboration
- [ ] Phase 9 — Cloud Backup & Sync
- [~] Phase 10 — Polishing & Cross-Platform Excellence
- [ ] Phase 11 — Competitive Enhancements & “Nice-to-have” Features

---

## Phase 0 — Foundations (Project Setup & Architecture)

### 0.1 Project creation
Status: [~] Partial (Flutter targets present; CI not set up)
- [x] Create Flutter project and enable desktop targets
  - [x] `flutter config --enable-macos-desktop`
  - [x] `flutter config --enable-windows-desktop`
  - [x] `flutter config --enable-linux-desktop`
- [ ] Setup repo and CI (GitHub Actions)
  - [ ] build/test on push
  - [ ] lint formatting

### 0.2 Packages & tooling
Status: [~] Partial
- [x] State management: `flutter_riverpod`
- [x] Local database: `drift` + `sqlite` (strong relational querying)
- [x] File system: `path_provider`, `file_picker`
- [x] Media: `image_picker` (mobile), `file_picker` (desktop)
- [x] PDF generation: `pdf`, `printing`
- [~] Search indexing: basic DB search only (no `fuse`/custom index yet)

### 0.3 Architecture decisions
Status: [~] Partial
- [x] Domain-driven separation:
  - [x] `domain/` models
  - [x] `data/` persistence
  - [x] `application/` services (PDF export, import/export, reminders)
  - [x] `presentation/` UI
- [~] Repository pattern for all entities (CRUD via providers/AppDatabase)
- [ ] App-wide event log (optional early): `AuditLog` table

### 0.4 Cross-platform UI strategy
Status: [~] Partial
- [x] Use responsive/adaptive layout
  - [x] narrow screens: bottom navigation
  - [x] wide screens: navigation rail / split view
- [ ] Keyboard shortcuts (desktop)
- [ ] Drag/drop file support (desktop)

### 0.5 Core settings model
Status: [~] Partial
- [x] Currency
- [ ] electricity rate (optional future)
- [x] units (imperial/metric)
- [ ] privacy mode (no cloud)

**Deliverable:** App builds and runs on all targets with empty screens and navigation.

---

## Phase 1 — MVP Data Model & Offline Storage

### 1.1 Core entities (initial schema)
Status: [~] Partial (core schema exists; some fields/features missing)

#### Property (Home)
Status: [x] Done
- id (UUID)
- name
- address (optional)
- yearBuilt (optional)
- notes (optional)

#### Asset (Appliance/System)
Status: [~] Partial (core fields present; parts/consumables not modeled)
- id, propertyId
- name
- category (HVAC, Plumbing, Electrical, Kitchen, Exterior, Other)
- locationRoom
- manufacturer
- model
- serial
- installDate / purchaseDate
- warrantyExpirationDate
- photos[] (paths)
- documents[] (paths)
- notes

#### MaintenanceTask
Status: [~] Partial (no explicit status enum)
- id, propertyId
- title
- category
- frequencyRule (RRULE-like)
- nextDueDate
- linkedAssetIds[]
- instructions
- estimatedCost (optional)
- estimatedTimeMinutes (optional)
- reminderEnabled
- lastCompletedDate

#### ServiceRecord
Status: [~] Partial (no next recommended interval field)
- id, propertyId
- date
- assetIds[]
- taskId (optional)
- contractorId (optional)
- cost
- notes
- attachments[] (invoice paths)

#### Contractor
Status: [~] Partial (preferred flag + contact info present; invoices/history not modeled)
- id, propertyId
- name
- tradeType
- phone
- email
- address
- notes

#### Document
Status: [x] Done
- id, propertyId
- title
- category
- filePath
- linkedAssetId (optional)
- dateAdded
- notes

### 1.2 Repositories
Status: [~] Partial (CRUD exists via AppDatabase/providers; no repository classes)
- [~] PropertyRepository (providers/AppDatabase only)
- [~] AssetRepository (providers/AppDatabase only)
- [~] TaskRepository (providers/AppDatabase only)
- [~] ServiceRecordRepository (providers/AppDatabase only)
- [~] ContractorRepository (providers/AppDatabase only)
- [~] DocumentRepository (providers/AppDatabase only)

Include:
- [x] CRUD
- [x] filtering by property
- [~] common queries (assets by room/category, overdue tasks, warranty expiring soon)

### 1.3 Seed data
Status: [~] Partial
- [~] Create default property “My Home” (handled via onboarding, not auto-created)
- [x] Add default maintenance templates (see Phase 3)

**Deliverable:** Stable data layer + basic CRUD endpoints internally (repositories fully tested). [~] Tests not present.

---

## Phase 2 — MVP UI: Inventory + Tasks + History

### 2.1 Navigation
Status: [x] Done
- [x] Home / Dashboard
- [x] Assets
- [x] Tasks
- [x] Service History
- [x] Contractors
- [x] Documents
- [x] Settings

### 2.2 Home Dashboard
Status: [~] Partial (recently added assets/documents not shown)
- [~] Upcoming tasks (next 7/30 days)
- [x] Overdue tasks count
- [x] Warranties expiring soon
- [ ] Recently added assets/documents
- [x] Quick actions:
  - [x] Add Asset
  - [x] Add Task
  - [x] Add Service Record
  - [x] Add Document

### 2.3 Assets UI
Status: [~] Partial (photos/label capture not implemented)
- [x] Asset list
  - [x] search by name/model/manufacturer
  - [~] filters: category, room
- [~] Asset detail
  - [ ] photos & label photo
  - [x] manufacturer/model/serial
  - [x] warranty info
  - [x] linked tasks
  - [x] linked service records
  - [~] attachments (manuals/receipts via Documents)
- [x] Add/edit asset form

### 2.4 Tasks UI
Status: [~] Partial (no service record prompt on completion)
- [~] Task list with filters
  - [~] due soon
  - [x] overdue
  - [ ] seasonal
  - [ ] by asset
- [~] Task detail
  - [x] instructions
  - [x] reminder settings
  - [ ] completion history
- [~] Complete task flow
  - [x] mark complete
  - [ ] optionally add service record entry

### 2.5 Service History UI
Status: [~] Partial (filters not implemented)
- [x] Chronological timeline
- [ ] Filter by asset, contractor
- [x] Add service record form

### 2.6 Contractors UI
Status: [~] Partial (no service history view in detail)
- [x] Contractor list
- [ ] Contractor detail with history
- [x] Quick call/email buttons (mobile)

### 2.7 Documents UI
Status: [~] Partial (opens files externally)
- [x] Document vault list
- [x] Filter by category
- [x] Link docs to assets
- [ ] View PDF/image in-app

**Deliverable:** Fully usable offline home maintenance tracker without PDF export.

---

## Phase 3 — Templates, Reminders, and Seasonal Checklists (Competitor Baseline)

Competitors win by providing ready-to-use reminders and checklists. This stage gets parity.

### 3.1 Built-in templates (starter library)
Status: [x] Done
Create a template catalog with:
- **Monthly**
  - Test smoke/CO detectors
  - Check HVAC filter (if needed)
- **Quarterly**
  - Replace HVAC filter
  - Flush water heater (optional)
- **Spring**
  - Clean gutters
  - AC tune-up reminder
  - Check exterior drainage
- **Summer**
  - Inspect sprinklers
  - Check attic ventilation
- **Fall**
  - Furnace tune-up
  - Winterize exterior spigots
- **Winter**
  - Check basement humidity
  - Inspect for ice dam issues

Each template task includes:
- frequency
- estimated time
- instructions
- safety notes

### 3.2 Task recurrence engine
Status: [x] Done (interval-based recurrence with snooze/skip)
- [x] RRULE-lite recurrence (monthly, quarterly, yearly, custom intervals)
- [x] “Snooze” functionality
- [x] “skip this occurrence” vs “complete late”

### 3.3 Notifications
Status: [ ] Not started
- [ ] Local notifications (mobile)
- [ ] Desktop notifications (macOS/Windows/Linux)
- [ ] User control:
  - [ ] quiet hours
  - [ ] reminder lead time

### 3.4 Onboarding wizard
Status: [~] Partial
- [x] Create property
- [ ] Add top 5 assets (furnace, water heater, fridge, dishwasher, washer/dryer)
- [ ] Choose maintenance template pack

**Deliverable:** Users can be productive within 5 minutes (big adoption boost).

---

## Phase 4 — House Binder PDF Report (The Differentiator)

This is the single most important differentiator.

### 4.1 Binder report formats
Status: [ ] Not started (single report type only)
- [ ] **Seller Report**
  - [ ] asset inventory + age
  - [ ] maintenance history summary
  - [ ] warranties
  - [ ] contractor list
- [ ] **Insurance Report**
  - [ ] asset inventory
  - [ ] serial/model numbers
  - [ ] receipt index
- [ ] **Contractor Packet**
  - [ ] relevant asset details
  - [ ] last service records
  - [ ] notes

### 4.2 Report sections (configurable)
Status: [~] Partial (most sections present; property overview/upcoming ranges limited)
- [ ] Property overview
- [x] Asset inventory (by category and room)
- [x] Warranty expirations
- [x] Maintenance history (last 12/24 months)
- [~] Upcoming tasks (included, but no 30/90 day range selection)
- [x] Service providers
- [x] Document index

### 4.3 UX
Status: [~] Partial (single report type; no preview/photos toggle)
- [~] Export wizard:
  - [ ] choose report type
  - [x] choose date ranges
  - [x] include/exclude sections
  - [ ] include photos (toggle)
- [ ] Preview
- [x] Save/share

### 4.4 Branding
Status: [~] Partial (cover page + timestamp present; owner name not captured)
- [x] optional cover page
- [~] property name + owner
- [x] export timestamp

**Deliverable:** One-tap professional PDF house binder.

---

## Phase 5 — “Export Everything” Package + Robust Import (Competitive Edge)

Competitor weakness (notably Centriq): export does not include everything. This phase is the wedge.

### 5.1 Export formats
Status: [~] Partial (backup zip + JSON + files present)
- [~] **HouseBinder Backup (.zip)** containing:
  - [x] `housebinder.json`
  - [~] `assets/` photos and label images
  - [~] `documents/` PDFs/receipts/manuals
  - [~] `reports/` most recent binder PDF (included if stored under HouseBinder directory)
  - [x] `schema_version.txt`

### 5.2 Import formats
Status: [~] Partial
- [~] Import HouseBinder backup
  - [x] validate schema version
  - [ ] merge vs overwrite
  - [ ] preview changes before applying
- [ ] Import CSV inventory
  - [ ] standardized template
  - [ ] mapping UI

### 5.3 Centriq migration (optional but powerful)
Status: [ ] Not started
- [ ] Add “Import Centriq CSV”
- [ ] Map their columns to Asset schema
- [ ] Warn that photos/manuals may not exist in their export

### 5.4 Integrity & safety
Status: [ ] Not started
- [ ] automatic backup before import
- [ ] rollback on error

**Deliverable:** Users can leave any time with their full data, and can migrate in easily.

---

## Phase 6 — Scan-to-Add (Label OCR) + Manual Lookup (Centriq Parity)

This is the UX feature that sells.

### 6.1 Label capture
Status: [ ] Not started
- [ ] Camera capture for label photo
- [ ] Crop UI

### 6.2 OCR
Status: [ ] Not started
- [ ] OCR text extraction (on-device when possible)
  - [ ] iOS: Vision
  - [ ] Android: ML Kit
  - [ ] Desktop: optional Tesseract fallback or manual mode

### 6.3 Smart parsing
Status: [ ] Not started
- [ ] detect likely:
  - [ ] manufacturer
  - [ ] model
  - [ ] serial
- [ ] user confirms fields

### 6.4 Manual lookup
Status: [ ] Not started
- [ ] search web for manuals (manufacturer + model + “manual PDF”)
- [ ] let user choose best match
- [ ] save URL or download PDF into document vault

### 6.5 Parts & consumables scaffolding
Status: [ ] Not started
- [ ] allow user to add “consumable” records to an asset
  - [ ] filter size/model
  - [ ] replacement frequency
  - [ ] quick link to buy

**Deliverable:** Add an appliance in under 60 seconds with label scan + manual attached.

---

## Phase 7 — Recall Monitoring (Opt-In) + Safety Features

Centriq highlights recall monitoring. Many homeowners want this.

### 7.1 Recall monitoring (opt-in)
Status: [ ] Not started
- [ ] periodic check (weekly)
- [ ] user chooses:
  - [ ] internet-based check
  - [ ] manual check only
- [ ] show recall alerts with source links

### 7.2 Safety checklists
Status: [ ] Not started
- [ ] monthly smoke/CO checks
- [ ] GFCI test reminders
- [ ] dryer vent cleaning reminders

### 7.3 Liability-safe language
Status: [ ] Not started
- [ ] “informational only” disclaimers
- [ ] do not claim compliance

**Deliverable:** Safety value-add that increases trust.

---

## Phase 8 — Multi-Property + Landlord Mode + Collaboration

This is where paid users exist.

### 8.1 Multi-property support
Status: [~] Partial
- [x] multiple homes/properties
- [x] property switcher
- [ ] property tags/folders

### 8.2 Landlord / turnover mode
Status: [ ] Not started
- [ ] inspection checklist template
- [ ] move-in/move-out reports
- [ ] tenant notes (non-sensitive)

### 8.3 Collaboration
Status: [~] Partial (PDF/backup sharing exists, no shared properties)
- [x] share read-only binder PDF
- [x] share backup file
- [ ] optional cloud-based shared property (Phase 9)

**Deliverable:** Expand market beyond homeowners into landlords.

---

## Phase 9 — Cloud Backup & Sync (Pro Tier)

Competitor reviews show users will pay for reliable automatic backup.

### 9.1 Backup options
Status: [ ] Not started
- [ ] iCloud Drive
- [ ] Google Drive
- [ ] Dropbox
- [ ] WebDAV / Nextcloud (power users)

### 9.2 Sync model
Status: [ ] Not started
- [ ] simplest: file-based sync of backup package
- [ ] advanced: entity-level sync with conflict resolution

### 9.3 Versioning
Status: [ ] Not started
- [ ] keep last N backups
- [ ] daily snapshots

**Deliverable:** “Never lose my house binder” peace of mind.

---

## Phase 10 — Polishing & Cross-Platform Excellence

### 10.1 Desktop polish
Status: [ ] Not started
- [ ] keyboard shortcuts
- [ ] drag/drop PDF receipts into document vault
- [ ] multi-window support (optional)
- [ ] context menus

### 10.2 Performance
Status: [ ] Not started
- [ ] fast search index
- [ ] large photo library handling

### 10.3 Accessibility
Status: [ ] Not started
- [ ] VoiceOver/TalkBack support
- [ ] large text
- [ ] focus order

### 10.4 App store readiness
Status: [~] Partial (onboarding/empty states present)
- [x] onboarding and empty states
- [ ] screenshots
- [ ] privacy policy

**Deliverable:** Professional-grade release quality.

---

## Phase 11 — Competitive Enhancements & “Nice-to-have” Features

These are features competitors mention or that users frequently request.

### 11.1 Warranty alerts & renewal
Status: [ ] Not started
- [ ] warranty expiration reminders
- [ ] store warranty PDFs

### 11.2 Budget tracking (optional)
Status: [ ] Not started
- [ ] yearly spend by category
- [ ] graphs

### 11.3 Smart lists
Status: [ ] Not started
- [ ] overdue tasks
- [ ] expiring warranties
- [ ] high-cost assets
- [ ] recently serviced

### 11.4 Favorites
Status: [ ] Not started
- [ ] pinned assets
- [ ] pinned contractors

### 11.5 Home sale “handoff” mode
Status: [ ] Not started
- [ ] generate “buyer-friendly” binder
- [ ] hide private notes

---

## Recommended Release Plan

### v0.1 (internal)
- Phase 0–2

### v1.0 (public MVP)
- Phase 3–4

### v1.5 (competitive edge)
- Phase 5

### v2.0 (delight)
- Phase 6

### v2.5 (premium / safety)
- Phase 7

### v3.0 (pro)
- Phase 8–9

---

## Competitor Learnings Embedded in the Plan

Based on competitor reviews and Reddit user feedback:

- Users dislike **hidden paywalls** and forced AI workflows.
- Users want **manual entry** and full ownership of their data.
- Export must include **photos + manuals + receipts** (a known gap).
- Many apps are slow/clunky due to cloud-first design.
- Cloud backup is a strong Pro value if the free tier remains useful.

The strategy: **offline-first + export-everything + fast scan-to-add + killer PDF report**.

---

## Notes / Implementation Considerations

- For desktop OCR: consider making OCR optional and focusing on mobile first.
- For manuals: store URLs but offer “download PDF into vault” to make it durable.
- Ensure schema migrations are versioned from day 1.

---

This dev stages document should be treated as the canonical roadmap.
