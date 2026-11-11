from pathlib import Path
import datetime,json,hashlib
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work/constants-recovery')
paper='''

541. Molecular identity: connected neutral carriers and retained composition

Write the molecular record as M=(O,L,B,Q), where O is the ordered list of atomic occurrence identities, L the corresponding element labels, B the retained bonds and Q the open net-charge fibres. The original constructor requires |O|≥2, |O|=|L|, distinct nonblank occurrence identities, nonblank element labels and B≠∅. Each bond joins distinct registered occurrences. Sorting its two endpoints gives its undirected identity; two bonds with that same identity are rejected.

Starting from the first occurrence o₀, the source connectivity procedure repeatedly adds the opposite endpoint of every bond incident to the reached set. Thus

  R₀={o₀},
  Rₙ₊₁=Rₙ ∪ {v : ∃u∈Rₙ, (u,v)∈B or (v,u)∈B}.

At closure R*, the returned condition is R*=set(O). The Lean proof connectedFixedPointEquivalent connects the existing sweep-history construction to path reachability and proves both inclusions of this equality. This also preserves the standalone helper's treatment of endpoints outside O: a reachable outside endpoint prevents equality. Accepted molecular records additionally require Q=∅. Their ordered occurrence, element and bond records are returned unchanged.

The source base is O=[atom-occurrence-one,atom-occurrence-two], L=[E,E], B=[(atom-occurrence-one,atom-occurrence-two)], Q=∅. The empty path reaches the first occurrence and the retained bond reaches the second. The originalDiatomicConnected and originalDiatomicAdmitted proofs establish this base directly. The composition signature is

  C(M)=[(ℓ,Σᵢ 1[Lᵢ=ℓ]) : ℓ∈sorted(set(L))],
  C(M₀)=[(E,2)].

For a generated occurrence x attached to an existing anchor a, append x to O, its element e to L, and (a,x) to B. Every old path remains a path in the enlarged graph. A path from o₀ to a followed by the new bond reaches x. All edge endpoints belong to the enlarged occurrence list, so no outside endpoint can be reached. Consequently connectivity is preserved. Q remains empty, and every earlier occurrence and bond is retained. Element multiplicity satisfies

  count(ℓ,L++[e])=count(ℓ,L)+1[ℓ=e].

These are the source's base and successor constructions; the proofs reuse the established graph retention and path-extension results.

Pinned V3 source (76f1b34e9e9682989adcbb088797b4ae4ce4fcf1): sft/chemistry/molecular_structure_derivation.py, MolecularCarrier, _connected, composition_signature, _DIATOMIC and MOLECULAR_STRUCTURE_BLUEPRINTS[0]. Lean verification: SFT/Chemistry/MolecularCarrier.lean, acceptedConditions, completeRecordRetained, connectedFixedPointEquivalent, adjacentOccurrencePreservesConnectivity, originalDiatomicAdmitted, originalDiatomicComposition, appendRetainsCharge, appendRetainsIdentities, appendRetainsBonds and appendCountsElement; existing MetallicNetwork and graph path proofs. Chronological record: TIMELINE.txt, Turn576. These declarations pass the empty-axiom audit recorded with the entry's verification evidence.
'''
p=r/'ZENODO_PAPER_DRAFT.txt'
if '\n541. Molecular identity:' not in p.read_text():
 with p.open('a') as f:f.write(paper)
now=datetime.datetime.now(datetime.timezone.utc).isoformat()
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+now+' Turn576 continuation: Ran current_step and read canonical guidance, exact continuation state and goal objective. Inspected pinned molecular constructor, connectivity helper, composition signature, base and successor statements, and existing MetallicNetwork graph proofs. Preserved original running seal comparison. Fresh constructor comparison passed76 cases and standalone connectivity8 cases. Fixed an Edge type annotation in helperNodesKnown and Lean layout/type inference in the extension proof. Proved the original named diatomic base admission and composition; connected arbitrary adjacent-occurrence extension to retainedPathWitness and extendPathWitness, with exact endpoint coverage, charge and count retention. Rebuilt changed MolecularCarrier only; reused compiled grammar/evidence. Prepared MoleculeExperiment and MoleculeValidation with the original pre-source seal check; both built. Combined166-declaration audit passed with empty axiom dependencies. Native program link initially lacked SourceExtraction symbols; compiled its existing source and SourceText for linking without changing their definitions. Full empirical and30-case source-seal comparisons remain running; native256-form program comparison launched. Updated manuscript section541 with equations, actual proof names and source references. No completion registered or remote publication claimed yet. Next: preserve live jobs, resolve any actual comparison failure, run original independent controls, then register immediately and push the verified checkpoint.\n')
s=json.load(open(r/'CONTINUATION_STATE.json'))
s['live_jobs'] += [{'session_id':23524,'command':'python3 work/run_molecule576.py > work/run_molecule576.log 2>&1','purpose':'Native256-form full program comparison'}]
for rel in ['SFT/Chemistry/'+m+'.lean' for m in json.load(open('work/molecule576_audit_config.json'))['modules']]:
 old=next((x for x in s['snapshot'] if x['root']=='retained' and x['path']==rel),None)
 value={'root':'retained','path':rel,'sha256':hashlib.sha256((w/rel).read_bytes()).hexdigest()}
 if old: old.update(value)
 else:s['snapshot'].append(value)
s['recorded_at']=now
(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n')
