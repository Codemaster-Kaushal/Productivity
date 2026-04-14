# Productivity — UI/UX PRD for Stitch

## App Overview

Productivity is a gamified study tracking app built for university and college students. The core concept revolves around a single honest metric called the **True Score** — a daily score (0–100) that tells students whether they actually worked or just felt busy. The app combines goal tracking, pomodoro focus sessions, daily check-ins, streaks, and social accountability into one cohesive experience.

**Target Platform**: Mobile-first (responsive web app), also used on desktop browsers.

**Target Users**: University and college students aged 18–25.

**Design Tone**: Honest, motivating, premium. The app should feel like a smart study coach — not a generic to-do list. Dark mode is the primary theme.

---

## Navigation Structure

The app uses a **bottom navigation bar with 5 tabs**:

1. **Dashboard** (Home icon) — The main hub showing today's metrics
2. **Goals** (Checkmark icon) — Today's Big 3 goals
3. **Pomodoro** (Timer icon) — Focus timer with ambient sounds
4. **Check-in** (Moon/Night icon) — End of day self-assessment
5. **Semester** (Graduation cap icon) — Long-term semester goals

**Additional screens accessed via routes (not in bottom nav)**:
- Login / Signup (unauthenticated users only)
- Score History (accessible from dashboard or scores route)
- Weekly Budget (planning weekly study sessions per subject)
- Streak Board (friend leaderboard)

---

## Page-by-Page Breakdown

---

### 1. Login Screen (`/login`)

**Purpose**: Authenticate existing users.

**Elements**:
- App name/logo "Productivity" at the top as a branded heading
- Email text field
- Password text field (obscured)
- Full-width "Login" button
- "Create Account" text link below the button that navigates to signup
- Error messages appear as snackbars at the bottom

**Behavior**:
- On success: redirect to Dashboard
- On error: show error snackbar

---

### 2. Signup Screen (`/signup`)

**Purpose**: Register new users.

**Elements**:
- "Create Account" heading
- Subtitle text: "Sign up to start tracking your productivity"
- Email text field with email icon prefix
- Password text field with lock icon prefix
- Confirm Password text field with lock icon prefix
- Full-width "Sign Up" button
- "Already have an account? Login" text link

**Behavior**:
- Validates passwords match before submitting
- On success: redirect to Dashboard
- On error: show error snackbar

---

### 3. Dashboard Screen (`/dashboard`) — MAIN HUB

**Purpose**: The primary screen students see. Shows a real-time snapshot of today's productivity with all key metrics at a glance. This is the most important screen in the app.

**Layout (top to bottom, scrollable)**:

#### 3a. Momentum Bar (top of screen)
- A full-width horizontal progress bar
- Shows "Today's Momentum" label on the left, percentage on the right
- Fills up based on a formula combining completed goals, pomodoro sessions, and tasks
- Animates when data loads

#### 3b. Greeting Header
- Time-aware greeting: "Good morning 👋" / "Good afternoon 👋" / "Good evening 👋"
- Below it, a motivational subtitle that changes based on today's score:
  - High score: "You're crushing it today!"
  - Medium: "Great progress, keep pushing!"
  - Low: "Your day is waiting. Let's go."
- A refresh button on the right side

#### 3c. True Score Card
- A prominent card showing today's True Score (0.0 to 100.0)
- The score number animates counting up when the page loads
- Below the score, a verdict word appears with a fade-in delay: "Excellent", "Good", "Okay", "Needs Work", or "Critical"
- A chip at the bottom shows "Strong day ✓" if score ≥80, or "Active day ✓" if any goals completed

#### 3d. Streak & Shield Widget
- A horizontal card split into two halves with a vertical divider
- Left half: Fire emoji + streak count number + "day streak" label
- Right half: Shield emoji + shield count number + "shields" label
- If it's after 9 PM and no activity today, the entire card gets a subtle red border glow as an urgency indicator, with a warning emoji on the right

#### 3e. 7-Day Score Strip
- "Last 7 Days" heading
- A row of 7 square tiles, one for each of the past 7 days
- Each tile shows the score number inside it
- Tiles are color-coded by score range (high = green, medium = yellow, low = red, no data = gray)
- Day-of-week labels below each tile (Mon, Tue, etc.)
- Today's tile has a highlighted border to distinguish it
- Tapping a tile shows a tooltip with the date and exact score

#### 3f. Subject Balance Ring
- "Subject Balance" heading
- A donut chart on the left showing the distribution of today's goals by subject
- Each subject gets a unique color segment in the donut
- On the right: a legend listing each subject with its color dot and goal count
- If all goals are the same subject, a warning text appears: "⚠️ Only one subject today"
- Hidden if no goals exist for today

#### 3g. Quick Stats Grid
- A 2×2 grid of compact stat cards
- Card 1: "🎯 Big 3" — shows "completed/total" (e.g., "2/3")
- Card 2: "🍅 Pomodoros" — shows pomodoro session count for today
- Card 3: "⏱ Focus" — shows total focus minutes today (e.g., "75 min")
- Card 4: "✅ Tasks" — shows completed task count (e.g., "4 done")

#### 3h. Quick Capture FAB (Floating Action Button)
- A floating button in the bottom-right corner with a lightning bolt icon
- Tapping it opens a bottom sheet (see Quick Capture Sheet below)

---

### 4. Quick Capture Sheet (Bottom Sheet overlay, triggered from Dashboard FAB)

**Purpose**: Let students quickly capture a task or goal with natural language in under 5 seconds. No need to fill out forms.

**Elements**:
- A drag handle bar at the top
- "Quick Capture" title with a lightning bolt icon
- An example hint below the title: 'Try: "finish DSA problem set by Thursday"'
- A single text input field with placeholder "What do you need to do?"
- A send button (arrow icon) next to the input
- The sheet rises above the keyboard when typing

**Behavior**:
- Auto-focuses the text field when the sheet opens
- The input is parsed for:
  - Due dates (detects words like "tomorrow", "Thursday", "today")
  - Subject keywords (detects common subjects like "Math", "DSA", "Physics")
  - Type detection (if "goal" is mentioned, saves as a goal; otherwise saves as a task)
- On submit: shows a success snackbar "Added task: [title]" and closes the sheet
- On error: shows an error snackbar

---

### 5. Goals Screen (`/goals`)

**Purpose**: Manage today's Big 3 goals (the most important things to accomplish today).

**Elements**:
- "Today's Goals" title in the app bar
- A list of goal cards, each containing:
  - Goal title text (with strikethrough if completed)
  - Subject label as subtitle
  - A checkbox on the right to toggle completion
- Goals can be swiped right-to-left to reveal a delete action (red background with trash icon)
- Empty state: A flag icon with text "No goals for today" and "Tap + to add your first goal!"
- FAB (+) button to add a new goal

**Add Goal Dialog**:
- "New Goal" title
- Goal title text field
- Subject text field (e.g., "Math, Physics")
- Cancel and Create buttons

**Behavior**:
- Pull-to-refresh to reload goals
- Tap checkbox to mark complete/incomplete
- Swipe to delete

---

### 6. Pomodoro Screen (`/pomodoro`)

**Purpose**: A focus timer for deep work sessions, with ambient sound support.

**Elements**:

#### 6a. Timer Display (before starting)
- A large circular container showing "25:00" in the center
- Below it: a row of duration preset chips: 15 min, 25 min, 45 min, 60 min
- The 25 min chip is highlighted by default as the selected option
- A "Start Focus" button below the chips

#### 6b. Timer Display (while running)
- A large circular progress indicator ring around the remaining time
- The time counts down in MM:SS format
- Two control buttons below:
  - Pause button (amber color) — pauses the timer
  - Stop button (red color) — cancels the session
- When paused, the pause button changes to a play/resume button (green)

#### 6c. Session Complete State
- Large green checkmark icon
- "Session Completed!" text
- "Start Another" button

#### 6d. Focus Music Player (below timer section)
- "🎧 Focus Sounds" heading
- When a track is playing, a small "Playing: [track name]" badge appears
- A grid of ambient sound option chips, each with an emoji icon and name:
  - 🌧️ Rain
  - 🟤 Brown Noise
  - 🌲 Forest
  - 🎵 Lo-fi
  - ☕ Cafe
  - 📻 White Noise
- The currently playing track has a highlighted border and a small pause icon
- A "Stop" button appears when any track is playing

**Behavior**:
- Tap a sound to start playing it
- Tap the playing sound to pause
- Tap a different sound to switch
- Music is independent of the timer — students can use it outside of pomodoro sessions too

---

### 7. Check-in Screen (`/checkin`)

**Purpose**: A quick end-of-day self-assessment that replaces traditional journal entries. Designed to take less than 10 seconds.

**Elements**:

#### 7a. Header Card
- "How was your day?" heading text
- "Takes less than 10 seconds" subtitle
- The card has a subtle animated glow/pulse effect

#### 7b. Energy Slider Card
- Lightning bolt icon + "Energy" label on the left
- Current value badge on the right showing "X/10"
- A horizontal slider from 1 to 10 with 9 tick marks
- The slider track and thumb color change based on value (green for high, red for low)

#### 7c. Focus Slider Card
- Target/bullseye icon + "Focus" label
- Same slider layout as Energy

#### 7d. Mood Slider Card
- Smiley face icon + "Mood" label
- Same slider layout as Energy

#### 7e. Optional Note Field
- A multiline text area with placeholder "Optional: anything on your mind?"
- 3 lines tall

#### 7f. Save Button
- Full-width "Save Check-in" button
- Shows a loading spinner while saving

#### 7g. Summary Preview
- A horizontal row of 3 mini stat chips at the bottom:
  - ⚡ Energy: value
  - 🎯 Focus: value
  - Mood emoji (changes based on value): value
- Each shows the current slider value with matching color

**Behavior**:
- Sliders default to 5
- Tapping Save stores energy, focus, mood, and optional note
- Success: green snackbar "Check-in saved! ✨"

---

### 8. Semester Goals Screen (`/semester`)

**Purpose**: Track long-term semester-level academic goals that span months.

**Elements**:
- "Semester Goals" title in the app bar
- A list of semester goal cards, each containing:
  - A subject badge (e.g., "Mathematics")
  - Active/Inactive status badge on the right
  - Goal title text
  - Semester label + date range (e.g., "Spring 2026 • 2026-01-15 → 2026-05-15")
- Goals can be swiped right-to-left to delete
- Empty state: graduation cap icon + "No semester goals yet" + "Tap + to add your first semester goal!"
- FAB (+) button to add

**Add Semester Goal Dialog**:
- "New Semester Goal" title
- Subject text field
- Goal title text field
- Semester label text field (pre-filled with current semester like "Spring 2026")
- Cancel and Create buttons

---

### 9. Score History Screen (`/scores`)

**Purpose**: View historical True Score data across days.

**Elements**:
- "Score History" title in the app bar
- A scrollable list of score entries, each showing:
  - Date on the left
  - Streak count as subtitle ("Streak: X")
  - Score value on the right, displayed prominently
- Empty state: "No scores yet."

---

### 10. Weekly Budget Screen (`/budget`)

**Purpose**: Plan and track weekly study session targets per subject.

**Elements**:
- "Weekly Budget" title in the app bar
- A list of subject budget cards, each containing:
  - Subject name on the left
  - Fraction display on the right (e.g., "3/5" = 3 actual out of 5 target)
  - A horizontal progress bar showing completion percentage
  - Completion label below the bar (e.g., "60% complete" or "✅ Target reached!")
  - Progress bar color changes: red <50%, amber 50-99%, green 100%+
- Empty state: calendar icon + "No weekly targets set" + "Tap + to plan your study week!"
- FAB (+) button to add a target

**Set Weekly Target Dialog**:
- "Set Weekly Target" title
- Subject name text field
- Session count selector with minus/plus buttons and a number display (default: 5)
- Cancel and Save buttons

---

### 11. Streak Board Screen (`/friends`)

**Purpose**: Social accountability through friend streak comparison.

**Elements**:

#### 11a. My Friend Code Card
- "Your Friend Code" label
- A large 6-character alphanumeric code displayed prominently (e.g., "A3KF9X")
- Tap the code to copy it to clipboard
- "Tap to copy • Share with friends" hint text below
- The card has a subtle gradient background

#### 11b. Leaderboard
- "Leaderboard 🏆" heading
- A ranked list of friends sorted by streak count (highest first)
- Each friend entry shows:
  - Medal emoji for top 3 (🥇, 🥈, 🥉)
  - Display name
  - Friend code in small text below the name
  - Fire emoji + streak count on the right
- The #1 friend's card has a subtle gold border accent
- Empty state: people icon + "No friends yet" + "Share your code or tap + to add a friend"

#### 11c. Add Friend FAB
- FAB with person-add icon

**Add Friend Dialog**:
- "Add Friend" title
- A centered text field for entering a 6-character friend code
- The input is styled with wide letter spacing and uppercase
- Max 6 characters
- Cancel and Add buttons

---

## Global UI Patterns

### Bottom Navigation Bar
- Fixed at the bottom of the screen
- 5 items: Dashboard, Goals, Pomodoro, Check-in, Semester
- The active tab is highlighted
- Subtle shadow on the top edge of the nav bar

### Dialogs
- All dialogs use rounded corners (16px radius)
- Dark surface background matching the app theme
- Two actions: a text "Cancel" button and a filled primary action button

### Snackbars
- Floating style with rounded corners
- Green background for success messages
- Red background for error messages
- Appear at the bottom of the screen above the nav bar

### Empty States
- Centered layout with:
  - A large (64px) icon relevant to the feature
  - A primary text explaining the empty state
  - A secondary text with a call-to-action

### Loading States
- Centered circular progress indicator
- Used when data is being fetched

### Error States
- Red error icon (48px)
- Error message text
- A "Retry" button

### Pull-to-Refresh
- Available on all list-based screens (Goals, Scores, Semester, Budget, Dashboard)

### Cards
- All content cards use rounded corners (12-16px radius)
- Subtle surface color differentiation from the background
- No heavy borders — rely on background color contrast

---

## Data Relationships Between Screens

- **Dashboard** pulls data from Goals, Pomodoro, Tasks, Scores, and Streak systems — it's a read-only aggregation view
- **Goals** and **Tasks** created here appear on the Dashboard's stats and Subject Balance Ring
- **Pomodoro** sessions completed add to the Dashboard's pomodoro count and focus time
- **Check-in** data is stored but currently only displayed after save (future: appears in score calculation)
- **Quick Capture** creates entries that appear in the Goals or Tasks lists
- **Streak Board** reads streak data from user profiles, which update daily based on activity
- **Weekly Budget** tracks pomodoro sessions grouped by subject for the current week
