from pathlib import Path
import sys,importlib.util,json,dataclasses,hashlib,re
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));p=w/'pinned_complexspin1476/sft/chemistry/complex_spin_state_order_law_v1.py';spec=importlib.util.spec_from_file_location('complexspin_original1476',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
def enc(x):
 if isinstance(x,m.HeldLabel):return dict(family=x.family,label=x.label)
 if isinstance(x,m.PositiveCount):return x.value
 if isinstance(x,m.EmptyOne):return dict(empty=x.identity)
 if dataclasses.is_dataclass(x):
  row={f.name:enc(getattr(x,f.name))for f in dataclasses.fields(x)}
  if isinstance(x,m.SpinOccupancySignature):row.update({k:enc(getattr(x,k))for k in ['pair_closure_count','unmatched_fibre_count','split_crossing_count','spin_width']})
  return row
 if isinstance(x,(list,tuple)):return [enc(v)for v in x]
 return x
expected=[]
def add(fn):
 try:expected.append(dict(ok=enc(fn())))
 except Exception as e:expected.append(dict(error=str(e)))
for n in range(1,12):
 add(lambda n=n:m.enumerate_complete_spin_signatures(m.PositiveCount(n)))
 add(lambda n=n:m.forced_low_spin_state(m.enumerate_complete_spin_signatures(m.PositiveCount(n))))
 add(lambda n=n:m.forced_high_spin_state(m.enumerate_complete_spin_signatures(m.PositiveCount(n))))
add(m.forced_six_electron_order_vector)
for n in range(5):add(lambda n=n:tuple(m.counted_state_path_cost(s,m._exact_count(n))for s in m.enumerate_complete_spin_signatures(m.PositiveCount(6))))
(w/'complexspin1476_core_expected.json').write_text(json.dumps(expected,indent=2)+'\n');actual=json.loads((w/'complexspin1476_core_output.json').read_text());assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e][:1]
s=(w/'complexspin1476_core_audit.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",s);assert len(names)==32 and 'depends on axioms:'not in s and 'error:'not in s
rel='SFT/Chemistry/ComplexSpinState.lean';report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',cases=len(expected),all_fields_match=True,declarations=names,axiom_dependencies=[],source_sha256={rel:hashlib.sha256((w/'turn1064_recovery'/rel).read_bytes()).hexdigest()},scope='Core complete occupancy census,extrema,path costs and order outputs with two kernel source-result proofs;full entry not yet registered.')
(w/'complexspin1476_core_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(expected),'complete original comparisons and32empty-axiom declarations')
