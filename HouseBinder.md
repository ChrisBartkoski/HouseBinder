1) What this app is (one-sentence definition)

A home “house binder” app that keeps your appliances, warranties, manuals, receipts, maintenance tasks, and service history in one place — and generates a printable PDF report for resale, insurance, and contractors.

That PDF report is your money-maker and differentiator.

⸻

2) Primary users (and what they’re desperate for)

A) New homeowner (most common)

“I just moved in. I don’t even know where my filter is.”

They need:
	•	a maintenance schedule
	•	what to do monthly/seasonally
	•	what model their furnace is
	•	where their water shutoff is

Reddit is full of people being told to “make a home binder” because it’s insanely valuable.  ￼

B) Organized homeowner / DIY fixer

“I want receipts, manuals, parts, and service history searchable.”

Centriq users loved quick access to manuals, parts, and warranty notifications.  ￼

C) Landlord / rental manager

“I need turnover checklists, inspections, and maintenance history.”

D) Home seller / buyer

“I want a professional binder report to increase trust and home value.”

E) Insurance preparedness user

“If my house burns down, I need proof of what I owned and my maintenance history.”

⸻

3) Core UX concept (how it feels to use)

The app should feel like:
✅ “Notes + reminders + a filing cabinet”
…but structured enough to generate reports and reminders automatically.

Your killer UX trick: Scan-to-add.
Take a photo of a label → the app extracts:
	•	manufacturer
	•	model
	•	serial number
	•	likely manual link
	•	suggested maintenance tasks

This is exactly what made Centriq beloved.  ￼

But (important): some users hate forced “AI-only” entry. They want manual entry too.  ￼
So make it explicit:

Add button must offer:
	•	Scan Label (smart add)
	•	Manual Add (simple form)
	•	Import CSV

⸻

4) Key entities / data model (what gets stored)

A) Property (Home)
	•	Name (“Main House”, “Cabin”)
	•	Address (optional)
	•	Year built, sq ft (optional)
	•	Utility providers (optional)
	•	Notes

B) Asset (Appliance / System / Thing)

Examples: furnace, water heater, fridge, thermostat, garage door opener, sump pump, dishwasher.

Fields:
	•	name (“Basement furnace”)
	•	category (HVAC, Plumbing, Kitchen, Electrical, Exterior)
	•	room/location
	•	manufacturer, model, serial
	•	install date / purchase date
	•	warranty expiration
	•	photos: label, full product, receipts
	•	attachments: manuals, invoices, PDFs
	•	parts/consumables (filters, belts, bulbs)

Centriq’s best feature: automatic manual lookup + parts suggestions + recall monitoring.  ￼

C) Maintenance Task

Fields:
	•	task title (“Replace furnace filter”)
	•	frequency (monthly/quarterly/yearly/custom)
	•	season (optional)
	•	due date
	•	linked asset(s)
	•	instructions + photos
	•	estimated cost/time
	•	status: upcoming/overdue/completed
	•	reminders

Competitor apps heavily focus on “maintenance reminders.”  ￼

D) Service Record (History log)

When you complete a task or hire work:
	•	date
	•	cost
	•	contractor name
	•	notes
	•	attachments (invoice PDF)
	•	next recommended interval

This is the “home timeline” that some competitors emphasize (Homer).  ￼

E) Contractor / Contact
	•	name, trade type (HVAC, plumber)
	•	phone/email
	•	invoices
	•	service history
	•	“preferred contractor” flag

Keep-Up and HomeManager highlight contractor tracking.  ￼

F) Document vault

A generic vault for:
	•	closing documents
	•	permits
	•	surveys
	•	appliance manuals
	•	receipts
	•	inspection reports

⸻

5) MVP feature set (Version 1)

✅ 1) Property setup
	•	one home by default
	•	allow multiple properties later (Pro)

✅ 2) Asset inventory
	•	add appliances/systems
	•	attach photos and documents
	•	manual add OR scan add

✅ 3) Maintenance tasks + reminders
	•	pre-built seasonal checklist templates
	•	tie tasks to assets
	•	recurring schedule engine
	•	task history log

✅ 4) House Binder PDF report (the big differentiator)

One tap generates:
	•	property summary
	•	inventory list
	•	warranties expiring soon
	•	maintenance history (last 12–24 months)
	•	upcoming tasks
	•	contractor list
	•	document index

Think: a home dossier you can hand to:
	•	a buyer
	•	an electrician
	•	an insurer
	•	your spouse after you die 😄

✅ 5) Search

Search across:
	•	assets
	•	manuals
	•	tasks
	•	contractors
	•	documents

⸻

6) “Version 2+” enhancements (high leverage)

A) Manual lookup database (Centriq-style)

Centriq users loved that it retrieved manuals quickly and centralized them.  ￼

You can do:
	•	web search by manufacturer+model
	•	save manual URL or PDF
	•	cache locally for offline view

B) Recall monitoring (major differentiator)

Centriq checks recall databases daily.  ￼

You can:
	•	allow user to opt in
	•	alert if manufacturer/model matches a recall

C) “Parts & Consumables” engine

For each asset:
	•	filter model number
	•	recommended replacement part SKUs
	•	recurring reminder (“replace fridge filter every 6 months”)

Centriq also did this, though reviews say it needed improvement.  ￼

D) CSV import (especially for Centriq refugees)

A Reddit user noted Centriq exports CSV but not photos/manuals; users want import options.  ￼

If you support “Import Centriq CSV,” you can pick up displaced users.

E) Offline-first + export ownership

The Centriq shutdown thread contains a very important theme:

“Apps go away. Your house binder should not.”  ￼

So you win by:
	•	local-first storage
	•	export EVERYTHING (including photos/manuals)
	•	“house binder zip” export

This becomes your biggest competitive advantage.

⸻

7) Competitors & what they miss (opportunities)

1) Centriq (was great, now unstable)

What users loved:
	•	scanning labels
	•	auto manual lookup
	•	warranty detection
	•	parts suggestions
	•	recall monitoring
￼

What they complained about:
	•	hidden paywalls / limits not disclosed
	•	too much AI involvement / forced workflow
	•	export doesn’t include manuals/photos
￼

Your opportunity:
Be the “trustworthy, offline-first Centriq replacement.”

2) HomeZada

Reviews show:
	•	subscription paywall
	•	clunky app
	•	crashes / slow uploads
	•	login issues
	•	lack of barcode scanning
	•	weak support
￼

Your opportunity:
Make it fast, simple, and offline-first. Don’t make login mandatory.

3) Keep-Up (web-based, free)

They emphasize:
	•	reminders
	•	appliance tracking
	•	contractor tracking
	•	task history
	•	“works everywhere”
￼

Likely weakness:
Because it’s web-first, it can feel less “binder-like” and more like a tool.

Your opportunity:
Make the PDF binder and document vault extremely polished.

4) HomeManager / “Homer”

These emphasize:
	•	checklists
	•	DIY videos
	•	AI copilots
	•	finances and budgeting
￼

User concerns: privacy + data sharing.  ￼

Your opportunity:
Privacy-first design: no selling data, offline-first.

5) Simple task reminder apps (Home Maintenance Reminders)

These are basically:
	•	recurring tasks
	•	notes
	•	overdue tracking
￼

Their weakness:
No asset inventory, warranties, manuals, receipts, exports.

Your opportunity:
Be the “full home binder,” not a todo list.

⸻

8) Use case scenarios (how users actually use it)

Use case 1: “My dishwasher stopped draining”

User opens app → searches “dishwasher” → sees:
	•	model + manual
	•	common troubleshooting
	•	“drain filter cleaning task” overdue
	•	warranty status + receipt photo
	•	part number for drain pump

That’s Centriq’s magic.  ￼

Use case 2: Selling the house

User generates “Home Binder PDF”:
	•	maintenance history
	•	appliance inventory + age
	•	warranties
	•	recent repairs
	•	contractor list
This becomes a trust-building sales tool.

Use case 3: Insurance claim

User exports inventory:
	•	receipts + serial numbers + photos
	•	PDF report
Massively reduces claim pain.

Use case 4: New homeowner overwhelmed

User picks “Starter checklist template”:
	•	seasonal maintenance
	•	monthly safety checks
Gets simple reminders instead of chaos.

Reddit users specifically recommend making a home binder for this reason.  ￼

Use case 5: Contractor visits

User searches “water heater” → instantly shows:
	•	past service record
	•	install date
	•	model + manual
	•	notes from last repair

⸻

9) Pro tier ideas (what to paywall without being evil)

Keep core free:
	•	one home
	•	basic assets + tasks
	•	PDF export maybe limited

Pro:
	•	unlimited properties
	•	advanced PDF binder formats (seller report, insurance report, contractor report)
	•	automatic cloud backup
	•	Centriq CSV import
	•	recall monitoring
	•	manual auto-fetch / archive
	•	label scanning OCR (advanced)

This works because:
	•	users get value free
	•	Pro gives long-term safety and power

⸻

10) What Reddit is telling you right now (big market signal)

The Centriq shutdown thread is basically a neon sign saying:

“There is demand. People rely on this. They want alternatives.”  ￼

They also care about:
	•	being able to export their data
	•	not being held hostage by a subscription
	•	having manuals in one place
	•	offline reliability
	•	not relying on AI for everything

This is a perfect opportunity for a privacy-first, offline-first product.

⸻

11) The differentiator that will make your app win

If I had to choose ONE thing to make it better than everyone else:

“Export Everything” House Binder Package
	•	a single export that produces:
	•	PDF binder report
	•	CSV inventory
	•	all documents/photos/manuals in a folder
	•	plus an import file for your app

In other words: users own their home’s data forever.

That directly solves the fear revealed in the Centriq shutdown thread.  ￼

⸻

12) Suggested product positioning (App Store copy style)

HouseBinder (or similar)
Subtitle: “Manuals • Warranties • Maintenance • Reports”

Tagline:

“The owner’s manual your home never came with.”

This matches HomeManager’s positioning but focuses on offline-first and export ownership.  ￼

⸻

If you want, I can turn this into a full MD plan like your breaker app

I can create a product/build plan with:
	•	domain model
	•	CRUD matrix
	•	screen map
	•	storage/sync plan
	•	PDF binder spec
	•	template system
	•	monetization model
