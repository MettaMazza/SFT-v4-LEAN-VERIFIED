from pathlib import Path
w=Path('work')
for low,cap,core,index,bound in [('element','Element','ElementIdentity',0,'ELEMENT'),('atomicnumber','AtomicNumber','AtomicNumberOrder',1,'ATOMIC_NUMBER')]:
 for name in ['amount_spec557','prepare_amount557','prepare_amount_experiment557','build_amount557','build_amount_protocol557','audit_amount557','run_amount557']:
  s=(w/(name+'.py')).read_text().replace('amount',low).replace('Amount',cap).replace('AMOUNT',bound).replace('557','560').replace(cap+'Count',core)
  if name=='amount_spec557':s=s.replace('measurement_identity_batch_2','elements_periodicity_batch_1').replace('MEASUREMENT_IDENTITY_BATCH_2_SPECS','ELEMENTS_PERIODICITY_BATCH_1_SPECS').replace('_common_exclusions','_exclusions').replace('n.value.elts[:1]',f'n.value.elts[{index}:{index+1}]')
  if name=='run_amount557':s=s.replace('SFT-CHEM-MEAS-'+bound+'-001','SFT-CHEM-ELEM-'+('ELEMENT' if index==0 else 'ATOMIC-NUMBER')+'-001');s=s.replace("'SubstanceIdentity','"+core+"'", "'SubstanceIdentity','AmountCount',"+("'ElementIdentity'," if index==1 else '')+repr(core))
  (w/(name.replace('amount',low).replace('557','560')+'.py')).write_text(s)
s=(w/'check_chemistry_independent559.py').read_text().replace('559','560');(w/'check_chemistry_independent560.py').write_text(s)
