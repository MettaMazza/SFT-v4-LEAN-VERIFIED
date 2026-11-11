from pathlib import Path
import subprocess
w=Path('work');r=w/'constants-recovery';ns={};exec((w/'smithium_spec655.py').read_text(),ns);values=ns['values'];q=ns['q']
for part in ['grammar','evidence']:
 s=(w/('unit_'+part+'480.py')).read_text().replace('unit','smithium').replace('Unit','Smithium').replace('480','655');(w/('smithium_'+part+'655.py')).write_text(s);subprocess.run(['python3',str(w/('smithium_'+part+'655.py'))],check=True)
 s=(w/('Smithium'+part.capitalize()+'655.lean')).read_text().replace('import «work».SmithiumCarrier655','import SFT.Chemistry.Smithium\nimport SFT.Chemistry.GBlockEvidence\nimport SFT.Host.Text\nimport SFT.Foundation.CommonRefinement').replace('import «work».SmithiumGrammar655','import SFT.Chemistry.SmithiumGrammar').replace('SFT.Physics.Smithium','SFT.Chemistry.Smithium')
 if part=='evidence':
  a=s.index('def onePairWitness');b=s.index('def claimId',a)
  ws=['match Smithium.smithiumRecord with | .error _ => false | .ok r => (r.proton == 126) && (r.neutron == 184) && (r.mass == 310)','match Smithium.smithiumRecord with | .error _ => false | .ok r => GBlockEvidence.natListEqual (r.configuration.map (fun t => t.1)) [8,5] && GBlockEvidence.natListEqual (r.configuration.map (fun t => t.2.1)) [1,5] && GBlockEvidence.natListEqual (r.configuration.map (fun t => t.2.2)) [2,6]','match Smithium.smithiumRecord with | .error _ => false | .ok r => (r.valence == 8) && GBlockEvidence.natListEqual r.predictedPositiveOxidationCounts [2,3,4,5,6,7,8]']
  s=s[:a]+''.join('def witness'+str(i)+' : Bool := '+v+'\ntheorem witness'+str(i)+'Passed : witness'+str(i)+' = true := rfl\n' for i,v in enumerate(ws))+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean witness'+str(i)+']' for i,x in enumerate(values['operational_witnesses']))+']\n'+s[b:]
  s=s.replace('branch := "physics"','branch := "chemistry"')
 s=s.replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000')
 (r/'SFT/Chemistry'/('Smithium'+part.capitalize()+'.lean')).write_text(s)
