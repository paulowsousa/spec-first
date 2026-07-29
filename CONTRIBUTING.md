# Contributing

This project is small on purpose. The best contributions make it smaller or sharper,
not bigger.

## What's most useful

**Trigger reports.** The hardest part of a skill is the `description` field — it decides
when Claude reaches for the skill. If it fired when you didn't want it, or stayed quiet
when you did, open an issue with the prompt you used. That's the highest-value feedback
this repo can receive.

**Interview questions that earned their place.** If a question caught a real
misunderstanding in your work before code was written, propose it. Include the situation
it caught.

**Template pruning.** If a section of the spec template is consistently empty or
consistently ignored in your usage, say so. Removing it is a contribution.

## What's out of scope

- Turning this into a project-management tool
- Adding configuration options that could be a fork instead
- Expanding the spec template toward a formal requirements document

## Process

1. Open an issue first for anything beyond a typo — it saves you from building something
   that gets declined.
2. Fork, branch, and keep the change focused on one thing.
3. Describe what you changed and what problem it solves. If you're editing the skill's
   `description`, include before/after prompts that behave differently.

## Testing a change to the skill

There's no test harness — skill behaviour is judged by use. Before opening a PR:

1. Copy your modified skill into `~/.claude/skills/spec-first/`
2. Restart Claude Code
3. Run at least three prompts that *should* trigger it and two that *shouldn't*
4. Include what you observed in the PR description

## Code of conduct

Be decent. Assume good faith. Disagree about the work, not the person.
