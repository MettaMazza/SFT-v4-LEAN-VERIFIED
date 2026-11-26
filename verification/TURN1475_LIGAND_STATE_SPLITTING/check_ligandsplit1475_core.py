from pathlib import Path
import sys,importlib.util,json,dataclasses,hashlib,re
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
p=w/'pinned_ligandsplit1474/sft/chemistry/ligand_state_splitting_law_v1.py';spec=importlib.util.spec_from_file_location('ligandsplit_original1474',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return dict(family=x.family,label=x.label)
 if isinstance(x,m.PositiveCount):return x.value
 if isinstance(x,m.ExactPart):return [x.value.numerator,x.value.denominator]
 if isinstance(x,m.EmptyOne):return dict(empty=x.identity)
 if dataclasses.is_dataclass(x):return {f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(list,tuple)):return [enc(v)for v in x]
 return x
expected=[dict(ok=enc(x))for x in [m.forced_ligand_state_splitting(m.six_direct_axis_geometry()),m.forced_ligand_state_splitting(m.four_complete_axis_geometry()),m.removed_ligand_remerging(m.HeldLabel('coordination-central-occurrence','removed-ligand-centre'))]]
(w/'ligandsplit1475_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
actual=json.loads((w/'ligandsplit1475_core_output.json').read_text());assert actual==expected
s=(w/'ligandsplit1475_core_audit.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",s);assert len(names)==27,(len(names),s);assert 'depends on axioms:'not in s and 'error:'not in s
rel='SFT/Chemistry/LigandStateSplitting.lean';report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',cases=3,all_returned_fields_match=True,declarations=names,axiom_dependencies=[],source_sha256={rel:hashlib.sha256((w/'turn1064_recovery'/rel).read_bytes()).hexdigest()},scope='Initial support/incidence/partition core and two original multiplicity proofs; remaining constructor invariants,source induction,full original grammar/controls and validator are not registered complete.')
(w/'ligandsplit1475_core_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(names),'empty-axiom declarations and3 complete original records')
