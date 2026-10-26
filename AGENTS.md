# SFT v4 working instructions

Recreate the complete SFT v3 corpus in native Lean under Maria Smith's direction.
Read TIMELINE.txt, ZENODO_PAPER_DRAFT.txt and COVERAGE.json at the start of each working turn.
Before ending EVERY working turn, append a dated chronological entry to TIMELINE.txt recording the exact steps performed, files created or changed, commands/checks and their results, failures and repairs, and the exact next step. Never silently rewrite earlier entries.
Keep v3 read-only. Pin source references to the recorded Git commit.
Track every v3 census claim and every tracked source file. Inventory is not proof completion.
Preserve exact claim statements, dependencies, scope and adverse evidence. Native theorem completion and artifact/runtime parity must be tracked separately.
Do not introduce axiom declarations or unfinished proofs. Record Lean axiom audits for exported results. Never label a whole claim complete merely because its candidate classifier compiles.
Run lake build after changes and retain the build and axiom audit results.

Update ZENODO_PAPER_DRAFT.txt alongside TIMELINE.txt at the end of EVERY working turn. Keep the paper aligned with implemented results and retained checks; label it unpublished until publication is explicitly authorized. Preserve Maria Smith as scientific author.

Exact translation is mandatory: do not add, redesign or substitute scientific definitions, representations or derivations. Every active scientific Lean declaration must map to an identified V3 source component. Representational encodings must preserve the exact source domain, order and decisions. Check equivalence before reporting 1:1 status. Keep full-claim status separate from verified translated portions.
The paper is a scientific manuscript, not a development diary. Put corrections, implementation history, troubleshooting and working-turn details ONLY in TIMELINE.txt. Update the paper with model exposition, formal statements, methods and supported results.

Remote publication is authorized: commit verified checkpoints to the public repository MettaMazza/SFT-v4-LEAN-VERIFIED as work proceeds.
