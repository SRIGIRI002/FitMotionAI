# FitMotionAI
# UI Guidelines Document

**Version:** 1.0

**Project:** FitMotionAI – Adaptive AI-Powered Fitness, Recovery & Sports Performance Coach

**Framework:** Flutter

**Design Style:** Material Design 3

---

# 1. Design Principles

The application follows the following design principles:

- Clean and modern interface
- Beginner-friendly navigation
- Minimal user interaction
- Consistent color palette
- Responsive layout
- Accessible typography
- Smooth animations

---

# 2. Theme

Primary Color

Blue

Secondary Color

Green

Accent Color

Orange

Background

Light Grey / White

Error

Red

Success

Green

---

# 3. Typography

Headings

Bold

Body

Regular

Buttons

Medium

---

# 4. Navigation

The application uses Bottom Navigation.

Tabs

- Home
- Workout
- Sports
- Progress
- Profile

Recovery and AI Coach will be accessible from the Home Dashboard.

---

# 5. Screens

## Splash Screen

Purpose

Display application logo while checking authentication state.

Components

- Logo
- Loading Indicator

Navigation

Splash → Login

OR

Splash → Home

---

## Login Screen

Components

- Email
- Password
- Login Button
- Register Button
- Forgot Password

Validation

- Email Required
- Password Required

---

## Register Screen

Components

- Name
- Email
- Password
- Confirm Password
- Register Button

Validation

- Email Format
- Password Length
- Password Match

---

## Onboarding

Purpose

Collect fitness information.

Fields

- Age
- Height
- Weight
- Gender
- Fitness Goal
- Activity Level
- Preferred Sport

---

## Home Dashboard

Components

- Welcome Card
- Today's Workout
- Recovery Score
- Quick Actions
- AI Coach Card
- Progress Summary

---

## Workout Screen

Components

- Exercise List
- Timer
- Calories
- Complete Button

---

## Recovery Screen

Components

- Sleep Hours
- Soreness
- Pain Level
- Energy Level
- Recovery Score

---

## Sports Screen

Components

- Sports List
- Training Plans
- Weekly Goal
- Performance Statistics

---

## Progress Screen

Components

- Weekly Progress
- Monthly Progress
- Workout Streak
- Calories Burned
- Recovery Trend

---

## AI Coach

Components

- Chat Interface
- Suggested Questions
- AI Responses

---

## Profile

Components

- Personal Details
- Fitness Goal
- Preferred Sport
- Edit Profile

---

## Settings

Components

- Theme
- Notifications
- About
- Logout

---

# 6. Navigation Flow

Splash

↓

Login

↓

Register

↓

Onboarding

↓

Home Dashboard

↓

Workout

↓

Recovery

↓

Sports

↓

Progress

↓

Profile

↓

Settings

---

# 7. Validation Rules

Every input field shall validate user input before submission.

Examples

Email

Valid email format

Password

Minimum 8 characters

Age

15–80

Height

100–250 cm

Weight

30–250 kg

---

# 8. Future UI Enhancements

- Dark Mode
- Voice Commands
- Smartwatch UI
- Camera Overlay
- Exercise Animation