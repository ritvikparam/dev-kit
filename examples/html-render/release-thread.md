# #release-v2.4 thread (exported, 2026-10-21)

**maya** 09:12 — heads up, v2.4 release is blocked. e2e suite failed twice on `checkout.spec.ts`, payment iframe times out

**dev** 09:15 — is that the stripe sandbox again? it was flaky last week too

**maya** 09:18 — not sure, the timeout is 10s and it's taking ~12s in CI. locally passes

**arjun** 09:31 — I bumped the iframe timeout to 20s in #482 as a stopgap, can someone review

**dev** 09:40 — reviewed, lgtm but we should not ship a 20s timeout as the real fix. that's hiding something

**maya** 09:44 — agreed. the iframe load got slower after we added the fraud-check script in #471

**arjun** 09:52 — ok so plan: merge #482 to unblock v2.4, then lazy-load the fraud script after iframe mount. I'll open a ticket

**priya** 10:05 — fine with that for v2.4. but I want the release notes to mention checkout may feel slower for some users. also who owns the flaky-test dashboard now? nobody has looked at it since sam left

**dev** 10:07 — I can take the dashboard

**maya** 10:20 — #482 merged, CI green ✅ cutting v2.4 now

**priya** 10:22 — 🙏 also let's not forget the docs PR for the new refund API (#476), it's been open for 9 days

**arjun** 10:40 — ticket for the lazy-load: PAY-318
