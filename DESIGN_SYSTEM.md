# Fitness App Design System

This is the UI specification for the Fitness App. It complements `PROJECT_CONTEXT.md`. It does not imply that every component below is implemented. Material 3, the premium purple identity, light/dark parity, responsiveness, and accessibility are mandatory.

## 1. Grid system

Use a 4dp base grid with an 8dp preferred rhythm.

| Token | Value | Use |
|---|---:|---|
| XS | 4dp | Tight icon/text gaps, optical adjustment |
| SM | 8dp | Inline gaps, compact padding |
| Compact | 12dp | Dense component padding; use sparingly |
| MD | 16dp | Default screen/card padding |
| LG | 24dp | Section separation |
| XL | 32dp | Major group separation |
| 2XL | 48dp | Hero separation |
| 3XL | 64dp | Exceptional wide-layout spacing |

- Prefer multiples of 8; use 4dp only for tight relationships.
- Phone screen gutter: 16dp. Tablet/wide gutter: 24–32dp.
- Related fields: 16dp apart. Major sections: 24–32dp apart.
- Align content to shared edges; avoid arbitrary spacing.

## 2. Border radius

| Size | Value | Use |
|---|---:|---|
| Small | 8dp | Chips, indicators, small icon containers |
| Medium | 12dp | Buttons, fields, compact cards |
| Large | 16dp | Standard cards and content surfaces |
| Extra Large | 24dp | Dialogs, prominent cards, sheet top corners |

Circular shapes are reserved for avatars, status dots, FABs, and circular controls. Nested surfaces use a smaller radius than their parent. Extra Large is a future token and must be added to shared constants when first implemented.

## 3. Elevation rules

| Level | Elevation | Use |
|---|---:|---|
| Base | 0dp | Scaffold and ordinary content |
| Resting | 0–1dp | Cards; prefer 0dp plus border |
| Raised | 2dp | Interactive cards/floating controls |
| Overlay | 6dp | Menus and bottom sheets |
| Modal | 8dp | Dialogs |
| FAB | 6dp resting, 8dp pressed | Floating action button |

Use color, border, spacing, and typography before elevation. App bars and bottom navigation default to 0dp. Dark mode uses stronger surface separation and restrained shadows.

## 4. Shadow rules

| Recipe | Specification | Use |
|---|---|---|
| Soft | `0 2 8`, black 6% light / 18% dark | Subtle raised card |
| Medium | `0 6 20`, purple-black 10% light / 24% dark | Menu or sheet |
| Modal | `0 12 32`, purple-black 14% light / 30% dark | Dialog |
| Brand glow | `0 6 18`, Primary 18% | Rare hero CTA/milestone |

Use one shadow per surface. Brand glow is not for fields or repeated cards. Shadows must not be the only boundary indicator.

## 5. Color usage rules

| Role | Hex | Use |
|---|---:|---|
| Primary | `#7C3AED` | Primary actions, focus, active brand states |
| Primary Dark | `#6D28D9` | Pressed/strong purple treatment |
| Secondary | `#A855F7` | Secondary purple/pink emphasis |
| Accent | `#C084FC` | Soft highlight/container |
| Gradient End | `#38BDF8` | Approved fitness-gradient endpoint only |
| Light Background | `#F8F7FF` | Light scaffold |
| Dark Background | `#0F0A1F` | Dark scaffold |
| Light Card | `#FFFFFF` | Light surface |
| Dark Card | `#1A1333` | Dark surface |
| Text Dark | `#1F1B2E` | Primary light-mode text |
| Text Light | `#F8FAFC` | Primary dark-mode text |
| Muted Text | `#8B88A8` | Secondary text and hints |
| Success | `#22C55E` | Positive semantic status only |
| Warning | `#F59E0B` | Warning status |
| Error | `#EF4444` | Error/destructive status |

- Screen backgrounds are always white in the current product direction.
- Purple is the only branded component accent; all branded gradients use purple tones.
- Green is reserved for explicit semantic success, never general decoration or navigation.
- Button foreground is white on Primary.
- Primary → Secondary is the brand gradient. Primary → Gradient End is the fitness gradient.
- Blue is not a general secondary color. Gradients are used sparingly.
- Use `ColorScheme`/`AppColors`; never hard-code feature colors.
- Meet WCAG 2.2 AA and never communicate state with color alone.

## 6. Typography hierarchy

Use the platform system font until a licensed custom font is approved.

| Role | Size | Weight | Height | Use |
|---|---:|---:|---:|---|
| Heading | 32sp | 700 | 1.2 | Hero/page heading |
| Title | 22sp | 700 | 1.3 | Sections and card titles |
| Subtitle | 16sp | 600 | 1.4 | Supporting headings |
| Body Large | 16sp | 400 | 1.5 | Main reading content |
| Body Medium | 14sp | 400 | 1.5 | Compact content/control text |
| Caption | 13sp | 400 | 1.4 | Metadata and helper text |
| Button | 16sp | 700 | 1.2 | Action labels |

Use `AppTypography`/theme styles, sentence case, and a clear hierarchy. Respect system text scaling. Muted text cannot carry essential instructions.

## 7. Icon guidelines

- Use **Material Symbols Rounded**.
- Inline/control: 20–24dp. Navigation: 24dp. State art: 36–48dp. FAB: 24dp.
- Icon-button touch target: at least 48×48dp.
- Filled symbols may indicate selection; outlined symbols may indicate unselected states.
- Unfamiliar icons need labels/tooltips. Actionable icons need semantic labels.
- Exclude decorative icons from semantics. Do not mix icon families without a documented gap.

## 8. Button specifications

Default form-action height is 52dp; absolute minimum touch height is 48dp. Radius is Medium (12dp), label style is Button, horizontal padding is 20–24dp, and optional icons are 20dp with an 8dp gap.

### Primary

- `ElevatedButton`; Primary fill; white foreground; 0dp resting elevation.
- Full width for major flow actions, intrinsic width for contextual actions.
- Loading replaces content with a centered spinner, keeps dimensions, and disables repeats.

### Secondary

- `OutlinedButton` by default; transparent fill, Primary foreground, 1dp Primary border.
- Same dimensions/radius as Primary. Use for the main alternative action.

### Outlined

- Tertiary contained action with transparent fill and theme-aware border.
- Stack actions on narrow screens rather than crowding a horizontal row.

### Icon Button

- 48×48dp target, 24dp icon, tooltip and semantic label required.
- Selected state may use a soft purple container. Destructive actions use Error and confirmation when irreversible.

### FAB

- One primary creation/action per destination at most.
- 56dp circle or Material 3 extended FAB; Primary fill, white foreground.
- 6dp resting/8dp pressed elevation. Must not cover navigation, snackbars, or content.

States: visible focus treatment, Primary Dark/state overlay when pressed, legible muted disabled state, and no layout shift during loading.

## 9. Card specifications

Default: theme surface, subtle 1dp border, 0dp elevation, Large 16dp radius, and 16dp padding (24dp for spacious cards).

### Dashboard Card

Concise overview, next action, or daily insight. Use label, prominent value/title, context, and optional action. At most one featured gradient card per view.

### Workout Card

Show workout identity, duration, difficulty, equipment, and start/resume action. Use chips for difficulty/status. Completed state uses success semantics without making the whole card green.

### Food Card

Show meal/food identity, calories, and relevant macro summary. Align values for scanning. Keep detail and edit/log actions distinct. Warning color is not an arbitrary calorie judgement.

### Metric Card

Show one primary measurement, label, unit, optional icon, and trend/context. Unit is subordinate. Trends use text/icon plus color and must not imply unsupported precision.

## 10. TextField specifications

- Filled Material field, minimum 52dp single-line height, Medium 12dp radius.
- Current card surface fill; 1dp theme border; 2dp Primary focus border.
- Error border: Error 1dp, or 2dp while focused.
- Content padding: 16dp. Icons: 20–24dp with accessible targets.
- Labels remain visible; placeholder is never the only label.
- Use correct keyboard, action, capitalization, autofill hints, and formatters.
- Password fields need an accessible visibility toggle.
- Validation states what is wrong and how to fix it.

## 11. Bottom Navigation specifications

- Prefer Material 3 `NavigationBar` when implemented; current theme also supports `BottomNavigationBar`.
- Destinations: Dashboard, Workout, Food, Progress, Profile.
- Surface background, Primary selected state, Muted Text unselected state.
- Material Symbols Rounded at 24dp with persistent labels.
- Respect bottom safe area and 48dp targets.
- Preserve each destination's navigation state when shell routing is introduced.
- Use badges only for actionable, time-relevant information.

## 12. AppBar specifications

- Standard 56dp height plus safe area; scaffold-matching background and 0dp default elevation.
- Add subtle separation only when content scrolls beneath.
- Title: 20–22sp, weight 700, left aligned by default.
- Back and action targets: 48×48dp. Icon actions require tooltips/semantics.
- Show at most two trailing actions; overflow additional actions.
- Large-title variants are for meaningful top-level hierarchy, not decoration.

## 13. Chip specifications

- `FilterChip`: toggled filters such as muscle group/equipment.
- `ChoiceChip`: one selection from a compact set.
- `InputChip`: user-entered/removable values.
- `ActionChip`: low-priority immediate action.
- Minimum visual height: 32dp, with accessible 48dp interaction space where feasible.
- Small 8dp radius or a consistently applied pill shape.
- Selected: soft Primary container and purple foreground/border. Unselected: surface and theme border.
- Semantic chips use Success/Warning/Error plus icon or text; chips wrap rather than shrink.
- Chips do not replace primary actions.

## 14. Progress Bar specifications

- Use `LinearProgressIndicator`; track height 8–10dp with rounded ends.
- Active color is Primary/Secondary, or semantic only when status warrants it.
- Track uses the active color at roughly 12–16% opacity or a surface variant.
- Clamp determinate values to `0.0–1.0` and show label/value/percentage context.
- Incomplete goals are not errors. Indeterminate bars are only for unknown duration.
- Animate value changes over 200–350ms without unnecessary replay.

## 15. Circular Progress specifications

- Inline: 20dp diameter, 2dp stroke.
- Standard: 32dp diameter, 3dp stroke.
- Large metric: 72–120dp diameter, 6–10dp stroke.
- Default color is Primary; semantic color is used only when it expresses semantic status.
- Determinate rings include a readable value/label. Indeterminate rings receive a loading semantic label.
- Avoid multiple competing indeterminate spinners in one view.

## 16. Loading UI

- Avoid flashing a loader for operations completing in roughly under 400ms.
- Button loading preserves dimensions and prevents repeated submission.
- Prefer stable skeletons when the final layout is known; otherwise use `LoadingWidget` with concise copy.
- Preserve already loaded content during incremental operations.
- Do not block the whole app for a local operation.
- Loading must time out or resolve into actionable error UI; use restrained live-region announcements.

## 17. Empty State UI

- Center within available content and constrain readable width to about 420dp.
- Structure: restrained icon/illustration, Title, one-sentence explanation, optional primary action.
- Icon container may use the Primary → Secondary gradient.
- Explain why the state is empty and what the user can do next.
- Distinguish first-use empty states from filtered no-results; avoid blame and dead ends.

## 18. Error State UI

- Use Error icon/accent, clear title, plain-language explanation, and recovery action.
- Do not flood the full view red.
- Retry is primary only when retry is meaningful; otherwise offer edit, back, or support.
- Preserve safe user input. Keep inline errors near fields and page-level errors for broad failures.
- Technical details belong in logs. Provide specific offline messaging when relevant.

## 19. Success Snackbar

- Floating Material `SnackBar` with high-contrast inverse/neutral surface and Success icon/accent.
- Medium 12dp radius and 16dp safe margin.
- Concise confirmation; approximately 3–4 seconds.
- At most one action, usually Undo or View.
- Use for transient confirmation, not critical information. Announce accessibly and do not stack.

## 20. Dialog style

- Material 3 surface, Extra Large 24dp radius, Modal elevation/shadow.
- Responsive bounded width, approximately 280–560dp.
- Outer padding 24dp; 16dp between content groups.
- Optional icon, clear title, concise body, and actions; primary action last in reading order.
- Destructive confirmation names the consequence and uses explicit action copy.
- Reserve dialogs for blocking decisions/short tasks—not long forms or complex navigation.
- Trap focus appropriately and return it to the invoking control on dismissal.

## 21. Bottom Sheet style

- Modal sheets handle focused choices/tasks; persistent sheets require strong justification.
- Extra Large 24dp top corners, surface color, 6dp elevation, Material drag handle.
- Content padding 16–24dp plus safe-area and keyboard insets.
- Fit content where possible; larger sheets expand and scroll cleanly.
- Add title/close action when dismissal is unclear. Keep primary actions keyboard-visible.
- Avoid nested-scroll ambiguity and swipe-sensitive placement of irreversible actions.

## 22. Animation guidelines

- Motion explains relationship, state, progress, or hierarchy.
- Micro-interaction: 150–250ms. Standard transition: 200–300ms. Modal/layout: 250–400ms.
- Prefer Material easing and Flutter implicit animations for simple changes.
- Preserve spatial continuity; keep loading motion calm.
- Avoid ornamental bounce, flashing, excessive parallax, repeated autoplay, or blocking animation.
- Respect reduced-motion preferences and profile complex motion on mid/low-range Android devices.

## 23. Screen transition guidelines

- Forward routes: subtle Material shared-axis or horizontal/fade, 250–300ms.
- Back routes reverse the established transition and preserve platform gestures.
- Bottom-navigation destinations switch immediately or with a subtle fade while preserving state.
- Modals use Material fade/scale; bottom sheets use the standard vertical transition.
- Assessment steps may use restrained shared-axis motion to reinforce sequence.
- Never delay navigation for decoration. Deep links/restoration cannot depend on prior animation.

## 24. Accessibility guidelines

- Meet WCAG 2.2 AA contrast and use 48×48dp minimum targets.
- Support TalkBack, logical traversal, visible focus, tooltips, and meaningful labels.
- Exclude decorative visuals from semantics.
- Support system text scaling without clipping, overlap, or hidden actions.
- Never encode meaning through color, position, sound, or motion alone.
- Announce meaningful loading/result changes without excessive chatter.
- Respect reduced motion; avoid flashing content.
- Use actionable validation copy. Exercise imagery needs useful alternatives; charts need text summaries.
- Test light/dark, large text, long strings, TalkBack, and high contrast.

## 25. Component naming rules

- Files/directories: `snake_case`; classes: `UpperCamelCase`.
- Name by role, not appearance: `PrimaryButton`, not `PurpleButton`.
- Full pages end with `Screen`; dialogs with `Dialog`; sheets with `Sheet`/`BottomSheet`.
- Cards state their purpose: `WorkoutCard`, `FoodCard`, `MetricCard`.
- Feature-only widgets live in `features/<feature>/widgets/`; shared widgets require cross-feature reuse.
- Avoid `CustomWidget`, `CommonCard`, `BaseThing`, and numbered variants.
- Use parameters/named constructors when semantics stay the same; split components when behavior or information architecture differs.
- Booleans begin `is`, `has`, `can`, or `should`; callbacks use `on<Action>`.
- Never encode colors, device types, or temporary positions in names.

---

## Implementation status and change control

Existing tokens and shared widgets remain the current code-level source. Extra Large radius, Material 3 `NavigationBar`, additional card variants, chips, dialogs, sheets, and state components are documented future requirements and are not yet implemented.

When implementation is requested:

1. Reuse `AppColors`, `AppTypography`, `AppConstants`, `AppTheme`, and existing shared widgets.
2. Add repeated missing values as global tokens before using raw values.
3. Build reusable components independently of screens and business logic.
4. Verify light/dark themes, responsive constraints, text scaling, and semantics.
5. Update this file and `PROJECT_CONTEXT.md` when an approved system decision changes.
