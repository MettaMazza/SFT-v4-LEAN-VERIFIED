from pathlib import Path
w=Path('work')
for low,cap,core,index in [('uncertainty','Uncertainty','UncertaintyRecord',3),('traceability','Traceability','TraceabilityChain',4)]:
 for name in ['amount_spec557','prepare_amount557','prepare_amount_experiment557','build_amount557','build_amount_protocol557','audit_amount557','run_amount557']:
  s=(w/(name+'.py')).read_text().replace('amount',low).replace('Amount',cap).replace('AMOUNT',cap.upper()).replace('557','559').replace(cap+'Count',core)
  if name=='amount_spec557':s=s.replace('n.value.elts[:1]',f'n.value.elts[{index}:{index+1}]')
  if name=='run_amount557':s=s.replace("'SubstanceIdentity','"+core+"'", "'SubstanceIdentity','AmountCount',"+("'UncertaintyRecord'," if index==4 else '')+repr(core))
  (w/(name.replace('amount',low).replace('557','559')+'.py')).write_text(s)
s=(w/'check_chemistry_independent558.py').read_text().replace('558','559');(w/'check_chemistry_independent559.py').write_text(s)
