from pathlib import Path
r=Path('work/turn1064_recovery');p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();assert '\n1409. Acceptor-driven aromatic substitution'not in s
s+='''
1409. Acceptor-driven aromatic substitution and recurrence restoration

The aromatic carrier retains five distinct occurrences: left aromatic neighbour a, centre c, right aromatic neighbour b, entering acceptor e and leaving carrier l. Let P_d, P_r and P_l be the ordered donor, recurrence and leaving pairs. Each pair contains two distinct held electron occurrences. The entering slot is the original structural EmptyOne singleton; another EmptyOne object or an occupied slot fails the original identity guard. These are the same held-pair and state types already established for substitution in Section 1408.

The complete local source allocation is
B_0={{a,c}:P_d,{c,b}:P_r,{c,l}:P_l}.
There are no free pairs. Additional source bonds may not touch c, e or l, and e initially has no bond. The source, addition-intermediate and restored-terminal allocations are respectively
B_0={{a,c}:P_d,{c,b}:P_r,{c,l}:P_l},
B_1={{c,b}:P_r,{c,l}:P_l,{c,e}:P_d},
B_2={{a,c}:P_l,{c,b}:P_r,{c,e}:P_d}.
The donor pair moves intact to {c,e}; the leaving pair restores the opened {a,c} incidence; P_r remains on {c,b}. In each state the electron support is
E=P_d∪P_r∪P_l,
with the same six distinct occurrences. The complete atom record A=(a,c,b,e,l) is also unchanged. For every successful transition, the native conservation theorem establishes A_in=A_out and E_in=E_out and retains the supplied occurrence, entry, exit and action fields.

The original role classifier compares the complete local bond dictionary with B_0, B_1 and B_2, preserves the recurrence pair and excludes free pairs and interfering background bonds. The path constructor admits exactly the ordered role lists (source,restored-terminal) and (source,addition-intermediate,restored-terminal). Their action lists are respectively (exchange-and-restore) and (transfer-aromatic-pair,relinquish-leaving-pair-to-restore-recurrence); transition occurrences are exactly 1,…,n and meet their adjacent retained states. The corresponding generated counts are n=1 and n=2. The original cleavage-first control tries to duplicate the still occupied {a,c} bond and is rejected by the inherited distinct-bond guard.

For a fresh retained occurrence u and fresh pair P_u, the aromatic successor appends the same bond ({a,u},P_u) to every state:
A′=A++[u],  B′_i=B_i++[({a,u},P_u)].
The implementation reconstructs the extended carrier and all transitions using the same original guards, then compares path class, transition count and each retained bond prefix. The seven original witnesses establish complete occurrence retention, acceptor transfer, leaving-pair relinquishment, recurrence restoration, both path classes, cleavage-first rejection and the successor result. The complete original carrier and both returned path objects match native execution field for field.

Eight binary axes express carrier completeness, acceptor absence, donor-pair transfer, minimal support change, path order, recurrence restoration, the sealed observation boundary and retained extension. The full product contains 2^8=256 alternatives. The native grammar preserves every original alternative and decision rule; all 131 audited declarations across the ten source-bound modules have empty axiom dependencies.

At the original external observation boundary, four source records include a complete 452-page supplementary PDF. V3 obtains the ordered page texts T=(t_1,…,t_452) through PdfReader.extract_text. That same external extraction is retained; it is not replaced by selected quotations or a native premise about PDF rendering. The native analysis binds the ordered texts to the original PDF source bytes and checks
|T|=N_PDF,
SHA256(canonical(T))=H_T,
Σ_i |t_i|=N_char.
It then applies the original four target checks, including all 452 nonempty pages, 25 optimization rows, 14 displayed zero-yield rows, nine displayed full-yield rows, donor/acceptor coupling, dearomatized support, rearomatization and the retained alternative-mechanism controls. The native result matches the original four checks and all 26 retained analysis fields. External signed, decimal and yield inscriptions remain observation records at this same v3 boundary.

Original sources: sft/chemistry/electrophilic_substitution_law_v1.py, electrophilic_substitution_batch_v1.py, electrophilic_substitution_validation_v1.py and the reused nucleophilic_substitution_law_v1.py. Native verification: SFT/Chemistry/ElectrophilicCarrier.lean, ElectrophilicPath.lean, ElectrophilicConservation.lean, ElectrophilicWitnesses.lean, ElectrophilicGrammar.lean, ElectrophilicEvidence.lean, ElectrophilicAnalysis.lean, ElectrophilicSource.lean, ElectrophilicExperiment.lean and ElectrophilicValidation.lean. Evidence: verification/TURN1498_ELECTROPHILIC. Timeline: TURN1498. Full native programme and empirical comparisons are running; this entry is not yet registered complete.
''';p.write_text(s)
