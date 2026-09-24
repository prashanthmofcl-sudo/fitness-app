# Fitness App — Project Context

This document is the single source of truth for product direction, architecture, navigation, design, and implementation conventions. Future Codex prompts and contributors must consult it before making changes. When code and this document diverge, resolve the discrepancy deliberately and update this document in the same change.

## 1. Project overview

- **Product:** A production-quality Flutter fitness application intended for Google Play Store publication.
- **Framework:** Flutter with Material 3.
- **Architecture:** Feature First.
- **Routing:** GoRouter with centralized route names and paths.
- **Visual identity:** Premium purple fitness theme with white screen backgrounds.
- **Current phase:** Foundation only. Architecture, global theme, routing, and reusable widgets exist. Real screens, business logic, state management, backend services, and integrations are not implemented.

## 2. App purpose

The app will help users assess their starting point, define fitness goals, follow workouts, manage nutrition and hydration, monitor progress, support recovery, and maintain a personal fitness profile. It should eventually provide personalized guidance while remaining understandable, safe, and motivating.

The app is a wellness and fitness tool, not a medical diagnosis or emergency-care product. Health-sensitive recommendations must include appropriate limitations and safety messaging.

## 3. Target users

- Beginners who need structured onboarding and clear explanations.
- Intermediate users who want consistent workout, nutrition, hydration, recovery, and progress tracking.
- Goal-focused users pursuing strength, muscle gain, fat loss, endurance, mobility, or general wellness.
- Users on a wide range of Android devices, screen sizes, accessibility settings, and fitness experience levels.

Design for low cognitive load. Never assume that users already understand training terminology, nutrition metrics, or exercise technique.

## 4. Full navigation flow

```text
App launch
└── Splash (/)
    ├── First-time or unauthenticated user
    │   └── Welcome (/welcome)
    │       ├── Login (/login)
    │       │   └── Forgot Password (/forgot-password)
    │       └── Signup (/signup)
    │           └── Assessment flow
    │               ├── Personal Info (/assessment/personal-info)
    │               ├── Body Info (/assessment/body-info)
    │               ├── Goal Selection (/assessment/goal-selection)
    │               ├── Workout Type (/assessment/workout-type)
    │               ├── Intensity (/assessment/intensity)
    │               └── Result Summary (/assessment/result-summary)
    │                   └── Main Navigation (/main)
    └── Returning authenticated and onboarded user
        └── Main Navigation (/main)
            ├── Dashboard (/dashboard)
            ├── Workout (/workout)
            ├── Food (/food)
            ├── Progress (/progress)
            └── Profile (/profile)
                └── Settings (/settings)
```

Authentication checks, onboarding completion checks, redirects, and bottom-navigation shell behavior are future business logic and must not be added until explicitly requested.

## 5. Screen order

The intended first-time experience is:

1. Splash
2. Welcome
3. Login or Signup
4. Forgot Password, only when requested from Login
5. Personal Info
6. Body Info
7. Goal Selection
8. Workout Type
9. Intensity
10. Result Summary
11. Main Navigation
12. Dashboard, Workout, Food, Progress, or Profile
13. Settings, accessed from Profile

Current route targets are simple private placeholders in `lib/app/router.dart`. Replace them incrementally with feature screens; do not duplicate route strings in screens or widgets.

## 6. Folder architecture

```text
lib/
├── main.dart                  # Flutter entry point
├── app/                       # App composition and global design/navigation
│   ├── app.dart               # MaterialApp.router
│   ├── router.dart            # GoRouter configuration
│   ├── routes.dart            # Route names and paths
│   ├── theme.dart             # Material 3 light/dark themes
│   ├── colors.dart            # Color tokens and gradients
│   ├── typography.dart        # Reusable type styles and TextTheme
│   └── constants.dart         # Shared spacing, radius, and sizing tokens
├── core/                      # Feature-independent technical utilities
│   ├── helpers/
│   ├── utils/
│   └── extensions/
├── shared/                    # Reusable presentation components
│   └── widgets/
├── data/                      # App-wide data infrastructure
│   ├── repositories/
│   ├── local/
│   └── remote/
└── features/                  # Feature First modules
    ├── auth/
    ├── onboarding/
    ├── assessment/
    ├── dashboard/
    ├── workout/
    ├── exercise_library/
    ├── nutrition/
    ├── water_tracker/
    ├── progress/
    ├── recovery/
    ├── profile/
    └── settings/
```

Each feature owns these folders:

- `screens/`: Full-page feature entry points.
- `widgets/`: UI components used only by that feature.
- `models/`: Feature-specific immutable data/domain models.
- `services/`: Feature-specific service boundaries and implementations.

Use `shared/widgets/` only when a widget is genuinely reusable across multiple features. Use `data/` for cross-feature persistence and external data infrastructure. Keep `core/` free of feature and UI dependencies.

## 7. Purple theme color rules

All colors must come from `AppColors` or the active `ThemeData.colorScheme`. Do not scatter hexadecimal literals through feature code.

| Token | Hex | Purpose |
|---|---:|---|
| Primary | `#7C3AED` | Primary actions, active states, focus, brand identity |
| Primary Dark | `#6D28D9` | Strong purple emphasis and primary container treatment |
| Secondary | `#A855F7` | Secondary purple/pink emphasis |
| Accent | `#C084FC` | Soft highlights and secondary containers |
| Gradient End | `#38BDF8` | Blue endpoint used only in approved gradients |
| Light Background | `#F8F7FF` | Light scaffold background |
| Dark Background | `#0F0A1F` | Dark scaffold background |
| Dark Card | `#1A1333` | Dark-mode surfaces and cards |
| Light Card | `#FFFFFF` | Light-mode surfaces and cards |
| Text Dark | `#1F1B2E` | Primary text in light mode |
| Text Light | `#F8FAFC` | Primary text in dark mode |
| Muted Text | `#8B88A8` | Secondary labels, hints, and captions |
| Success | `#22C55E` | Positive semantic status only |
| Warning | `#F59E0B` | Warning semantic status only |
| Error | `#EF4444` | Error and destructive semantic status only |

- Every app screen uses a white background.
- App branding, interactive components, progress, active navigation, and gradients are purple.
- Green is not a general UI accent. It is reserved for explicit semantic success where needed.
- Existing approved artwork may retain natural green content, but surrounding UI must remain white and purple.
- Button foreground text is white on the primary purple fill.
- `ColorScheme.seedColor` is primary purple; `secondary` is purple/pink, not blue.
- `primaryGradient` is Primary → Secondary.
- `fitnessGradient` is Primary → Secondary, producing a purple-only gradient.
- Ensure text and icon contrast meets WCAG requirements in both themes.
- Prefer semantic theme colors over direct tokens when a Material component already exposes the correct role.

## 8. Typography rules

Use `AppTypography` and the active `Theme.of(context).textTheme`. The platform system font is the default; do not add a font package or asset without an explicit product decision.

| Style | Size | Weight | Line height | Use |
|---|---:|---:|---:|---|
| Heading | 32 | 700 | 1.2 | Major page or result headings |
| Title | 22 | 700 | 1.3 | Section/card titles |
| Subtitle | 16 | 600 | 1.4 | Supporting headings and emphasized labels |
| Body | 16 | 400 | 1.5 | Primary readable content |
| Caption | 13 | 400 | 1.4 | Metadata, hints, and secondary labels |
| Button | 16 | 700 | 1.2 | Button labels |

- Respect system text scaling; do not clamp text scale globally.
- Avoid hard-coded text styles in features.
- Do not communicate status through color alone.
- Use sentence case for labels and headings unless a proper noun requires otherwise.

## 9. Spacing and radius rules

Use the `AppConstants` token scale:

- Extra small spacing: `4`
- Small spacing: `8`
- Medium spacing: `16`
- Large spacing: `24`
- Extra large spacing: `32`
- Small radius: `8`
- Medium radius: `12`
- Large radius: `16`
- Standard button height: `52`
- Standard horizontal screen padding: `16`

Prefer token combinations over introducing arbitrary values. New global tokens require a repeated use case and must be added to `AppConstants`; one-off geometry should remain local and justified.

## 10. Reusable widgets list

Located in `lib/shared/widgets/`:

- `PrimaryButton`: Purple filled action with optional icon, loading, disabled, expansion, and semantic label support.
- `SecondaryButton`: Purple outlined action with matching reusable states.
- `AppTextField`: Configurable themed `TextFormField` wrapper.
- `SectionTitle`: Section heading with optional subtitle and action.
- `MetricCard`: Configurable metric, unit, icon, accent, supporting text, and tap behavior.
- `EmptyState`: Centered empty state with icon, message, and optional primary action.
- `LoadingWidget`: Accessible progress indicator with optional message and layout control.
- `MacroProgressCard`: Nutrition macro progress with safe clamping and accessible progress context.

Before creating a shared widget, confirm that an existing widget cannot be extended cleanly. Feature-specific composition belongs in that feature's `widgets/` directory.

## 11. Design principles

- **Premium but calm:** Purple-led surfaces, controlled gradients, restrained elevation, and purposeful motion.
- **Fitness-forward:** Strong hierarchy and motivating metrics without aggressive or shame-based language.
- **Clarity first:** One obvious primary action per task; progressive disclosure for advanced detail.
- **Consistent:** Reuse tokens, shared widgets, interaction patterns, and terminology.
- **Theme-aware:** Every component must work in light and dark modes.
- **Honest feedback:** Loading, empty, error, success, disabled, and offline states must be explicit.
- **Safe:** Avoid medical claims, unsafe training prescriptions, and punitive nutrition framing.

## 12. Coding conventions

- Follow effective Dart and the repository's analyzer/lint configuration.
- Keep files focused; prefer small composable widgets and single-responsibility classes.
- Use `const` constructors and widgets whenever inputs are compile-time constants.
- Prefer immutable models and `final` fields.
- Avoid `dynamic`; use explicit types at public boundaries.
- Keep build methods declarative and free of side effects.
- Never place networking, persistence, or heavy calculations in widgets.
- Handle loading, success, empty, and error states explicitly when logic is introduced.
- Do not swallow exceptions. Convert infrastructure failures into typed application failures at appropriate boundaries.
- Document public APIs when intent is not obvious; do not narrate trivial code.
- Centralize routes, colors, typography, spacing, radii, and other global tokens.
- Add tests alongside future behavior: unit tests for logic, widget tests for interaction/accessibility, and integration tests for critical flows.

## 13. Naming conventions

- Files and directories: `snake_case`.
- Classes, enums, extensions, and typedefs: `UpperCamelCase`.
- Variables, methods, parameters, and constants: `lowerCamelCase`.
- Private symbols: leading underscore.
- Widgets: descriptive noun or role, such as `MetricCard` or `WorkoutSummaryCard`.
- Screens: suffix with `Screen`, such as `LoginScreen`.
- Services: suffix with `Service`; repositories: suffix with `Repository`.
- State controllers/notifiers: describe the feature and role; avoid generic names like `Manager`.
- Route names and paths: use constants from `AppRoutes`; paths use lowercase kebab-case.
- Boolean names: start with `is`, `has`, `can`, or `should`.

## 14. Future state management guideline

No state-management package is selected or implemented yet. When real business logic begins, choose **one** primary approach—Riverpod or Bloc—through an architecture decision, then apply it consistently.

Shared rules for either choice:

- Keep ephemeral UI state local when it does not need sharing or persistence.
- Keep business state outside widgets.
- Expose immutable state with explicit loading, data, empty, and error variants.
- Depend on repository/service abstractions, not concrete remote SDKs.
- Scope state to features; promote it to app scope only for genuinely global concerns such as session, theme preference, or connectivity.
- Make state transitions deterministic and unit-testable.
- Do not mix Riverpod and Bloc for equivalent responsibilities.

If Riverpod is chosen, prefer typed providers and notifier-based APIs with feature-local provider files. If Bloc is chosen, use events only when they clarify asynchronous workflows; Cubit is acceptable for simpler state transitions.

## 15. Responsive UI rules

- Build from constraints with `LayoutBuilder`, flexible widgets, and bounded content widths—not device-name checks.
- Support narrow phones, large phones, tablets, portrait, and landscape where the experience is meaningful.
- Use breakpoints only when layout structure must change; document shared breakpoint tokens before broad adoption.
- Avoid fixed widths for text-heavy content. Use `Expanded`, `Flexible`, wrapping, and max-width constraints.
- Keep primary content readable on wide screens rather than stretching edge to edge.
- Account for safe areas, system navigation, keyboards, and display cutouts.
- Test text scaling, long localized strings, and small screens for overflow.
- Minimum interactive target: 48×48 logical pixels.

## 16. Asset organization

When assets are introduced, organize them at the project root:

```text
assets/
├── images/          # Raster photos and illustrations
├── icons/           # App-specific icons not covered by Material icons
├── animations/      # Lottie/Rive or similar approved assets
├── exercises/       # Exercise media grouped further by type if needed
└── fonts/           # Only when a custom licensed font is approved
```

- Use lowercase `snake_case` filenames.
- Prefer SVG/vector assets for scalable icons and simple illustrations when the selected package supports them.
- Compress raster assets and provide appropriate resolution variants.
- Do not commit unlicensed, oversized, duplicated, or unused assets.
- Declare asset directories explicitly in `pubspec.yaml` when added.
- Keep user-generated/downloaded media out of bundled assets.

## 17. Animation guidelines

- Motion should explain hierarchy, progress, selection, or navigation—not decorate every interaction.
- Default micro-interaction duration: approximately 150–250 ms.
- Larger transitions: approximately 250–400 ms, used sparingly.
- Prefer Material motion and Flutter implicit animations for simple state changes.
- Keep loading indicators calm and avoid fake progress.
- Do not block interaction for nonessential animation.
- Respect reduced-motion accessibility preferences when the platform exposes them.
- Avoid flashing, rapid scaling, excessive parallax, and motion that may cause discomfort.
- Profile complex animation on representative low/mid-range Android devices.

## 18. Accessibility rules

- Target WCAG 2.2 AA contrast where applicable.
- Provide meaningful semantic labels for icons, controls, charts, progress, and custom gestures.
- Exclude decorative elements from semantics.
- Maintain logical focus and screen-reader traversal order.
- Support keyboard/focus navigation where relevant, especially on tablets and future web/desktop targets.
- Never rely only on color, shape, sound, or motion to convey meaning.
- Provide text alternatives for exercise imagery and instructional media.
- Use plain language for validation errors and explain how to recover.
- Announce meaningful loading and result changes through semantics without excessive chatter.
- Test with Android TalkBack, large text, bold text, and high-contrast scenarios.

## 19. Future Firebase/Supabase integration notes

No backend is currently connected. Firebase and Supabase are alternatives; do not integrate both by default. Select a provider through an architecture decision based on authentication, relational/query needs, offline behavior, storage, analytics, operational cost, and privacy requirements.

When integration is approved:

- Hide vendor SDKs behind interfaces in services/repositories.
- Keep DTOs separate from feature/domain models when schemas differ.
- Centralize environment configuration and never commit secrets or service credentials.
- Use platform-supported secure storage for session-sensitive local values.
- Define ownership and authorization rules before writing data.
- Apply server-side security rules/policies; client-side checks are not security boundaries.
- Design schema migrations, offline behavior, retry/idempotency, account deletion, export, retention, and consent flows.
- Minimize collection of health-related and personally identifiable data.
- Add emulator/local-development support and tests for repository boundaries.

## 20. Future AI coach notes

The AI coach is not implemented. It must be treated as a bounded assistant, not a medical professional or autonomous authority.

- Ground responses in the user's explicit goals, preferences, available equipment, and approved app data.
- Obtain clear consent before sending personal or health-related data to an AI service.
- Minimize and redact data; document retention and provider policies.
- Separate deterministic safety rules from generative output.
- Do not diagnose conditions, prescribe medication, promote eating disorders, or encourage training through injury.
- Escalate red-flag symptoms and crisis content to appropriate professional/emergency guidance.
- Present generated plans as suggestions that users can review and edit.
- Explain important assumptions and allow correction.
- Version prompts and model configuration, validate structured outputs, rate-limit usage, and provide graceful fallback when unavailable.
- Measure quality and safety with curated evaluations before release.

## 21. Future wearable integration notes

Wearables are not currently integrated. Future support may use Android Health Connect and provider/platform APIs where justified.

- Add integrations behind a dedicated service/repository boundary; feature UI must not call wearable SDKs directly.
- Request the minimum permissions at the moment they are needed and clearly explain their value.
- Treat wearable data as sensitive health data with explicit consent and revocation support.
- Define source precedence and deduplication for steps, workouts, calories, heart rate, sleep, and recovery metrics.
- Store timestamps with timezone/offset context and handle daylight-saving and travel changes.
- Plan for delayed sync, offline devices, partial records, corrections, and duplicate events.
- Show provenance and last-sync status when data source matters.
- Never infer medical conclusions from consumer sensor data.
- Provide manual entry and correction paths where practical.
- Validate Play Store health-data policy, platform permissions, privacy disclosures, deletion, and retention before release.

---

## Guidance for future Codex prompts

Before implementing a task:

1. Read this document and inspect the current code relevant to the request.
2. Preserve Feature First boundaries and existing design tokens.
3. Distinguish implemented functionality from future guidance.
4. Do not introduce screens, business logic, state management, backend services, assets, or dependencies unless the prompt explicitly requests them.
5. Update this document whenever an approved architectural, navigation, design-system, integration, or naming decision changes.
