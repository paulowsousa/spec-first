---
name: spec-first
description: Ask one to three essential questions and write a short specification before writing implementation code. Use this whenever the user asks to build, add, implement, create, or refactor a feature, endpoint, integration, script, or module — even when the request sounds small, and even when they seem to want code immediately. Also use when a request is vague ("make it better", "add auth"), when scope is unclear, or when the user says "spec this out", "write a spec", or "plan this first". Do not use it when the user has explicitly opted out.
---

# Spec First

Most implementation failures are specification failures wearing a costume. The code
compiles, the tests pass, and it does the wrong thing — because nobody agreed on what
the right thing was.

This skill inserts one small step before implementation: one to three questions, then a
short written spec the user approves. Then code.

## Design principles

These are deliberate. They're also the three things people will argue about, so they're
stated up front.

**1. Minimum viable friction.** At most three questions. A skill that interrogates you
gets uninstalled in a week, and an uninstalled skill prevents zero bugs. Three questions
that get answered beat twelve that get skipped.

**2. The developer's "no" is final.** If the user opts out, write the code. No warning,
no lecture, no "are you sure". A tool that argues with you is a tool you stop reaching
for. The opt-out is what makes the default acceptable.

**3. Specs are written in English, always.** Even when the conversation is in another
language. Specs outlive conversations — they get read by future teammates, pasted into
issues, and indexed by search. English keeps them portable.

## The rule

**Do not write implementation code until a spec exists and the user has approved it.**

Skip the interview entirely and just build when:

- **The user opts out.** Any form of "no spec", "just write it", "skip the questions",
  "just do it" — comply immediately and write the code. Do not ask again in that session.
- The change is a genuine one-liner with no ambiguity (typo, version bump, rename).
- The user is debugging something that already exists and wants a fix, not a feature.

## Step 1 — Ask one to three questions

Not four. Not "just one more". The cap is real and it forces the right discipline:
**ask only questions whose answers would change what you build.**

Read the codebase first. If neighbouring files, existing patterns, config, or tests
already answer a question, it's answered — don't spend one of your three on it.

Then pick from this ladder, highest first, and stop when the remaining unknowns are
cheap to reverse:

| Priority | Question | Why it's this high |
|---|---|---|
| 1 | **What's explicitly out of scope here?** | The cheapest possible place to discover you're building different things |
| 2 | **What should happen when it fails?** | Almost never volunteered, almost always matters |
| 3 | **What does the input actually look like?** | Ask when the shape is unclear or can be malformed |
| 4 | **What triggers this?** | Ask when it isn't obvious from the request |
| 5 | **Any existing pattern this must match?** | Ask only if the codebase didn't already tell you |

**Always propose a default with the question.** "Should this retry on failure? I'd
default to three attempts with backoff" gets a real answer. "What's your retry strategy?"
gets a shrug.

Ask them one at a time if the answer changes what you'd ask next. Otherwise batch them.

## Step 2 — Write the spec

Write to `specs/<kebab-case-name>.md`, **in English**, regardless of the conversation
language. Create the directory if it doesn't exist.

Keep it short. If the spec is longer than the code it describes, you have overshot —
cut it. Delete sections that genuinely don't apply rather than padding them.

```markdown
# <Feature name>

**Status:** draft
**Date:** <YYYY-MM-DD>

## Problem

What is broken or missing today, in two or three sentences. Written so someone who
wasn't in the conversation understands why this exists.

## Scope

### In
- What this change does.

### Out
- What it explicitly does not do. This is the most valuable section in the document.
  Do not skip it.

## Behaviour

The happy path as a numbered sequence. Concrete — real field names, real values, real
endpoints.

1. ...
2. ...

## Interfaces

Function signatures, endpoint shapes, request/response examples, schema changes.
Concrete enough that two people would build the same thing from it.

## Failure modes

| Condition | Behaviour |
|---|---|
| ... | ... |

## Open questions

Anything unresolved, with the assumption you're proceeding under. Say "None" rather
than deleting the section.

## Acceptance

A checklist that can be verified as done or not done. No "works well" entries.

- [ ] ...
```

## Step 3 — Get approval

Show the spec and ask one direct question:

> Does this match what you want? Anything wrong or missing before I build it?

"Looks good" is a real answer. Silence is not — wait for one.

If the user corrects something substantial, edit the spec, show what changed, and
confirm once before starting. If it's minor, fix it and proceed.

## Step 4 — Build

Now write the code. While building:

- If reality contradicts the spec, **stop and say so** rather than silently deviating.
  Update the spec, say what changed and why, then continue.
- When done, set the spec's `Status` to `implemented` and check off the acceptance
  boxes that are genuinely satisfied.

## What this skill is not

It is not a ceremony, and it is not a gate. A good spec for a small feature is fifteen
lines and takes four minutes.

The measure of it working is not document quality. It's the number of times someone
says "oh, that's not what I meant" *before* the code exists instead of after.
