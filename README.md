# spec-first

A Claude Code skill that interviews you before it writes code.

Most implementation failures are specification failures wearing a costume. The code
compiles, the tests pass, and it does the wrong thing — because nobody agreed on what
the right thing was.

`spec-first` inserts one step before implementation: a short interview that produces a
written spec you approve. Then the code gets written.

## Install

```bash
git clone https://github.com/<your-username>/spec-first.git
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

Instead of generating code immediately, Claude asks three to six questions — what
triggers it, what the payload looks like, what happens on failure, what's out of scope
— then writes `specs/payment-webhook.md` and asks you to approve it.

You approve, correct, or reject. Then it builds.

## What you get

A `specs/` directory that accumulates the reasoning behind your codebase. Six months
later, when you're staring at a function wondering why it retries three times instead
of once, the answer is written down.

The **Out of scope** section is the part that earns its keep. It is the cheapest
possible place to discover that you and Claude were building different things.

## Example

See [`examples/payment-webhook.md`](examples/payment-webhook.md) for a real spec this
skill produces — fifteen lines of decisions, not a requirements document.

## When it stays out of the way

The skill skips the interview when you tell it to (`no spec, just write it`), when the
change is a genuine one-liner, and when you're debugging existing code rather than
adding behaviour.

If it triggers when you didn't want it to, say so — that feedback is useful, please
[open an issue](../../issues).

## Contributing

Contributions welcome, especially:

- Interview questions that caught a real misunderstanding in your work
- Spec template sections that earned their place (or ones that never did)
- Reports of the skill triggering when it shouldn't, or not triggering when it should

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
