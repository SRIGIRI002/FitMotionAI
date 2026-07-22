# FitMotionAI

# Adaptive Coaching and Recommendation Engine (ACARE)

**Version:** 1.0

---

# 1. Introduction

## 1.1 Overview

The Adaptive Coaching and Recommendation Engine (ACARE) is the core intelligence system of FitMotionAI. It is designed to function as a virtual fitness coach that provides personalized, adaptive, and explainable coaching recommendations throughout a user's fitness journey.

Unlike conventional fitness applications that generate isolated daily workouts, ACARE evaluates the user's long-term progress, current physical condition, behavioral patterns, and fitness goals before generating a recommendation.

The engine continuously adapts its decisions as the user progresses, ensuring that every recommendation aligns with the user's current abilities, recovery status, and long-term objectives.

---

## 1.2 Vision

ACARE is designed around a simple philosophy:

> **Fitness is a journey, not a collection of workouts.**

The purpose of ACARE is not simply to recommend today's workout.

Its purpose is to guide users through a structured fitness journey by making intelligent coaching decisions that maximize long-term progress while minimizing injury risk and maintaining motivation.

---

## 1.3 Objectives

The primary objectives of ACARE are:

- Deliver personalized coaching recommendations.
- Adapt recommendations according to user recovery.
- Support long-term goal progression.
- Encourage workout consistency.
- Reduce injury risk through intelligent recovery management.
- Provide sport-specific coaching experiences.
- Explain every recommendation using natural language.
- Learn from user feedback to improve future recommendations.
- Support future Machine Learning integration.

---

# 2. Core Philosophy

ACARE follows three fundamental principles.

## 2.1 Understand

Understand who the user is.

This includes:

- Personal profile
- Fitness goals
- Current journey
- Training experience
- Preferences

---

## 2.2 Decide

Determine the best coaching decision based on the user's current readiness rather than following a fixed workout schedule.

Decision making considers:

- Recovery
- Habits
- Context
- Goal Progress

---

## 2.3 Coach

Deliver recommendations that users can understand and trust.

Every recommendation must answer four questions:

- What should I do?
- Why should I do it?
- How should I do it?
- What should I focus on next?

This coaching-first philosophy transforms ACARE from a recommendation engine into an adaptive coaching platform.

---

# 3. ACARE Design Principles

The architecture of ACARE is guided by the following principles.

## Personalization

Every recommendation should be tailored to the individual user.

---

## Adaptability

Recommendations should evolve based on user progress and recovery.

---

## Explainability

Every recommendation must include a clear explanation.

---

## Safety

User safety always has higher priority than workout intensity.

---

## Modularity

Each module performs a single responsibility, allowing future expansion without redesigning the system.

---

## Scalability

The architecture supports future integration with wearable devices, nutrition modules, and machine learning models.

---

## Continuous Improvement

Every completed workout provides new information that helps improve future coaching decisions.

# 4. ACARE System Architecture

## 4.1 Architecture Overview

The Adaptive Coaching and Recommendation Engine (ACARE) follows a layered architecture based on three core pillars:

1. Understand
2. Decide
3. Coach

Each pillar performs a specific responsibility and passes its output to the next layer. This modular design improves maintainability, scalability, and future integration with advanced AI and Machine Learning models.

---

## 4.2 ACARE Workflow

```
                    USER
                      │
                      ▼

══════════════════════════════════════
        UNDERSTAND
══════════════════════════════════════

        Profile Analyzer
               │
               ▼
     Goal Journey Manager

══════════════════════════════════════
          DECIDE
══════════════════════════════════════

     Situation Assessment Layer
               │
               ├── Recovery Analysis
               ├── Habit Intelligence
               └── Context Awareness
               │
               ▼
   Training Readiness Calculator
               │
               ▼
      Workout Decision Engine
               │
               ▼
       Daily Coaching Plan

══════════════════════════════════════
           COACH
══════════════════════════════════════

    Gemini Explanation Engine
               │
               ▼
       User Recommendation
               │
               ▼
        User Feedback
               │
               ▼
      Update User Journey
```

---

# 4.3 Pillar Responsibilities

## Pillar 1 – Understand

Purpose:

Understand who the user is and what they are trying to achieve.

Modules:

### Profile Analyzer

Responsibilities

- Analyze user profile
- Determine fitness level
- Identify physical limitations
- Understand user preferences

Input

- Age
- Gender
- Height
- Weight
- Fitness Level
- Preferred Sport
- Medical Restrictions

Output

- User Profile Summary

---

### Goal Journey Manager

Responsibilities

- Create personalized fitness journeys
- Manage journey milestones
- Track user progression
- Adjust future phases

Input

- Fitness Goal
- Sport
- Current Progress
- Workout History

Output

- Current Journey Stage
- Next Milestone

---

## Pillar 2 – Decide

Purpose

Evaluate the user's current situation and generate the most appropriate coaching plan.

Modules

### Situation Assessment Layer

The Situation Assessment Layer combines three independent analyses.

#### Recovery Analysis

Evaluates

- Sleep
- Energy
- Muscle Soreness
- Pain Level

Output

Recovery Score

---

#### Habit Intelligence

Evaluates

- Workout Consistency
- Workout Streak
- Missed Sessions
- Exercise Preferences
- Preferred Workout Time

Output

Habit Score

---

#### Context Awareness

Evaluates external conditions that may influence today's recommendation.

Examples

- Exam Week
- Travel
- Competition
- Weather
- Busy Schedule

Output

Context Score

---

### Training Readiness Calculator

Purpose

Combine all assessment scores into a single readiness value.

Inputs

- Recovery Score
- Habit Score
- Context Score

Outputs

- Training Readiness Score
- Readiness Level

---

### Workout Decision Engine

Purpose

Generate today's coaching plan based on:

- Training Readiness
- Goal Journey
- User Profile

Output

Daily Coaching Plan

---

## Pillar 3 – Coach

Purpose

Deliver recommendations in a clear, motivating, and understandable manner.

Modules

### Gemini Explanation Engine

Responsibilities

- Explain recommendations
- Provide coaching guidance
- Answer user questions
- Increase user motivation

Important

Gemini never decides workouts.

It explains decisions produced by ACARE.

---

### Feedback Manager

Purpose

Collect user feedback after every completed workout.

Feedback includes

- Workout Difficulty
- Workout Enjoyment
- Completion Status
- User Comments

This feedback is stored and used to improve future recommendations.

---

# 4.4 Advantages of the Architecture

The proposed architecture offers several advantages:

- Modular and maintainable design.
- Easy integration of future AI models.
- Explainable recommendation process.
- Scalable for wearable devices.
- Supports sports-specific coaching.
- Encourages long-term user engagement.
- Minimizes injury risk through readiness assessment.

# 5. Training Readiness Model

## 5.1 Overview

The Training Readiness Model determines how prepared a user is for today's training session.

Rather than relying on a single factor such as sleep or recovery, the model combines multiple aspects of the user's current condition into a single **Training Readiness Score**.

This score becomes the primary input to the Workout Decision Engine.

---

# 5.2 Purpose

The Training Readiness Model aims to:

- Evaluate daily physical readiness.
- Encourage sustainable training habits.
- Reduce injury risk.
- Support adaptive coaching decisions.
- Simplify workout recommendation logic.

---

# 5.3 Components

Training Readiness is calculated using three independent assessment modules.

## Recovery Analysis

Measures the user's physical recovery.

Parameters:

- Sleep Hours
- Energy Level
- Muscle Soreness
- Pain Level

Output:

Recovery Score (0–100)

---

## Habit Intelligence

Measures long-term training consistency.

Parameters:

- Workout Streak
- Weekly Consistency
- Missed Sessions
- Exercise Completion Rate

Output:

Habit Score (0–100)

---

## Context Awareness

Evaluates temporary external factors that may influence training.

Examples:

- Exam Week
- Travel
- Competition
- Busy Schedule
- Weather Conditions

Output:

Context Score (0–100)

---

# 5.4 Weight Distribution

Training Readiness is calculated using weighted scores.

| Component | Weight |
|------------|---------|
| Recovery Score | 50% |
| Habit Score | 30% |
| Context Score | 20% |

Formula:

Training Readiness Score

=

(Recovery × 0.50)

+

(Habit × 0.30)

+

(Context × 0.20)

The final score ranges from 0 to 100.

---

# 5.5 Readiness Levels

| Score | Level | Recommendation |
|--------|-----------------|---------------------------|
| 85–100 | Excellent | High Intensity Training |
| 70–84 | Good | Normal Training |
| 55–69 | Moderate | Reduced Intensity |
| 40–54 | Low | Light Activity |
| 0–39 | Very Low | Recovery / Rest Day |

These readiness levels simplify decision making while maintaining consistent recommendations.

---

# 5.6 Safety Rules

Before calculating Training Readiness, ACARE performs mandatory safety checks.

Rule 1

If Pain Level ≥ 4

↓

Recommend Recovery Session

---

Rule 2

If Pain Level = 5

↓

Recommend Rest Day

---

Rule 3

If Sleep Hours < 4

↓

Reduce Workout Intensity

---

These safety rules always take priority over the calculated readiness score.

---

# 5.7 Output

The Training Readiness Model returns:

- Training Readiness Score
- Readiness Level
- Safety Flag

Example:

Training Readiness Score : 82

Readiness Level : Good

Safety Flag : False

The Workout Decision Engine uses these outputs together with the user's current journey stage to generate the Daily Coaching Plan.

# 6. Goal Journey Manager

## 6.1 Overview

The Goal Journey Manager is responsible for guiding users through a structured, long-term fitness journey.

Unlike conventional fitness applications that recommend independent daily workouts, the Goal Journey Manager organizes training into progressive milestones that align with the user's selected fitness goal.

The user's progress is determined by performance and consistency rather than by the passage of time.

---

# 6.2 Purpose

The Goal Journey Manager aims to:

- Create structured training journeys.
- Guide users toward long-term goals.
- Monitor milestone completion.
- Adapt future recommendations based on progress.
- Prevent premature progression.

---

# 6.3 Supported Goals

Version 1 supports the following fitness goals:

- Weight Loss
- Muscle Gain
- General Fitness
- Sports Performance
- Improve Stamina
- Rehabilitation

Each goal follows its own personalized coaching journey.

---

# 6.4 Journey Structure

Every journey consists of multiple milestones.

General structure:

Goal

↓

Journey

↓

Milestone

↓

Daily Coaching Plan

↓

Feedback

↓

Journey Update

Progression occurs only after milestone requirements are satisfied.

---

# 6.5 Example Journeys

## Weight Loss

Milestone 1

Improve Mobility

↓

Milestone 2

Build Cardio Endurance

↓

Milestone 3

Increase Calorie Expenditure

↓

Milestone 4

Maintenance

---

## Muscle Gain

Milestone 1

Foundation Strength

↓

Milestone 2

Upper Body Development

↓

Milestone 3

Lower Body Development

↓

Milestone 4

Progressive Overload

↓

Milestone 5

Maintenance

---

## Volleyball Performance

Milestone 1

Mobility

↓

Milestone 2

Strength

↓

Milestone 3

Explosive Power

↓

Milestone 4

Match Readiness

---

# 6.6 Milestone Progression Rules

A user advances to the next milestone only if the following conditions are satisfied.

Examples:

- Required workouts completed.
- Minimum consistency maintained.
- Training Readiness remains acceptable.
- Previous milestone objectives achieved.

This ensures progress is based on performance rather than fixed timelines.

---

# 6.7 Milestone Regression

If user performance declines significantly, ACARE may temporarily recommend exercises from an earlier milestone.

Regression may occur when:

- Training Readiness remains consistently low.
- Multiple workouts are skipped.
- Recovery remains poor.
- Injury or pain is reported.

Regression is intended to improve long-term success rather than penalize the user.

---

# 6.8 Journey Output

The Goal Journey Manager returns:

- Current Goal
- Current Journey
- Current Milestone
- Next Milestone
- Journey Progress

These outputs are provided to the Workout Decision Engine during recommendation generation.

# 7. Workout Decision Engine

## 7.1 Overview

The Workout Decision Engine is the decision-making core of ACARE.

Its responsibility is to transform the user's current fitness status into a personalized Daily Coaching Plan.

The engine does not rely on fixed workout schedules. Instead, it evaluates the user's current readiness, long-term journey, and safety conditions before generating today's recommendation.

---

# 7.2 Purpose

The Workout Decision Engine aims to:

- Generate personalized coaching plans.
- Balance workout intensity with recovery.
- Maintain long-term fitness progression.
- Reduce injury risk.
- Adapt recommendations according to user progress.

---

# 7.3 Decision Pipeline

The Workout Decision Engine follows a six-step decision pipeline.

## Step 1 – Safety Validation

Highest priority.

The engine first checks whether any safety conditions exist.

Examples:

- High pain level
- Severe fatigue
- Injury reported

If a safety condition is detected, ACARE immediately generates a Recovery Session or Rest Day.

No further workout evaluation is performed.

---

## Step 2 – Training Readiness Evaluation

If no safety issues are detected, ACARE evaluates the Training Readiness Score.

Readiness determines the maximum safe training intensity.

Example:

Training Readiness = 91

↓

High Intensity Allowed

---

## Step 3 – Journey Stage Identification

The Goal Journey Manager provides the user's current milestone.

Examples:

- Foundation
- Strength
- Cardio Development
- Explosive Power
- Maintenance

The selected workout must align with the current milestone.

---

## Step 4 – Workout Selection

Based on:

- User Goal
- Journey Milestone
- Training Readiness
- User Profile

ACARE selects:

- Workout Category
- Exercise Set
- Training Duration

---

## Step 5 – Intensity Adjustment

The workout intensity is automatically adjusted.

Possible intensity levels:

- Recovery
- Light
- Moderate
- High

The adjustment considers:

- Recovery
- Recent workload
- Habit Score
- Context Score

---

## Step 6 – Daily Coaching Plan Generation

The engine generates the final Daily Coaching Plan.

The plan includes:

- Workout Type
- Duration
- Intensity
- Warm-up
- Main Exercises
- Cool-down
- Recovery Advice
- Motivation
- Confidence Score

This plan becomes the final output of ACARE.

---

# 7.4 Decision Inputs

The Workout Decision Engine receives:

- User Profile Summary
- Current Goal
- Current Milestone
- Training Readiness Score
- Recovery Status
- Habit Score
- Context Score

---

# 7.5 Decision Outputs

The Workout Decision Engine returns:

- Daily Coaching Plan
- Workout Category
- Workout Duration
- Workout Intensity
- Recovery Recommendation
- Recommendation Confidence

---

# 7.6 Design Principles

The Workout Decision Engine follows these principles.

### Safety First

No workout recommendation should increase injury risk.

---

### Goal-Oriented

Every recommendation should move the user toward their current milestone.

---

### Adaptive

Recommendations change according to the user's readiness and behavior.

---

### Explainable

Every recommendation must be supported by a clear reason that can be explained to the user through the Gemini Explanation Engine.

# 8. Coaching Feedback and Learning

## 8.1 Overview

The Coaching Feedback and Learning module enables ACARE to evaluate the outcome of each completed workout.

Instead of ending the coaching process after generating a Daily Coaching Plan, ACARE collects post-workout feedback and uses it to improve future recommendations.

This creates a continuous coaching cycle where every completed workout contributes to a more personalized fitness journey.

---

# 8.2 Coaching Cycle

The coaching process follows a continuous feedback loop.

```
Daily Coaching Plan
        │
        ▼
User Completes Workout
        │
        ▼
Daily Coaching Report
        │
        ▼
Feedback Analysis
        │
        ▼
Journey Update
        │
        ▼
Next Daily Coaching Plan
```

---

# 8.3 Daily Coaching Report

After each workout, ACARE generates a Daily Coaching Report.

The report summarizes the user's workout performance and feedback.

The report includes:

- Workout Completion Status
- Actual Workout Duration
- Perceived Difficulty
- Energy After Workout
- Enjoyment Rating
- User Notes
- Recovery Feedback

---

# 8.4 Feedback Analysis

The Feedback Analysis module evaluates the user's response to the workout.

It identifies patterns such as:

- Frequently skipped workouts
- Exercises completed successfully
- Exercises that are consistently difficult
- Preferred workout duration
- Preferred workout intensity

These insights help ACARE improve future coaching plans.

---

# 8.5 Journey Update

Based on the feedback analysis, ACARE updates the user's fitness journey.

Possible updates include:

- Increase training intensity.
- Reduce workout volume.
- Recommend additional recovery.
- Maintain the current milestone.
- Progress to the next milestone.
- Return temporarily to an earlier milestone if necessary.

The objective is to support long-term progress while minimizing injury risk.

---

# 8.6 Benefits

The Coaching Feedback and Learning module provides several advantages:

- Continuous personalization.
- Adaptive coaching.
- Improved user engagement.
- Better long-term progression.
- Data collection for future AI and Machine Learning models.

# 9. Gemini Explanation Engine

## 9.1 Overview

The Gemini Explanation Engine is responsible for communicating ACARE's decisions to the user in a clear, motivating, and understandable manner.

It does not make workout decisions. Instead, it explains the recommendations generated by ACARE.

---

# 9.2 Purpose

The Gemini Explanation Engine aims to:

- Explain workout recommendations.
- Increase user confidence.
- Answer fitness-related questions.
- Provide motivational coaching.
- Improve user engagement.

---

# 9.3 Responsibilities

The Gemini Explanation Engine performs the following tasks:

- Explain why a workout was recommended.
- Describe how today's workout supports the user's long-term goal.
- Suggest recovery practices.
- Provide motivational messages.
- Answer user questions about exercises and training.

---

# 9.4 Example Explanation

Example Recommendation:

High-Intensity Upper Body Workout

Example Explanation:

"Your recovery score is excellent, and you have maintained a consistent workout routine this week. Based on your current Strength milestone, today's session focuses on upper body development to help you progress safely toward your muscle gain goal."

---

# 9.5 Design Principle

To ensure consistency and safety:

- ACARE decides.
- Gemini explains.

Gemini never overrides or modifies ACARE's coaching decisions.

---

# 9.6 Future Enhancements

Future versions may include:

- Voice-based coaching.
- Multilingual explanations.
- Personalized motivational style.
- Conversational AI fitness assistant.

# 10. Future Machine Learning Integration

## 10.1 Overview

The current version of ACARE is built using a rule-based decision engine to ensure transparency, reliability, and ease of implementation.

As more user data is collected over time, ACARE can be enhanced with Machine Learning models that improve personalization and predictive capabilities.

The modular architecture allows these models to be integrated without changing the overall system design.

---

# 10.2 Why Machine Learning?

Rule-based systems perform well for predefined scenarios, but they cannot continuously learn from large amounts of user data.

Machine Learning enables ACARE to:

- Learn from historical workout data.
- Improve recommendation accuracy.
- Predict user behavior.
- Detect long-term fitness patterns.
- Personalize coaching at a deeper level.

---

# 10.3 Potential Machine Learning Applications

Future versions of ACARE may incorporate Machine Learning for the following tasks:

### Workout Success Prediction

Estimate the likelihood that a user will successfully complete a recommended workout.

---

### Recovery Prediction

Predict future recovery levels using historical sleep, soreness, and workout data.

---

### Injury Risk Prediction

Identify users who may be at a higher risk of overtraining or injury based on training patterns.

---

### Personalized Progress Prediction

Estimate the expected time required to achieve specific fitness milestones.

---

### Recommendation Optimization

Analyze user preferences and historical performance to recommend the most effective workout plans.

---

# 10.4 Proposed Machine Learning Pipeline

```
Workout History
        │
        ▼
Data Collection
        │
        ▼
Data Cleaning
        │
        ▼
Feature Engineering
        │
        ▼
Machine Learning Model
        │
        ▼
Predictions
        │
        ▼
ACARE Decision Engine
```

The Machine Learning model supports ACARE by providing predictions. Final coaching decisions continue to be made by ACARE.

---

# 10.5 Design Principle

The integration of Machine Learning follows the principle:

"Predict, Don't Decide."

Machine Learning models provide insights and predictions, while ACARE remains responsible for generating the final coaching plan.

This approach maintains explainability, consistency, and user safety.

---

# 10.6 Benefits

Future Machine Learning integration will provide:

- Better personalization.
- Higher recommendation accuracy.
- Faster adaptation to user behavior.
- Improved long-term coaching.
- Data-driven fitness insights.

# 11. Conclusion

The Adaptive Coaching and Recommendation Engine (ACARE) provides a structured and intelligent framework for delivering personalized fitness coaching.

Unlike traditional fitness applications that rely on static workout plans, ACARE continuously evaluates the user's recovery, habits, context, and long-term fitness journey to generate adaptive Daily Coaching Plans.

Its modular architecture ensures that each component has a clearly defined responsibility, making the system easier to maintain, extend, and improve.

By separating decision-making from explanation, ACARE provides transparent and trustworthy recommendations while allowing the Gemini Explanation Engine to deliver meaningful coaching guidance and motivation.

The architecture also supports future integration of Machine Learning models without requiring significant changes to the existing system.

Overall, ACARE establishes a scalable foundation for FitMotionAI, enabling adaptive, explainable, and user-centered fitness coaching that promotes sustainable progress, reduces injury risk, and encourages long-term engagement.

# Appendix A – Key Algorithms

## A.1 Training Readiness Algorithm

### Objective

Calculate the user's daily Training Readiness Score based on recovery, habits, and context.

### Inputs

- Recovery Score (0–100)
- Habit Score (0–100)
- Context Score (0–100)

### Output

- Training Readiness Score (0–100)
- Readiness Level

### Formula

Training Readiness Score =

(Recovery × 0.50)

+

(Habit × 0.30)

+

(Context × 0.20)

### Readiness Classification

| Score | Readiness Level |
|--------|-----------------|
| 85–100 | Excellent |
| 70–84 | Good |
| 55–69 | Moderate |
| 40–54 | Low |
| 0–39 | Very Low |

---

## A.2 Workout Decision Algorithm

### Objective

Generate a personalized Daily Coaching Plan.

### Pseudocode

```
Receive User Profile

Receive Goal Journey

Receive Training Readiness

Check Safety Rules

IF Safety Rule Triggered

    Return Recovery Plan

ELSE

    Determine Current Milestone

    Select Workout Category

    Adjust Workout Intensity

    Generate Daily Coaching Plan

Return Coaching Plan
```

---

## A.3 Journey Progression Algorithm

### Objective

Determine whether the user should remain in the current milestone, progress, or temporarily regress.

### Pseudocode

```
IF Milestone Requirements Completed

    Move To Next Milestone

ELSE IF Recovery Is Poor

    Stay In Current Milestone

ELSE IF Multiple Workouts Skipped

    Stay In Current Milestone

ELSE IF Injury Reported

    Recommend Previous Milestone

ELSE

    Continue Current Coaching Plan
```

---

## A.4 Feedback Learning Algorithm

### Objective

Use workout feedback to improve future coaching plans.

### Pseudocode

```
Receive Workout Report

Update Workout History

Analyze User Feedback

Update Habit Score

Update Recovery Information

Update Journey Progress

Generate Improved Recommendation
```

---

## A.5 Safety Validation Algorithm

### Objective

Ensure that no unsafe workout recommendations are generated.

### Pseudocode

```
IF Pain Level >= 5

    Recommend Rest Day

ELSE IF Pain Level >= 4

    Recommend Recovery Session

ELSE IF Sleep Hours < 4

    Reduce Workout Intensity

ELSE

    Continue Decision Pipeline
```

---

## A.6 Overall ACARE Workflow

```
             User
               │
               ▼
      Collect User Data
               │
               ▼
      Profile Analysis
               │
               ▼
     Goal Journey Manager
               │
               ▼
   Situation Assessment
      ├── Recovery
      ├── Habit
      └── Context
               │
               ▼
 Training Readiness Score
               │
               ▼
    Safety Validation
               │
               ▼
  Workout Decision Engine
               │
               ▼
  Daily Coaching Plan
               │
               ▼
 Gemini Explanation Engine
               │
               ▼
      User Workout
               │
               ▼
 Daily Coaching Report
               │
               ▼
 Feedback Analysis
               │
               ▼
 Journey Update
               │
               └───────────────┐
                               │
                               ▼
                  Next Coaching Cycle
```

---

## A.7 Computational Complexity

| Module | Time Complexity |
|---------|-----------------|
| Profile Analysis | O(1) |
| Goal Journey Manager | O(1) |
| Recovery Analysis | O(1) |
| Habit Intelligence | O(n) |
| Context Awareness | O(1) |
| Training Readiness Calculation | O(1) |
| Workout Decision Engine | O(1) |
| Feedback Analysis | O(n) |

Where **n** represents the number of historical workout records analyzed.

---

## A.8 Future Enhancements

The current ACARE implementation uses deterministic rule-based decision making.

Future versions may incorporate:

- Machine Learning–based readiness prediction
- Wearable device integration
- Real-time heart rate analysis
- Sleep tracker synchronization
- Personalized nutrition recommendations
- Voice-enabled AI coaching
- Adaptive exercise difficulty adjustment
- Federated learning for privacy-preserving personalization