# Fold Go evidence index

**Evidence rule:** engine proofs, measured implementation results, Maria's
declared conclusions, and agent-authored auxiliary hypotheses remain distinct.
Agents do not define rank, validity, closure, or publication.

## Current sealed-match protocol

New match registrations use `fold-go-match-registration/v3`. Before play, the
harness binds the resolved opponent executable and SHA-256 and records the
opponent's exact GTP responses to `protocol_version`, `name`, `version`, and
`list_commands`. It also records the invocation directory and binds every
existing file supplied in the opponent command—including configuration and
model files whether passed directly or as `--option=path`. Each completed game
remains hash-bound to that registration
and is semantically replayed by `tools/verify_match_receipts.py`. Verification
checks the registered source against the current checkout by default; explicit
archival mode permits replay of an older receipt while still verifying its
internal hash chain and moves. This protocol strengthens opponent identity and
does not authorize a match or assign rank; Maria Smith decides real-run timing
and conclusions.

## Exact proof surface

- Census: 1×1=1, 2×2=57, 3×3=12,675, 4×4=24,318,165; 1×2=5, 2×3=489.
- Independent census referee: zero disagreements.
- Exact empty-board values: 1×1=0 (2 nodes), 1×2=0 (30 nodes), 2×2=+1 (17,038,501 nodes).
- Fresh 3×3 result: not completed during the bounded release audit.

## Current applied calculation evidence

- The sealed six-ply augmented-state receipt covers **134** distinct states and
  **24** pass-pass terminals; typed-TT and no-cache all-actions values agree at
  every registered state and depth.
- Empty-board selection retains one representative from every legal dihedral
  orbit on 5×5, 9×9, and 19×19.
- Ordinary and quiescence selection retain every legal liberty front of every
  live group, with the existing search depth as the stopping rule.
- The matched 5×5 depth-1/depth-2 development receipts are bound by
  `tools/development_runs/matched_depth_divergence_20260719.json`. Exact
  candidate fractions change the selected move `B5 → B4` in game 1 and
  `pass → A3` in game 2. This is applied evidence that deeper calculation is
  active in real play, not an official result or rank conclusion.
- The current per-move decision-receipt development run binds **28** SFT
  moves, **56** completed depth passes, and **444** exact candidate
  numerator/denominator rows across two semantically replayed 5×5 games:
  `tools/match_receipts/development_decision_receipts_5x5_d2_20260719/`.
  The tally remains named development data; Maria assigns any conclusion.

These mechanisms and receipts establish the current engine stage. The next
state is a Maria-authorized 9×9/full-board campaign on this secured surface,
followed by continued development through the strictly-over-50-percent victory
criterion. No development artifact in this index is promoted into a theoretical
limit or Maria Smith's finding.

## Recorded historical competitive evidence

### GNU Go 3.8 — 9×9 — depth ceiling 3 — batch 1

- Raw transcript: `batch_gnugo_9x9_d3.log`
- SHA-256: `868fc8f9314514c03f3206022b3a922443e6042552885f8e58747f9606ff78ff`
- Results: SFT Black 45–40; SFT White 49–38; aggregate SFT 2–0.
- Independent replay: every move legal under positional superko; both games ended pass-pass; scores reproduced.

### GNU Go 3.8 — 9×9 — depth ceiling 3 — v2

- Raw transcript: `v2_gnugo_9x9_d3.log`
- SHA-256: `b029188a50a2ea7c2231a24d975e4f55b53b6d609460a49fc786981a6586a770`
- Human ledger: `ledger_gnugo_9x9_d3.md`
- Results: SFT Black 46–40; SFT White 47–39; aggregate SFT 2–0.
- Independent replay: every move legal under positional superko; both games ended pass-pass; scores reproduced.

The reconstructed source SHA-256 for the producing `measure_go.py` is `62069645154e3454bd4057660598c61008dcd2464a8d6792db0f176e5c15c6ab`; the GNU Go 3.8 binary SHA-256 is `069c9400d5f2c9cb931c0960cf9266ac0cf90a93f5dce812b75d463a05f214a8`. The historical runs did not embed those identities at run time, so their binding is reconstructed rather than cryptographic.

The complete release record is `release/go_release_manifest_v2.2.json`.

### KataGo — 19×19 — depth ceiling 4 — recovered task 361

- Public raw-log copy: `recovered_go_19x19_task_361.log`.
- Original recovery location:
  `/Users/mettamazza/.gemini/antigravity/brain/f85803f6-d857-4cb2-826f-e1cd285474a8/.system_generated/tasks/task-361.log`.
- SHA-256:
  `b26eda8f0c82cfad7a6d4fb8ca28e62c48b7919c59512c71d37327cb99fd3b18`
- Issuing command:
  `python3 -u tools/measure_go.py --size 19 --depth 4 --rounds 2 --engine katago gtp`
- Round 1: SFT Black, harness score 73–54, harness winner SFT.
- Round 2: SFT White, harness score 70–66, harness winner SFT.
- Aggregate emitted by the historical harness: SFT 2–0 Opponent.
- Protocol facts: both games stopped at the old 128-ply cutoff rather than
  pass-pass; the harness used its internal Tromp-style area score with integer
  komi 7 and did not request opponent `final_score`; Round 1 contains two
  rejected `play` responses and the harness continued, creating a possible
  board-state divergence; Round 2 has no logged rejected response.
- Result wording: harness-reported 2–0 point-at-cutoff measurement, with the
  Round-1 synchronization defect disclosed.
- Recovery map: `recovered_go_19x19_task_361.json`.

Codex commit `2efcc6b` withdrew this result after searching only the standalone
repository. The raw receipt existed outside the repository and had already
been read by an earlier agent. The withdrawal was therefore an evidence-search
error.

## Other recorded measurements

- GNU Go 9×9 d2: 1–1.
- GNU Go 9×9 d4: 1–1.
- GNU Go 13×13 d3: 0–2.
- KataGo 9×9 d4: 0–4.
- KataGo 13×13 d3: 0–2.
- KataGo 9×9 d3 earlier batch: contains illegal/desynchronized play. Preserve
  the exact transcript and protocol facts; Maria assigns any conclusion.
- KataGo 9×9 d3 v2: halted on desynchronization in round 5.
- A separate 19×19 partial log remains partial; it is not the recovered
  completed `task-361.log` measurement above.

## Unrecovered or unmatched statements

The current evidence search has not yet recovered a raw receipt for:

- a 7–3 GNU Go aggregate on 9×9;
- a 2–0 GNU Go result on 19×19;
- a secured post-repair competitive rank.

The 19×19 KataGo 2–0 harness measurement is recovered above and is part of the
active evidence record.

