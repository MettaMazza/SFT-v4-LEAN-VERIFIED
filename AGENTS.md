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

Batch review amendment (user instruction, 2026-10-27)
Validate existing work across all represented entries programmatically before resuming individual implementation. Use the consolidated full-program/source-review results to mark supported completions and identify exact gaps together. Dependency order governs filling those gaps; it does not require serial discovery or review. After the batch is reconciled, rerun checks affected by subsequent changes rather than repeatedly rebuilding a new verification framework or rechecking unrelated unchanged programs.

Existing-work batch completion amendment (user instruction, 2026-10-27)
The final six previously represented entries were requested as one implementation/verification batch. Preserve source dependency order when recording completion, but do not serialize review, status reconciliation or independent checks. Reconcile all newly eligible existing entries together after concrete gaps pass. This supersedes the earlier serial-extension wording for user-authorized batches.

Publication continuation clarification (user, 2026-10-29): Pressing Continue explicitly authorises resuming the goal. Pause only when the NEXT specified publication milestone has been reached and its complete updated review package is ready on GitHub. Do not pause merely because an earlier edition was published. Zenodo publications must explicitly select SFT_PAPER.pdf as default preview and verify the public landing-page preview, not only upload checksums.

Long-running verification batch amendment (user,2026-10-29): While existing comparisons run,continue implementing subsequent derivations and batch their applicable checks. Preserve source dependency order when recording completions. Do not idle waiting for substantial computations; keep original live runs. This overrides the earlier rule forbidding subsequent implementation before current comparison completion.

Batch cadence clarification (user, 2026-10-31): Do not end working turns merely because one manuscript section or scientific entry is finished. Work through substantial dependency-ordered batches, check related changes together using the existing tools, and consolidate manuscript, timeline and GitHub checkpoint updates. Continue recording each entry complete immediately when its actual source obligations pass. Preserve publication milestone stops and live computations.
