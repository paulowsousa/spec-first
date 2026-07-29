# Payment confirmation webhook

**Status:** implemented
**Date:** 2026-07-29

## Problem

Payment confirmations currently arrive only through a nightly reconciliation job, so
orders sit in `pending` for up to 22 hours after the customer has already paid. Support
tickets about "I paid but nothing happened" are the single largest category this quarter.

## Scope

### In
- A `POST /webhooks/payments` endpoint that accepts provider confirmations
- Signature verification against the shared secret
- Transitioning the matching order from `pending` to `paid`
- Idempotency: the same event delivered twice must not double-transition

### Out
- Refund and chargeback events — separate endpoint, separate spec
- Retiring the nightly reconciliation job. It stays as a safety net until the webhook
  has run clean for 30 days.
- Notifying the customer. The existing order-state listener already handles that.

## Behaviour

1. Provider sends `POST /webhooks/payments` with a JSON body and an `X-Signature` header.
2. Verify the signature. On mismatch, return `401` and log at `warn` — do not process.
3. Look up the order by `body.reference`. If not found, return `202` and log at `warn`
   (the provider may be ahead of our order creation; the nightly job will catch it).
4. If the order is already `paid`, return `200` without changes. This is the idempotency
   path and is expected, not an error.
5. Transition the order to `paid`, record `paid_at` and `provider_event_id`.
6. Return `200`.

## Interfaces

Request body:

```json
{
  "event_id": "evt_01J8X...",
  "reference": "ord_44219",
  "amount_cents": 18990,
  "currency": "BRL",
  "status": "confirmed",
  "occurred_at": "2026-07-29T13:04:11Z"
}
```

Responses: `200` processed or already processed · `202` order not found ·
`401` bad signature · `400` malformed body.

## Failure modes

| Condition | Behaviour |
|---|---|
| Signature mismatch | `401`, log `warn`, no processing |
| Order not found | `202`, log `warn`, rely on nightly job |
| Order already `paid` | `200`, no state change |
| `amount_cents` differs from order total | `200`, flag order for manual review, do not transition |
| Database write fails | `500` so the provider retries |

## Open questions

None.

## Acceptance

- [x] Valid signed request transitions a `pending` order to `paid`
- [x] Replayed event returns `200` and leaves state unchanged
- [x] Invalid signature returns `401` and does not touch the order
- [x] Amount mismatch flags for review instead of transitioning
- [x] Unknown reference returns `202` without erroring
