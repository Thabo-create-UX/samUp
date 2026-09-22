# StayFlow

## Overview
StayFlow is the student-facing mobile app of the Student Accommodation Management System for a private off-campus accommodation owner. A student resident can view accommodation blocks and rooms, their rental agreement, monthly payment history and the housing policies. The owner-side management console is a separate ASP.NET MVC web application and is not part of this Flutter build.

## Built vs Coming Soon
- Built: sign-in, reset password, Rooms tab (greeting, search, assigned accommodation, room listings, recent activity), room details, Payments tab (outstanding balance, All/Paid/Pending filters), payment details, Agreements tab and agreement details, terms & conditions with acceptance, Profile tab
- Needs a backend (guest path active): login, password reset, "Make Payment" and "View Receipt" show a not-connected notice; "Continue as guest" is the working path
- Coming soon: the generic coming-soon screen stays available for future entries

## Tech Stack & Key Decisions
- ChangeNotifier + provider: one AccommodationProvider feeds all four tabs so the records stay consistent across them
- go_router with a ShellRoute: the tabs share the bottom navigation and the provider; detail screens are top-level routes pushed above the shell so the nav bar hides
- AccommodationRepository mirrors the shape a Supabase-backed repository would take (per the project SRS), so wiring the backend means implementing the same signatures
- Sample records follow the stakeholder's real scenario (Block A/B rooms, R2 500–R3 500 rent, 11-month lease, Capitec banking details)

## Architecture
- Data flow: tab screen -> AccommodationProvider -> AccommodationService -> AccommodationRepository -> models
- AuthProvider is app-global (main.dart) so the session survives navigation between /auth and the shell; AccommodationProvider is scoped to the ShellRoute
- Detail screens receive their record through GoRouter's `extra` rather than refetching; opening such a route without a record shows a "no longer loaded" fallback

## Conventions
- All money and date strings go through AppFormat in lib/utils/formatters.dart (R2 500.00 and 01 Feb 2026 formats) — never format inline
- Status chips use the shared StatusBadge with a BadgeTone rather than raw colours
- Backend-dependent actions call showBackendNotice() so the wording stays consistent

## Key Patterns & Gotchas
- Agreement.progress and monthsRemaining derive from DateTime.now(), so the lease bar advances without a stored "current month" field
- The four tab screens deliberately have no Scaffold or AppBar: AppShell owns the Scaffold and each tab renders its heading in the body
- Tab bodies use SafeArea(bottom: false) because the NavigationBar already handles the bottom inset

## Design System
- Calm, trustworthy palette: deep teal primary with navy secondary, suited to a contractual and financial student app
- Plus Jakarta Sans headings with Manrope body text for a modern, legible feel
- 16px base spacing rhythm with generous card radii (16–22px); the assigned-accommodation card is the single gradient surface used as the visual anchor
