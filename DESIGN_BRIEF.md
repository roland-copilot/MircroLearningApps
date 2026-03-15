# Design Brief: E-Learning AI Application (MVP)

## 1. Project Overview
Project Title: **Smart E-Learning AI with Document Visualization**
Core Purpose: Turn documents (PDF/DOCX) into visual learning aids (Mind Maps, Flashcards, Infographics, Slide Decks) using AI.

## 2. Target Audience & Persona
- **Users:** Students, Professionals, Lifelong Learners.
- **Goals:** Effective summarization, memorization (spaced repetition), and quick understanding of complex files.
- **Attributes:** Busy, tech-savvy, prefers visual learning over reading long texts.

## 3. Visual Style & Mood
- **Theme:** Clean, Minimalist, "Intelligent" (Notion-like or NotebookLM style).
- **Primary Color:** High-contrast White/Black with an AI Accent Color (e.g., Deep Electric Blue / Purple).
- **Typography:** Modern Sans-Serif (Inter/Roboto), optimized for readability.
- **Vibe:** Focus, clarity, frictionless interaction.

## 4. Key Screens & UX Flow

### A. Home Dashboard
- **Header:** Personalized greeting + Study streak/Daily progress.
- **Action:** Floating Action Button (FAB) or prominent card: **"AI Upload & Analyze"**.
- **Content:** List of recent uploaded documents (with thumbnail preview + progress bar).
- **Quick Review:** "Due Today" section for Flashcards (Spaced Repetition).

### B. Upload Process (The "Magic" Moment)
- **Input:** Simple file picker (PDF/DOCX/Images).
- **Feedback:** Animated state during processing (Scan -> Extract -> Generate -> Ready).
- **Result:** Success toast notification prompting user to "Start Learning".

### C. Learning Detail View (The Tabbed Interface)
This is the core experience. A single document view with 4 distinct learning modes:
1.  **Source Tab:** Embed clean PDF/Doc viewer.
2.  **Mind Map Tab:** Interactive node-based canvas (Zoom/Pan supported).
3.  **Flashcards Tab:** Swipeable card stack (Question Front / Answer Back / Rating Buttons: Hard/Good/Easy).
4.  **Visuals Tab:** Infographic summary list + Mini Slide Deck preview (horizontal scroll).

### D. Chat / Q&A Context
- A contextual chat button available on all tabs to ask questions specifically about the uploaded document.

## 5. UI Elements & Components
- **Buttons:** Rounded corners, pill-shaped for actions.
- **Cards:** Soft shadows, plenty of whitespace (padding), clean borders.
- **Icons:** Thin stroke icons (Outline style) for clarity.
- **Loading:** Skeleton loaders (shimmer effect) instead of spinners.

## 6. Design Constraints (MVP)
- **Simplicity:** Don't clutter the UI with too many features initially. Focus on the 4 outputs.
- **Dark Mode:** Mandatory high-contrast dark mode for night study.
- **Consistency:** Use standard Flutter material/cupertino navigation patterns where possible for speed.

## 7. Interaction Notes
- **Haptic Feedback:** On successful upload and flashcard flip.
- **Transitions:** Smooth fade-in for AI results. avoid abrupt changes.
