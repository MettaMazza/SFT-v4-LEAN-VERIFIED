from pathlib import Path
import shutil,datetime
w=Path('work');template=(w/'register_horizoninfo908.py').read_text();now=datetime.datetime.now(datetime.timezone.utc).isoformat()
items=[('wormhole',909,'WormholeEntry','WORMHOLE',781,'Wormhole admissibility','wormhole_admissible and WORMHOLE_SPEC', '''Let s be the exact rational source, L the generated-link condition and T the complete causal-trace condition. The original operation first rejects a non-Fraction input. For every rational s, its returned Boolean is

W(s,L,T)=(0<s) ∧ L ∧ T.

Expanding the two conjunctions gives the exact equivalence

W(s,L,T)=true ⇔ (0<s) ∧ (L=true) ∧ (T=true).

SpacetimeAdmissibility.wormholeExact proves both directions for every source and both flags: acceptance projects each required condition; the three conditions reconstruct acceptance. Thus neither a named remote identification nor a missing causal trace can pass. Positivity is the source guard; the operation adds no upper bound at One. The original witnesses give W(1/4,true,true)=true and W(1/4,false,true)=false, proved by originalWormholeWitnesses.

The original dependency chain supplies horizon information, field locality and causal order. Its base is one generated adjacency with positive source and complete trace. Each added mouth or path cell appends its source, causal predecessor and return records, preserving the same acceptance conditions. The source distinguishes this admissibility result from observation or construction of a physical wormhole; it makes no claim that an astrophysical or engineered traversable wormhole has been observed.'''),('warp',910,'WarpEntry','WARP',782,'Conserved warp-support admissibility','warp_admissible and WARP_SPEC', '''Let s and d denote the exact rational source and destination carriers, and R the complete apparatus/source return ledger. Non-Fraction inputs are rejected. The positive-transfer test is

A(s,d,R)=(0<s) ∧ (0<d) ∧ (s=d) ∧ R.

SpacetimeAdmissibility.warpExact expands this Boolean test in both directions for every rational pair:

A(s,d,R)=true ⇔ (0<s) ∧ (0<d) ∧ (s=d) ∧ (R=true).

Projection of the conjunction yields conservation and the complete return requirement; reconstructing it from the four conditions establishes sufficiency. The conserved difference d−s is therefore zero when the test accepts. No fitted carrier or upper-One cutoff enters this operation. OriginalWarpWitnesses proves the original three outcomes:

A(1/4,1/4,true)=true,
A(1/4,1/4,false)=false,
A(1/4,1/2,true)=false.

This entry follows wormhole admissibility, mechanical conservation and the complete vacuum-cycle ledger. Its base conserves one positive carrier; each further support cell appends transfer and restoration records. An omitted return or changed support fails the exact test. The original result is the admissibility ledger, without a claim of an achieved warp device, observed superluminal transport or engineered spacetime distortion.'''),('timelike',911,'TimelikeEntry','TIMELIKE',783,'Exact closed-timelike recurrence','closed_timelike_admissible and CTC_SPEC', '''Let I and F be the ordered initial and returned physical/proof records, and T the complete transition-trace flag. The original operation is

C(I,F,T)=(I≠()) ∧ (I=F) ∧ T.

SpacetimeAdmissibility.closedTimelikeExact proves, for every pair of ordered string records and both trace flags,

C(I,F,T)=true ⇔ (I≠()) ∧ (I=F) ∧ (T=true).

Each conjunction projects a necessary condition; the same conditions reconstruct acceptance. Equality compares the complete ordered records, so a changed self-ancestor premise cannot satisfy closure. The nonempty condition rejects an empty starting record. The original witnesses are

C((state,proof),(state,proof),true)=true,
C((state,proof),(changed-state,proof),true)=false,
C((state,proof),(state,proof),false)=false.

OriginalTimelikeWitnesses proves all three outcomes. The source dependencies are warp-support admissibility, dynamical systems and the CBL halting entry. Its base returns one complete state only to itself with the trace retained; each transition appends its record and closure compares the entire final and initial records. This is the original recurrence boundary; it does not assert an observed or constructed physical closed timelike curve.''')]
for low,n,tag,key,sec,title,source,body in items:
 for suffix in ['science_report.json','core_audit.log','core_build.log']:shutil.copy2(w/('admissibility909_'+suffix),w/(low+str(n)+'_'+suffix))
 t=template.replace("'HorizonInformation':'Original horizon_information_ledger with empty local predecessor,all eight ordered boundary records,complete inverse-record flag,successor/count proofs and direct reuse of original measurement dependency reconstruction theorem.'", "'SpacetimeAdmissibility':'Exact original wormhole,warp and closed-timelike operations,original accepted domains,complete acceptance equivalences and original witnesses.'").replace('Original local,boundary and complete-inverse witnesses through the actual ledger.','Original entry-specific acceptance and rejection witnesses through the exact source operation.').replace("['horizoninfo908_core_build.log']","[f'{low}{n}_core_build.log']").replace("f'check_{low}{n}.py'","'check_admissibility909.py'")
 (w/f'register_{low}{n}.py').write_text(t)
 grammar='''The eight original binary axes are carrier, dependency, relation, enumeration, minimality, measurement direction, retained record and extension. Their complete product contains 2⁸=256 forms. Each axis contributes both registered alternatives; the native grammar enumerates their full product, applies every original elimination decision and retains the unique all-admitted form. The source relation above supplies the entry-specific relation axis. The full program preserves every candidate, witness, control and closure record; its fresh output matches the original program, and all four original independent-validator cases retain their outcomes. The shared source-operation comparison covers 22 acceptance, omission, type, positivity, equality and recurrence cases across these three entries. All audited entry declarations have empty Lean axiom dependencies.'''
 (w/f'paper_{low}{n}_addition.txt').write_text(f'\n{sec}. {title}\n\n'+body+'\n\n'+grammar+f'\n\nOriginal V3: sft/physics/gravity_spacetime_laws_v1.py, {source}; pin 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Lean: SFT.Physics.SpacetimeAdmissibility and {tag}Witnesses/Grammar/Controls/Evidence. Timeline: TURN{n}. Receipt: verification/TURN_{n}_{key}_COMPLETION.json.\n\nSource and proof links: [Original V3](https://github.com/MettaMazza/ernos-labs-sft-platform/blob/76f1b34e9e9682989adcbb088797b4ae4ce4fcf1/sft/physics/gravity_spacetime_laws_v1.py); [Lean operations and equivalences](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/SpacetimeAdmissibility.lean); [Entry grammar](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/SFT/Physics/{tag}Grammar.lean); [Timeline](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/blob/main/TIMELINE.txt).\n')
 (w/f'timeline{n}_addition.txt').write_text(f'\n{now} — TURN{n}: Reused completed SpacetimeAdmissibility source operations, general exact acceptance equivalences and original witnesses for {source}. Retained original265-job build, full declaration audit, fresh native/original256-form program and original four-case independent-validator results; no duplicate build or derivation. Shared9-declaration core audit and22-case source comparison copied under entry evidence names without rerunning. Registrar verifies current canonical/retained source hashes against the audited configuration, exact prerequisite completion and cursor before registration. Added section{sec} with equations, both-direction equivalence argument, original witnesses, grammar construction and original empirical boundary; linked source,Lean and timeline. Registration updates counts before next dependant.\n')
print('Prepared three registration scripts and complete manuscript additions')
