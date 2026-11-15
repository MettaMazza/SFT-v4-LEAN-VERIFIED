from pathlib import Path
import sys,json,os,subprocess,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import symmetric_source_conservation_terminal_law_v1 as src
s='''import SFT.Physics.SymmetricSourceConservationCertificate
import SFT.Host.Canonical
open SFT.Physics.SymmetricSourceConservation SFT.Physics.SymmetricSourceConservationCertificate SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def cs (xs : List Coordinate) : Value := .array (xs.map (fun c => .text (coordinateName c)))
def sv (p : Slot) : Value := .array [.text (coordinateName p.1),.text (coordinateName p.2)]
def tv (p : Term) : Value := .array [cs p.1,sv p.2]
def commValue (c : Commutation) : Value := .object [("word_count",nv c.wordCount),("rows",.array (c.rows.map (fun row => .array [cs row.word,cs row.canonical,.boolean row.allOrdersCommute]))),("every_derivative_order_commutes",.boolean c.everyDerivativeOrderCommutes),("successor_proof",.text c.successorProof)]
def rowValue (row : DivergenceRow) : Value := .object [("direction",.text (coordinateName row.direction)),("carried_terms",nv row.carriedTerms),("opposed_terms",nv row.opposedTerms),("distinct_terms",nv row.distinctTerms),("balanced",.boolean row.balanced),("unmatched_terms",.array (row.unmatchedTerms.map tv))]
def certValue (c : Certificate) : Value := .object [("coordinates",cs c.coordinates),("symmetric_slots",.array (c.symmetricSlots.map sv)),("slot_count",nv c.slotCount),("source_ledger",.object (c.sourceLedger.map (fun p => (p.1,.array (p.2.map sv))))),("source_partition_counts",.array (c.sourcePartitionCounts.map nv)),("componentwise_bijection",.array (c.componentwiseBijection.map (fun p => .array [sv p.1,sv p.2]))),("divergence_rows",.array (c.divergenceRows.map rowValue)),("conserved_directions",cs c.conservedDirections),("all_four_balanced",.boolean c.allFourBalanced),("commutation",commValue c.commutation),("leaking_control_balanced",.boolean c.leakingControlBalanced),("leaking_control_has_one_missing_flow",.boolean c.leakingControlHasOneMissingFlow),("signed_numerical_scalar_used",.boolean c.signedNumericalScalarUsed),("depth_independent_identity",.text c.depthIndependentIdentity)]
#eval IO.println (render (certValue conservationCertificate))
''';p=w/'constants-recovery/SymmetricCertificate980.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(src.conservation_certificate()));assert actual==expected,[(k,actual[k],v) for k,v in expected.items() if actual[k]!=v]
mods=['SymmetricSourceConservation','SymmetricSourceConservationGeneral','SymmetricSourceConservationCertificate'];names=[];hashes={};audit=''.join('import SFT.Physics.'+m+'\n' for m in mods)
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';s=p.read_text();hashes[m]=hashlib.sha256(s.encode()).hexdigest();names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|abbrev) (\w+)',s,re.M)];(w/'constants-recovery/SFT/Physics'/p.name).write_text(s)
audit+=''.join('#print axioms '+n+'\n' for n in names);p=w/'symmetric980_certificate_audit.lean';p.write_text(audit);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);(w/'symmetric980_certificate_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in names)
(w/'symmetric980_certificate_report.json').write_text(json.dumps(dict(status='PASS',all14fields=True,derivative_words=64,four48by48ledgers=True,declarations=names,axioms=[],source_sha256=hashes),indent=2));print('PASS all14fields,64words,fourledgers;',len(names),'emptydeclarations')
