# Fitness App Component Map

This document is the planned reusable component inventory derived from `PROJECT_CONTEXT.md`, `DESIGN_SYSTEM.md`, and `APP_FLOW.md`. It defines component responsibilities before screen implementation. It does not generate or authorize Flutter code.

## How to read this map

- **Existing** means a reusable widget is already present under `lib/shared/widgets/`.
- **Planned** means the component is a specification for future implementation.
- **App-wide** components may live in `shared/widgets/` after demonstrated cross-feature reuse.
- **Feature-local** components belong in `features/<feature>/widgets/` even when reused across several screens in that feature.
- **Stateless/Stateful** describes local presentation behavior only. Business state must remain outside widgets.
- Props listed here are conceptual public inputs; exact Dart APIs are decided during implementation.

## Buttons

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `PrimaryButton` | Existing | Highest-emphasis action with loading and disabled behavior | All forms, auth, assessment, empty/error states, workout completion | `label`, `onPressed`, `icon`, `isLoading`, `expand`, `semanticLabel` | Yes — app-wide | Stateless | Content crossfade; press/loading transition |
| `SecondaryButton` | Existing | Main alternative to a primary action | Auth, assessment, dialogs, summaries, profile | `label`, `onPressed`, `icon`, `isLoading`, `expand`, `semanticLabel` | Yes — app-wide | Stateless | Content crossfade; border/state transition |
| `AppOutlinedButton` | Planned | Tertiary contained action with neutral/theme border | Filters, recovery, food/workout details, settings | `label`, `onPressed`, `icon`, `size`, `expand`, `semanticLabel` | Yes — app-wide | Stateless | State-layer fade |
| `AppIconButton` | Planned | Accessible icon-only action | App bars, cards, charts, entries, timers | `icon`, `onPressed`, `tooltip`, `semanticLabel`, `isSelected`, `color`, `badge` | Yes — app-wide | Stateless | Selection/container transition; icon morph where meaningful |
| `AppFab` | Planned | Single dominant creation action | Food diary, water tracker, optional workout library | `icon`, `onPressed`, `label`, `isExtended`, `semanticLabel` | Yes — app-wide | Stateless | Extend/collapse; elevation transition |
| `DestructiveButton` | Planned | Explicit destructive action following confirmation | Profile deletion, log deletion, workout discard, settings | `label`, `onPressed`, `icon`, `isLoading`, `expand` | Yes — app-wide | Stateless | Loading transition only; no alarming pulse |

## Cards

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `MetricCard` | Existing | Displays one key value, unit, icon, and supporting trend/context | Dashboard, Progress, Water, Recovery, Profile summaries | `label`, `value`, `unit`, `icon`, `accentColor`, `supportingText`, `onTap` | Yes — app-wide | Stateless | Value tween; subtle pressed state |
| `DashboardCard` | Planned | General dashboard module container | Dashboard | `title`, `subtitle`, `leading`, `content`, `action`, `onTap`, `isFeatured` | Yes — dashboard feature | Stateless | Staggered entrance; pressed state |
| `WorkoutCard` | Planned | Summarizes workout identity and start/resume state | Dashboard, Workout list, plan, search results | `workout`, `status`, `duration`, `difficulty`, `equipment`, `image`, `onOpen`, `onStart` | Yes — workout/dashboard | Stateless | Image fade; completion/state transition |
| `FoodCard` | Planned | Summarizes food or meal with calories/macros | Food diary, search, recent/saved foods, Dashboard | `food`, `portion`, `calories`, `macros`, `image`, `onOpen`, `onLog`, `onEdit` | Yes — nutrition/dashboard | Stateless | Add confirmation; image fade |
| `RecoveryCard` | Planned | Displays latest recovery summary and source freshness | Dashboard, Recovery | `status`, `summary`, `score`, `sources`, `updatedAt`, `onTap` | Yes — recovery/dashboard | Stateless | Score/value transition |
| `InfoCard` | Planned | Neutral explanatory or privacy/safety message | Assessment, Recovery, Profile, Settings, AI/wearable notices | `title`, `message`, `icon`, `tone`, `action` | Yes — app-wide | Stateless | Expand/collapse when optional detail exists |
| `ActionCard` | Planned | Large tappable destination/action with concise context | Welcome, assessment choices, profile/settings | `title`, `description`, `icon`, `isSelected`, `onTap`, `semanticLabel` | Yes — app-wide | Stateless | Selection border/fill transition |
| `StatusCard` | Planned | Communicates success, warning, error, offline, or pending state | Sync states, Profile, Progress, Food, Workout | `status`, `title`, `message`, `action`, `timestamp` | Yes — app-wide | Stateless | Status crossfade; no looping decoration |

## Inputs

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `AppTextField` | Existing | Themed text/form input with validation hooks | Login, Signup, Forgot Password, assessment, food, profile | `controller`, `focusNode`, `label`, `hint`, `helperText`, icons, keyboard/action, formatters, validator, callbacks, obscuring, lines, length, autofill | Yes — app-wide | Stateless | Theme-driven focus/error transition |
| `PasswordField` | Planned | Password entry with accessible visibility control | Login, Signup, sensitive Profile actions | `controller`, `label`, `validator`, `autofillHints`, `onSubmitted`, `enabled` | Yes — auth/profile | Stateful — visibility only | Visibility icon/content transition |
| `NumberField` | Planned | Locale- and unit-aware numeric entry | Body Info, food portions, water, workout sets, progress | `value`, `label`, `unit`, `min`, `max`, `precision`, `onChanged`, `validator` | Yes — app-wide | Stateless | Error/helper transition |
| `UnitInput` | Planned | Numeric input paired with explicit selectable unit | Body Info, Food, Water, Progress | `value`, `unit`, `availableUnits`, `onValueChanged`, `onUnitChanged`, `validator` | Yes — app-wide | Stateless | Unit/value crossfade without silent conversion |
| `AppDropdownField<T>` | Planned | Selects one value from a bounded list | Personal Info, assessment, food unit, profile/settings | `value`, `items`, `label`, `itemLabel`, `onChanged`, `validator`, `enabled` | Yes — app-wide | Stateless | Standard menu transition |
| `AppSearchField` | Planned | Search input with clear, debounce indicator, and optional filters | Exercise Library, Food search, Workout search | `query`, `onChanged`, `onSubmitted`, `onClear`, `hint`, `isSearching`, `filterCount` | Yes — app-wide | Stateful — debounce/focus presentation | Clear/search state crossfade |
| `SelectionTile` | Planned | Accessible radio/checkbox-style option row | Goal, Workout Type, Intensity, Settings | `title`, `subtitle`, `icon`, `isSelected`, `onTap`, `selectionType`, `enabled` | Yes — app-wide | Stateless | Selection fill/check transition |
| `AppSliderField` | Planned | Selects a bounded scalar with readable value | Intensity, recovery check-in, settings | `value`, `min`, `max`, `divisions`, `labelBuilder`, `onChanged`, `semanticFormatter` | Yes — app-wide | Stateless | Thumb/value movement supplied by Material |
| `DateField` | Planned | Opens an accessible date picker and displays selection | Personal Info, food date, progress measurement | `value`, `label`, `firstDate`, `lastDate`, `onChanged`, `validator` | Yes — app-wide | Stateless | Picker route transition only |
| `AppSwitchTile` | Planned | Labeled boolean preference with explanation | Settings, reminders, permissions/preferences | `title`, `subtitle`, `value`, `onChanged`, `enabled`, `icon` | Yes — app-wide | Stateless | Material switch animation |

## Progress

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `MacroProgressCard` | Existing | Shows consumed vs target macro with safe clamping | Food, Dashboard, nutrition summaries | `label`, `currentValue`, `targetValue`, `unit`, `color`, `icon` | Yes — nutrition/dashboard | Stateless | Determinate bar/value tween |
| `AppLinearProgress` | Planned | General accessible determinate/indeterminate progress | Assessment, workout, water, sync, downloads | `value`, `label`, `valueLabel`, `color`, `height`, `semanticLabel` | Yes — app-wide | Stateless | 200–350ms value tween |
| `AppCircularProgress` | Planned | Accessible inline, standard, or large circular progress | Loading, goals, recovery, dashboard metrics | `value`, `size`, `strokeWidth`, `color`, `center`, `semanticLabel` | Yes — app-wide | Stateless | Determinate sweep/value tween |
| `StepProgressIndicator` | Planned | Shows current position in a bounded multi-step flow | Assessment and onboarding | `currentStep`, `totalSteps`, `labels`, `onStepTap`, `allowBackNavigation` | Yes — onboarding/assessment | Stateless | Segment fill transition |
| `WaterProgressIndicator` | Planned | Displays hydration amount against target | Dashboard, Water Tracker | `current`, `target`, `unit`, `size`, `onTap` | Yes — water/dashboard | Stateless | Fill/ring tween; reduced-motion fallback |
| `WorkoutCompletionProgress` | Planned | Tracks completed exercises/sets in active workout | Active Workout | `completed`, `total`, `label`, `isPaused` | Yes — workout feature | Stateless | Smooth progress update |
| `SyncProgressIndicator` | Planned | Communicates pending, syncing, synced, or failed data | Food, Workout, Water, Progress, Profile | `status`, `pendingCount`, `onRetry`, `lastSyncedAt` | Yes — app-wide | Stateless | Status icon/text crossfade |

## Charts

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `MetricLineChart` | Planned | Time-series trend for weight, performance, intake, sleep, etc. | Progress metric detail, Dashboard insight | `points`, `range`, `unit`, `color`, `selectedPoint`, `onPointSelected`, `summary` | Yes — progress/dashboard | Stateful — selection/tooltip only | Initial draw and range transition; reduced-motion mode |
| `MacroDonutChart` | Planned | Visual macro distribution with textual equivalent | Food summary, Dashboard | `segments`, `total`, `centerLabel`, `legend`, `semanticSummary` | Yes — nutrition/dashboard | Stateless | Segment sweep on meaningful data change |
| `WorkoutVolumeChart` | Planned | Training volume/frequency trend | Progress, Workout history | `series`, `range`, `unit`, `onRangeChanged`, `semanticSummary` | Yes — workout/progress | Stateful — range/selection only | Series/range transition |
| `RecoveryTrendChart` | Planned | Sleep/energy/soreness/recovery trend | Recovery, Progress | `series`, `range`, `thresholds`, `sources`, `semanticSummary` | Yes — recovery/progress | Stateful — selection only | Line/value transition |
| `BarComparisonChart` | Planned | Compares bounded periods/categories | Progress, Food, Workout summaries | `bars`, `labels`, `unit`, `selectedIndex`, `onSelected`, `semanticSummary` | Yes — app-wide analytics | Stateful — selection only | Bar-height transition |
| `ChartLegend` | Planned | Accessible mapping of series colors/symbols to labels | Every chart screen | `items`, `orientation`, `onItemToggle`, `semanticLabel` | Yes — app-wide | Stateless | Visibility/selection fade |
| `ChartTextSummary` | Planned | Screen-reader and nonvisual summary of chart meaning | Every chart screen | `title`, `summary`, `highlights`, `dataFreshness`, `source` | Yes — app-wide | Stateless | Optional expand/collapse |

## Dialogs

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `AppConfirmationDialog` | Planned | Confirms consequential but non-destructive actions | Assessment exit, workout replacement, unsaved profile changes | `title`, `message`, `confirmLabel`, `cancelLabel`, `onConfirm`, `icon`, `isLoading` | Yes — app-wide | Stateless | Standard Material dialog transition |
| `DestructiveConfirmationDialog` | Planned | Explicitly confirms irreversible/destructive actions | Delete food/water entry, discard workout, delete account | `title`, `consequence`, `confirmLabel`, `requiredConfirmation`, `onConfirm`, `isLoading` | Yes — app-wide | Stateful only if typed confirmation is required | Error-accent state; no dramatic motion |
| `ErrorDialog` | Planned | Blocking error requiring acknowledgment/recovery | Session, export, permissions, unrecoverable operation | `title`, `message`, `details`, `primaryAction`, `secondaryAction` | Yes — app-wide | Stateless | Standard dialog transition |
| `PermissionRationaleDialog` | Planned | Explains why an optional platform permission is requested | Food barcode, reminders, wearable/health data | `permission`, `title`, `message`, `benefits`, `onContinue`, `onNotNow` | Yes — app-wide | Stateless | Standard dialog transition |
| `ActiveWorkoutDialog` | Planned | Resolves an already-active session before starting another | Workout detail/start | `activeWorkout`, `newWorkout`, `onResume`, `onReplace`, `onCancel` | Yes — workout feature | Stateless | Standard dialog transition |
| `UnitChangeDialog` | Planned | Explains presentation conversion and historical-data behavior | Profile, Settings, Body Info | `fromUnit`, `toUnit`, `message`, `onConfirm`, `onCancel` | Yes — profile/assessment | Stateless | Value/unit crossfade after dismissal |

## Bottom Sheets

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `AppActionSheet` | Planned | Presents a short list of contextual actions | Cards, profile, food/workout entries | `title`, `actions`, `showDragHandle`, `onDismiss` | Yes — app-wide | Stateless | Standard Material sheet transition |
| `FilterBottomSheet` | Planned | Applies multiple filters without crowding a screen | Exercise Library, Food search, Workout list, Progress | `filterGroups`, `selection`, `onApply`, `onClear`, `resultCount` | Yes — app-wide | Stateful — draft filter selection | Chip/list transitions |
| `UnitPickerSheet` | Planned | Selects measurement/serving units | Body Info, Food, Water, Progress, Settings | `units`, `selectedUnit`, `onSelected`, `title` | Yes — app-wide | Stateless | Selection transition |
| `QuickAddWaterSheet` | Planned | Chooses preset/custom hydration amount | Dashboard, Water Tracker | `presets`, `unit`, `onPreset`, `onCustom`, `targetContext` | Yes — water feature | Stateless | Preset selection and save feedback |
| `ExerciseSubstitutionSheet` | Planned | Selects a compatible exercise replacement | Active Workout | `currentExercise`, `alternatives`, `filters`, `onSelected` | Yes — workout feature | Stateful — search/filter selection | List/filter transition |
| `FoodPortionSheet` | Planned | Sets portion and serving unit before logging | Food search, recent/saved foods | `food`, `amount`, `units`, `nutritionPreview`, `onLog` | Yes — nutrition feature | Stateful — local draft input | Nutrition value tween |
| `DateRangeSheet` | Planned | Selects a supported chart/report range | Progress, Workout history, Food history | `range`, `presets`, `minDate`, `maxDate`, `onApply` | Yes — app-wide analytics | Stateful — draft range | Range selection transition |

## AppBars

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `AppTopBar` | Planned | Standard title, back, and action app bar | Auth, assessment, details, profile/settings | `title`, `leading`, `actions`, `centerTitle`, `onBack`, `semantics` | Yes — app-wide | Stateless | Scroll elevation/color transition |
| `LargeTitleAppBar` | Planned | Strong top-level hierarchy with collapsible title | Dashboard, Workout, Food, Progress, Profile | `title`, `subtitle`, `actions`, `expandedHeight`, `flexibleContent` | Yes — app-wide | Stateless | Material collapse transition |
| `SearchAppBar` | Planned | Switches between title/actions and search mode | Exercise Library, Food, Workout | `title`, `query`, `onQueryChanged`, `onClose`, `actions`, `hint` | Yes — app-wide | Stateful — search-mode focus only | Title/search crossfade |
| `WorkoutSessionAppBar` | Planned | Shows workout title, elapsed state, pause/exit actions | Active Workout | `title`, `elapsed`, `isPaused`, `onPause`, `onExit` | Yes — workout feature | Stateless | Timer/state crossfade driven externally |

## Navigation

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `MainNavigationBar` | Planned | Five-destination Material 3 navigation | Main Navigation shell | `currentIndex`, `destinations`, `onDestinationSelected`, `badges` | Yes — app shell | Stateless | Selection indicator/icon transition |
| `MainNavigationScaffold` | Planned | Hosts branch navigators and persistent bottom navigation | Main Navigation | `navigationShell`, `destinations`, `safeAreaBehavior` | Yes — app shell | Stateful only as required by GoRouter shell | Branch switch/fade with preserved state |
| `AssessmentStepNavigation` | Planned | Previous/continue controls plus step progress | Personal Info through Result Summary | `currentStep`, `totalSteps`, `canContinue`, `onBack`, `onContinue`, `isSaving` | Yes — assessment feature | Stateless | Step/progress transition |
| `SettingsNavigationTile` | Planned | Navigates to settings/profile sub-destinations | Profile, Settings | `title`, `subtitle`, `icon`, `trailing`, `onTap`, `badge` | Yes — profile/settings | Stateless | Pressed state |
| `BreadcrumbHeader` | Planned | Clarifies hierarchy on wide/tablet detail layouts | Exercise, Workout, Progress detail | `items`, `onItemSelected`, `currentLabel` | Yes — app-wide responsive | Stateless | Item transition |

## Exercise Widgets

These components belong primarily in `features/exercise_library/widgets/` and may be reused by Workout where appropriate.

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `ExerciseListTile` | Planned | Compact exercise identity and metadata row | Exercise Library, substitution search, workout details | `exercise`, `thumbnail`, `muscles`, `equipment`, `onTap`, `trailing` | Yes — exercise/workout | Stateless | Image fade; pressed state |
| `ExerciseGridCard` | Planned | Visual exercise discovery card | Exercise Library grid/tablet layout | `exercise`, `image`, `difficulty`, `isSaved`, `onTap`, `onSave` | Yes — exercise feature | Stateless | Saved icon and image transition |
| `ExerciseMediaViewer` | Planned | Shows form image/video with controls and fallback | Exercise Detail, Active Workout | `media`, `poster`, `altText`, `autoPlay`, `onError`, `controls` | Yes — exercise/workout | Stateful — playback only | Media fade; reduced-motion/autoplay rules |
| `MuscleGroupChip` | Planned | Displays/selects a muscle group | Exercise filters/details, Workout plan | `group`, `isSelected`, `onSelected`, `icon` | Yes — exercise/workout | Stateless | Chip selection transition |
| `EquipmentBadge` | Planned | Compact equipment requirement | Exercise cards/details, Workout Card | `equipment`, `icon`, `semanticLabel` | Yes — exercise/workout | Stateless | None required |
| `ExerciseInstructionStep` | Planned | Numbered accessible exercise instruction | Exercise Detail, Active Workout | `stepNumber`, `instruction`, `image`, `safetyNote` | Yes — exercise/workout | Stateless | Optional reveal transition |
| `ExerciseSafetyNotice` | Planned | Highlights form, contraindication, or stop guidance | Exercise Detail, Active Workout | `title`, `message`, `severity`, `action` | Yes — exercise/workout | Stateless | Expand/collapse for additional detail |

## Food Widgets

These components belong in `features/nutrition/widgets/` unless cross-feature reuse is demonstrated.

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `MealSection` | Planned | Groups diary entries by meal with totals and add action | Food diary | `mealType`, `entries`, `totals`, `onAdd`, `onEntryTap`, `isExpanded` | Yes — nutrition feature | Stateful — expansion only | Expand/collapse and list insertion |
| `FoodLogTile` | Planned | Displays one logged food entry and amount/nutrients | Food diary, meal detail | `entry`, `onTap`, `onEdit`, `onDelete`, `syncStatus` | Yes — nutrition feature | Stateless | Insert/remove and sync-state transition |
| `NutritionSummary` | Planned | Presents daily calories and macro totals | Food, Dashboard, Food detail | `calories`, `calorieTarget`, `macros`, `date`, `onOpenDetails` | Yes — nutrition/dashboard | Stateless | Value/progress tween |
| `MacroLegend` | Planned | Maps macro names to consistent colors and values | Food summary, Macro chart | `macros`, `showTargets`, `orientation` | Yes — nutrition feature | Stateless | Value crossfade |
| `FoodSearchResultTile` | Planned | Food catalog result with serving preview/log action | Food search, recent/saved lists | `food`, `defaultServing`, `calories`, `source`, `onTap`, `onQuickLog` | Yes — nutrition feature | Stateless | Quick-log success feedback |
| `PortionSelector` | Planned | Edits amount and serving unit with nutrition preview | Food Portion Sheet, food editor | `amount`, `unit`, `units`, `onAmountChanged`, `onUnitChanged`, `preview` | Yes — nutrition feature | Stateful — draft input only | Preview value tween |
| `BarcodeScannerFrame` | Planned | Accessible scan targeting and status overlay | Barcode scanner future screen | `status`, `instruction`, `onManualEntry`, `onPermissionHelp` | Yes — nutrition feature | Stateless; scanner controller external | Scan/status transition; reduced-motion safe |
| `MealTypeSelector` | Planned | Selects breakfast/lunch/dinner/snack | Food logging/editor | `value`, `options`, `onChanged` | Yes — nutrition feature | Stateless | Selection transition |

## Workout Widgets

These components belong in `features/workout/widgets/`.

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `WorkoutSummaryHeader` | Planned | Shows workout identity, metadata, and status | Workout Detail, Active Workout, completion summary | `workout`, `status`, `duration`, `difficulty`, `equipment` | Yes — workout feature | Stateless | Status crossfade |
| `WorkoutExerciseTile` | Planned | Exercise row with completion and set summary | Workout Detail, Active Workout | `exercise`, `setSummary`, `isComplete`, `isActive`, `onTap`, `onSubstitute` | Yes — workout feature | Stateless | Active/completed state transition |
| `SetInputRow` | Planned | Captures reps/load/duration and set completion | Active Workout | `set`, `fields`, `units`, `isComplete`, `onChanged`, `onComplete`, `validation` | Yes — workout feature | Stateful — focus/controllers only | Completion/check transition |
| `RestTimer` | Planned | Displays and controls rest countdown | Active Workout | `remaining`, `total`, `isRunning`, `onPause`, `onResume`, `onSkip`, `onAddTime` | Yes — workout feature | Stateful — timer presentation; timing service external | Ring/countdown; reduced-motion mode |
| `WorkoutSessionControls` | Planned | Pause, resume, finish, and discard actions | Active Workout | `isPaused`, `canFinish`, `onPause`, `onResume`, `onFinish`, `onDiscard` | Yes — workout feature | Stateless | Pause/resume icon transition |
| `WorkoutStatRow` | Planned | Displays workout metrics such as time, volume, sets | Workout detail/history/completion | `stats`, `compact`, `semanticSummary` | Yes — workout feature | Stateless | Value tween |
| `WorkoutCompletionHero` | Planned | Celebratory but restrained completion summary | Workout completion | `title`, `duration`, `volume`, `completedSets`, `personalRecords` | Yes — workout feature | Stateless | One-time reduced-motion-aware reveal |
| `PersonalRecordBadge` | Planned | Identifies a verified workout personal record | Active Workout, completion, Progress | `recordType`, `value`, `unit`, `achievedAt` | Yes — workout/progress | Stateless | One-time subtle emphasis; no looping glow |

## Dashboard Widgets

These components belong in `features/dashboard/widgets/` and compose app-wide/feature widgets.

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `DashboardGreeting` | Planned | Personalized greeting and date/context | Dashboard | `displayName`, `date`, `message`, `avatar`, `onAvatarTap` | Yes — dashboard feature | Stateless | Content crossfade at day/user change |
| `TodayWorkoutCard` | Planned | Featured next/resumable workout | Dashboard | `workout`, `sessionStatus`, `onOpen`, `onStartOrResume` | Yes — dashboard feature | Stateless | Status/progress transition |
| `DailyMetricsGrid` | Planned | Responsive collection of key MetricCards | Dashboard | `metrics`, `columns`, `onMetricTap`, `loadingStates` | Yes — dashboard feature | Stateless | Staggered reveal; disabled for reduced motion |
| `QuickActionsRow` | Planned | Fast entry points for water, food, workout, and measurements | Dashboard | `actions`, `onSelected`, `layout` | Yes — dashboard feature | Stateless | Press/selection feedback |
| `DailyGoalSummary` | Planned | Aggregates daily goal completion without shame framing | Dashboard | `goals`, `completedCount`, `onGoalTap`, `semanticSummary` | Yes — dashboard feature | Stateless | Progress/value tween |
| `DashboardSection` | Planned | Standard section title, state, content, and retry wrapper | Dashboard | `title`, `subtitle`, `action`, `state`, `child`, `onRetry` | Yes — dashboard feature | Stateless | State/content crossfade |
| `DataFreshnessLabel` | Planned | Shows source and last-update context | Dashboard, Progress, Recovery | `updatedAt`, `source`, `isStale`, `onInfo` | Yes — cross-feature | Stateless | Text/status crossfade |
| `SectionTitle` | Existing | Standard section heading with optional subtitle/action | Dashboard and sections across all features | `title`, `subtitle`, `actionLabel`, `onActionPressed` | Yes — app-wide | Stateless | Optional action/content fade only |

## Profile Widgets

These components belong in `features/profile/widgets/` or `features/settings/widgets/` unless noted.

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `ProfileHeader` | Planned | Shows identity summary and edit/avatar action | Profile | `displayName`, `email`, `avatar`, `subtitle`, `onEdit`, `onAvatarTap` | Yes — profile feature | Stateless | Avatar/content crossfade |
| `ProfileStatSummary` | Planned | Displays selected account fitness statistics | Profile | `stats`, `onStatTap`, `semanticSummary` | Yes — profile feature | Stateless | Value tween |
| `ProfileSection` | Planned | Groups related profile/settings navigation items | Profile, Settings | `title`, `items`, `footer`, `showDividers` | Yes — profile/settings | Stateless | Optional section expansion |
| `AccountStatusBanner` | Planned | Communicates verification, sync, export, deletion, or account issues | Profile, Settings | `status`, `title`, `message`, `action`, `updatedAt` | Yes — profile/settings | Stateless | Status crossfade |
| `AvatarPicker` | Planned | Chooses, previews, replaces, or removes profile image | Profile editor | `image`, `initials`, `onPick`, `onRemove`, `isUploading`, `uploadProgress` | Yes — profile feature | Stateful — picker/upload presentation only | Preview/upload transition |
| `PrivacyPermissionTile` | Planned | Shows permission/consent state and opens management | Profile privacy, Settings, future wearable setup | `permission`, `status`, `description`, `onManage`, `required` | Yes — profile/settings | Stateless | Status transition |
| `UnitPreferenceTile` | Planned | Displays and changes measurement-system preference | Settings | `category`, `unit`, `availableUnits`, `onChanged` | Yes — settings feature | Stateless | Unit label transition |
| `ThemePreferenceTile` | Planned | Selects system/light/dark theme preference | Settings | `value`, `onChanged`, `options` | Yes — settings feature | Stateless | Theme preview/selection transition |
| `DangerZoneSection` | Planned | Isolates sign-out/delete-account actions with clear consequences | Profile, Settings | `actions`, `description` | Yes — profile/settings | Stateless | No decorative animation |

## Loading Widgets

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `LoadingWidget` | Existing | Accessible standard spinner with optional message | Any destination or localized content region | `message`, `centered`, `color`, `size` | Yes — app-wide | Stateless | Material indeterminate animation; reduced-motion consideration |
| `ButtonLoadingIndicator` | Planned | Consistent small loader inside button dimensions | All submitting buttons | `color`, `size`, `semanticLabel` | Yes — app-wide, normally internal | Stateless | Indeterminate spinner |
| `SkeletonBlock` | Planned | Theme-aware placeholder primitive matching final geometry | Dashboard, lists, cards, Profile | `width`, `height`, `radius`, `shape` | Yes — app-wide | Stateless | Restrained shimmer/pulse; static reduced-motion fallback |
| `CardSkeleton` | Planned | Stable card-shaped loading composition | Dashboard, Workout, Food, Progress | `variant`, `lineCount`, `showImage`, `height` | Yes — app-wide | Stateless | Shared skeleton effect |
| `ListSkeleton` | Planned | Repeated stable loading rows | Exercise Library, Food search, Workout history | `itemCount`, `itemVariant`, `spacing` | Yes — app-wide | Stateless | Shared skeleton effect; no per-row busy semantics |
| `InlineLoadingState` | Planned | Shows localized operation progress without blocking content | Search, sync, pagination, chart refresh | `message`, `progress`, `compact`, `semanticLabel` | Yes — app-wide | Stateless | Spinner/progress transition |
| `PaginationLoader` | Planned | Indicates next-page loading at list end | Exercise, Food search, histories | `isLoading`, `hasMore`, `error`, `onRetry` | Yes — app-wide | Stateless | State crossfade |

## Empty States

| Component | Status | Purpose | Used in screens | Props | Reusable? | State | Future animation support |
|---|---|---|---|---|---|---|---|
| `EmptyState` | Existing | Standard icon, title, message, and optional primary action | Any feature with no content | `title`, `message`, `icon`, `actionLabel`, `onActionPressed` | Yes — app-wide | Stateless | One-time restrained entrance; reduced-motion fallback |
| `NoResultsState` | Planned | Explains that current search/filters have no matches | Exercise Library, Food search, Workout search, Progress filters | `query`, `activeFilters`, `onClearFilters`, `onChangeQuery`, `suggestions` | Yes — app-wide | Stateless | Content crossfade after query/filter change |
| `FirstUseState` | Planned | Introduces a feature and its first meaningful action | Food, Water, Progress, Recovery, Workout plan | `title`, `message`, `icon`, `benefits`, `action` | Yes — app-wide | Stateless | One-time illustration/content reveal |
| `PermissionEmptyState` | Planned | Explains missing optional permission and alternatives | Barcode, reminders, wearable/recovery data | `permission`, `message`, `onRequest`, `alternativeAction`, `isPermanentlyDenied` | Yes — app-wide | Stateless | State transition after permission response |
| `OfflineEmptyState` | Planned | Handles no cached data while offline | Dashboard modules, Exercise/Food catalogs, Progress | `message`, `onRetry`, `availableOfflineAction` | Yes — app-wide | Stateless | Connectivity state crossfade |
| `ErrorState` | Planned | Standard recoverable page/section error | All features | `title`, `message`, `icon`, `onRetry`, `secondaryAction`, `errorType` | Yes — app-wide | Stateless | State/content crossfade; no alarming loop |
| `PartialErrorState` | Planned | Keeps successful content visible while one module fails | Dashboard, Progress, Recovery, Profile | `message`, `failedSource`, `onRetry`, `lastUpdatedAt` | Yes — app-wide | Stateless | Inline status crossfade |

## Composition and ownership rules

1. Do not implement this map all at once. Build a component when an approved screen or flow requires it.
2. Reuse existing components before adding variants. Prefer props/named constructors when purpose and semantics remain the same.
3. Keep feature-local components in their feature. Move to `shared/widgets/` only after genuine cross-feature reuse is established.
4. Widgets receive presentation-ready data and callbacks. They do not fetch, persist, authenticate, calculate business rules, or own app state.
5. Stateful widgets may own focus, animation, expansion, selection previews, timers' visual ticking, or media controllers—not business truth.
6. Every component must support light/dark themes, text scaling, responsive constraints, error/loading/disabled behavior where relevant, and accessibility semantics.
7. Future animation is optional enhancement. Reduced-motion and no-animation behavior must remain fully understandable.
8. Component APIs must use domain-neutral shared types for app-wide components and feature models only inside feature-local components.

## Implementation priority

- **Foundation already available:** `PrimaryButton`, `SecondaryButton`, `AppTextField`, `SectionTitle`, `MetricCard`, `MacroProgressCard`, `LoadingWidget`, and `EmptyState`.
- **Build with first real screens:** app bars, main navigation, selection/input primitives, `ErrorState`, skeletons, and feature cards required by those screens.
- **Build with feature logic:** workout session controls, food logging inputs, hydration controls, charts, recovery widgets, and sync states.
- **Build only with approved integrations:** barcode scanner, avatar upload, wearable source widgets, export/deletion status, and permission rationale components.

Update this map whenever a component is added, renamed, materially re-scoped, promoted to shared ownership, or removed.
