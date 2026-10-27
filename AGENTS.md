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

Completion and dependency-order amendment (user instruction, 2026-10-27)
The existing V3 source defines the task and completion scope. Do not add scientific requirements, strengthen the model, or require general-purpose host-library/platform proofs as an extra condition for completing a scientific entry. Preserve original controls, declarations, source domains and empirical status.
Work on the first incomplete entry whose registered dependencies are complete. Finish that entry before starting or extending another scientific entry. Existing downstream work is retained; it is not authority to skip unfinished dependencies.
For the active entry, map each actual V3 definition, derivation/closure statement, complete candidate enumeration, control and program method to its Lean implementation and applicable proof/output evidence. List any missing work by exact source component and concrete missing implementation or proof. Generic phrases such as 'full semantics', 'general correspondence' or 'integration pending' are not completion criteria.
When all actual source components are represented and the applicable Lean build, zero-axiom audit and source-output comparisons pass, mark the entry complete immediately, clear its remaining list, and update COVERAGE.json, README and the scientific manuscript. A completed entry must not be held open because unrelated platform work remains. Track actual platform source work separately within the overall translation task.
Count completed source entries separately from individual Lean theorems. Do not inflate either count or retain a zero count unsupported by the source comparison. Record a source-specific completion explanation and proceed to the next dependency-ready entry. No new verification framework is required.
Continue pushing verified checkpoints to the authorized public repository MettaMazza/SFT-v4-LEAN-VERIFIED. These instructions refine the existing goal and supersede earlier vague completion labels.
