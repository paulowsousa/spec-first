# spec-first

A Claude Code skill that asks you three questions before it writes code.

Most implementation failures are specification failures wearing a costume. The code
compiles, the tests pass, and it does the wrong thing — because nobody agreed on what
the right thing was.

`spec-first` inserts one small step before implementation: at most three questions, then
a short written spec you approve. Then the code gets written.

## Install

```bash
git clone https://github.com/paulowsousa/spec-first.git
mkdir -p ~/.claude/skills
cp -r spec-first/skills/spec-first ~/.claude/skills/
```

Or per-project, so your team gets it too:

```bash
mkdir -p .claude/skills
cp -r spec-first/skills/spec-first .claude/skills/
```

Restart Claude Code. That's it.

## Use

You don't invoke it. It triggers on its own when you ask for something to be built:

```
> add a webhook endpoint for payment confirmations
```

Instead of generating code immediately, Claude asks up to three questions — starting
with what's out of scope and what should happen on failure — then writes
`specs/payment-webhook.md` and asks you to approve it.

You approve, correct, or reject. Then it builds.

## Design principles

Three deliberate choices, stated up front because they're the three things people
disagree about:

**Minimum viable friction.** At most three questions. A skill that interrogates you gets
uninstalled in a week, and an uninstalled skill prevents zero bugs. Three questions that
get answered beat twelve that get skipped.

**Your "no" is final.** Say `no spec, just write it` and it writes the code. No warning,
no lecture, no "are you sure". A tool that argues with you is a tool you stop reaching
for — the opt-out is what makes the default acceptable.

**Specs are always in English.** Even when you're working in another language. Specs
outlive conversations: they get read by future teammates, pasted into issues, indexed by
search. English keeps them portable.

## What you get

A `specs/` directory that accumulates the reasoning behind your codebase. Six months
later, when you're staring at a function wondering why it retries three times instead of
once, the answer is written down.

The **Out of scope** section is the part that earns its keep. It's the cheapest possible
place to discover that you and Claude were building different things.

## Example

See [`examples/payment-webhook.md`](examples/payment-webhook.md) for a spec this skill
produces — a page of decisions, not a requirements document.

## When it stays out of the way

It skips the interview when you opt out, when the change is a genuine one-liner (typo,
version bump, rename), and when you're debugging existing code rather than adding
behaviour.

If it triggers when you didn't want it to, that's a bug in the trigger and I want to
know — please [open an issue](../../issues) with the prompt you used.

## Contributing

Contributions welcome, especially:

- Reports of the skill triggering when it shouldn't, or staying quiet when it should
- Questions that earned a place on the priority ladder — with the situation they caught
- Sections of the spec template that never get filled in

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
