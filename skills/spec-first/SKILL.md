---
name: spec-first
description: Interview the user and write a specification before writing any implementation code. Use this whenever the user asks to build, add, implement, create, or refactor a feature, endpoint, integration, script, or module — even when the request sounds small or obvious, and even when they seem to want code immediately. Also use when a request is vague ("make it better", "add auth"), when scope is unclear, or when the user says "spec this out", "write a spec", or "plan this first".
---

# Spec First

Most implementation failures are specification failures wearing a costume. The code
compiles, the tests pass, and it does the wrong thing — because nobody agreed on what
the right thing was.

This skill inserts one step before implementation: a short interview that produces a
written specification the user approves. Then, and only then, code gets written.

## The rule

**Do not write implementation code until the spec exists and the user has approved it.**

Exceptions — skip the interview and just build:

- The user explicitly declines ("no spec, just write it")
- The change is a genuine one-liner with no ambiguity (typo, version bump, rename)
- The user is debugging something that already exists and wants a fix, not a feature

When in doubt, spend two questions finding out. Two questions is cheap. A wrong
implementation is not.

## Step 1 — Interview

Ask **three to six questions**. Not twenty. The goal is to surface the decisions that
would be expensive to reverse, not to produce a requirements document.

Ask about the things below in roughly this priority order, skipping anything the user
already answered:

| Area | What you're actually trying to learn |
|---|---|
| **Trigger** | What causes this code to run? A user action, a cron, a webhook, another service? |
| **Inputs & shape** | What data arrives, in what format, and what can be missing or malformed? |
| **Success** | What does the output look like when it works? Show me a concrete example. |
| **Failure** | What should happen when it doesn't work? Retry, fail loud, fail silent, queue? |
| **Boundaries** | What is explicitly *not* in scope for this change? |
| **Constraints** | Existing patterns, libraries, or conventions this must match? |

### Interview rules

- **One question at a time** when the answer changes what you'd ask next. Batch them
  only when they're independent.
- **Propose a default with every question.** "Should this retry on failure? I'd default
  to three attempts with backoff" gets a real answer. "What's your retry strategy?"
  gets a shrug.
- **Read the codebase first.** If the repo already answers a question, don't ask it.
  Look at neighbouring files, existing patterns, config, and tests before opening your
  mouth.
- **Stop when the remaining unknowns are cheap to reverse.** Perfect clarity is not the
  goal. Reversibility is.

## Step 2 — Write the spec

Write to `specs/<kebab-case-name>.md`. Create the directory if it doesn't exist.

Use this structure. Delete sections that genuinely don't apply — don't pad them.

```markdown
# <Feature name>

**Status:** draft
**Date:** <YYYY-MM-DD>

## Problem

What is broken or missing today, in two or three sentences. Written so that someone
who wasn't in the conversation understands why this exists.

## Scope

### In
- Bullet list of what this change does.

### Out
- Bullet list of what it explicitly does not do. This section is the most valuable
  part of the document. Do not skip it.

## Behaviour

Describe the happy path as a numbered sequence. Be concrete — real field names, real
values, real endpoints.

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

Anything unresolved, with the assumption you're proceeding under. Empty is fine —
say "None" rather than deleting the section.

## Acceptance

A checklist that can be verified as done or not done. No "works well" entries.

- [ ] ...
```

## Step 3 — Get approval

Show the user the spec and ask one direct question:

> Does this match what you want? Anything wrong or missing before I build it?

Wait for a real answer. "Looks good" is a real answer. Silence is not.

If the user corrects something, edit the spec, show the diff, and ask again. Approval
is a decision, not a formality — if the correction was substantial, they should see
the corrected version before you start.

## Step 4 — Build

Now write the code. While building:

- If reality contradicts the spec, **stop and say so** rather than silently deviating.
  Update the spec, tell the user what changed and why, then continue.
- When done, update the spec's `Status` to `implemented` and check off the acceptance
  boxes that are genuinely satisfied.

## What this skill is not

It is not a ceremony. If your spec is longer than the code it describes, you have
overshot — cut it. A good spec for a small feature is fifteen lines and takes four
minutes to write.

The measure of this skill working is not document quality. It is the number of times
someone says "oh, that's not what I meant" *before* the code exists instead of after.
