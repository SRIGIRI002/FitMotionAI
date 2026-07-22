# FitMotionAI
# Database Design Document

**Version:** 1.0

**Project Name:** FitMotionAI – Adaptive AI-Powered Fitness, Recovery & Sports Performance Coach

**Database:** Cloud Firestore

**Prepared By:** Sri Giri Sudhan M D

---

# 1. Introduction

This document defines the database architecture used by FitMotionAI.

The application uses Google Cloud Firestore as its primary NoSQL database. Firestore provides scalability, real-time synchronization, cloud storage, and seamless integration with Firebase Authentication.

The database has been designed to support future AI integration, analytics, and additional fitness features without requiring major structural changes.

---

# 2. Database Overview

FitMotionAI stores data using document-based collections.

Each authenticated user has their own data stored securely using Firebase Authentication UID.

The major collections are:

- users
- workouts
- workout_history
- recovery_logs
- sports_progress
- notifications

---

# 3. Firestore Collections

## 3.1 users

Document ID

Firebase UID

Fields

- name
- email
- age
- gender
- height
- weight
- fitnessGoal
- activityLevel
- selectedSport
- injuryHistory
- createdAt

Purpose

Stores the user's profile information.

---

## 3.2 workouts

Document ID

Auto Generated

Fields

- title
- category
- sport
- difficulty
- duration
- calories
- exercises

Purpose

Stores predefined workout templates.

---

## 3.3 workout_history

Document ID

Auto Generated

Fields

- uid
- workoutId
- completionStatus
- completionTime
- caloriesBurned
- difficultyRating
- feedback
- createdAt

Purpose

Stores completed workout sessions.

---

## 3.4 recovery_logs

Document ID

Auto Generated

Fields

- uid
- sleepHours
- sorenessLevel
- painLevel
- energyLevel
- recoveryScore
- createdAt

Purpose

Stores recovery information used by ACARE.

---

## 3.5 sports_progress

Document ID

Auto Generated

Fields

- uid
- sport
- sessionsCompleted
- currentLevel
- totalMinutes
- achievements

Purpose

Tracks sport-specific improvement.

---

## 3.6 notifications

Document ID

Auto Generated

Fields

- uid
- title
- message
- type
- isRead
- createdAt

Purpose

Stores notification history.

---

# 4. Collection Relationships

users

↓

workout_history

↓

recovery_logs

↓

sports_progress

↓

notifications

Each collection references the authenticated user using the Firebase UID.

---

# 5. Security

All database access shall be protected using Firebase Authentication.

Users may only access their own records.

Firestore Security Rules will enforce this restriction.

---

# 6. Future Collections

Future versions may introduce:

- meal_plans
- wearable_data
- exercise_videos
- ai_predictions
- posture_analysis
- coach_messages

The current database design supports these additions without structural changes.