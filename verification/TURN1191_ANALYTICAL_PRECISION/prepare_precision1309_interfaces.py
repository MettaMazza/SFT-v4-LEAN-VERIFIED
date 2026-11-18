from pathlib import Path
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
s=(w/'generate_accuracy1162.py').read_text().replace('accuracy','precision').replace('AnalyticalAccuracy','AnalyticalPrecision').replace('1162','1309').replace('ACCURACY_SPEC','PRECISION_SPEC').replace("['referenceWitness','measurandWitness','supportWitness','comparisonWitness','truenessWitness','uncertaintyWitness','boundaryWitness','successorWitness']","['identityWitness','conditionsWitness','supportWitness','comparisonWitness','spreadWitness','classWitness','adverseWitness','successorWitness']").replace('{survivor with reference := .rejected}','{survivor with identity := .rejected}')
s=s.replace("repr([d.key for d in spec.dimensions])", "repr(['classAxis' if d.key=='class' else d.key for d in spec.dimensions])")
s=s.replace(".replace('ConjugatedSupport','AnalyticalPrecision')", ".replace('ConjugatedSupport','AnalyticalPrecision').replace('types=[f.capitalize()for f in fields]',\"types=['Class' if f=='classAxis' else f.capitalize()for f in fields]\")")
s=s.replace('Generated exact256-form nuclide-carrier grammar and observational programme, using8 existing proved witnesses.','Staged the original256-form precision grammar,observational programme and8source witnesses; native verification is pending.')
(w/'generate_precision1309.py').write_text(s);exec(s,{})
p=r/'AnalyticalPrecisionEvidence.lean';p.write_text(p.read_text().replace('.boolean AnalyticalPrecision.successorWitness','.boolean (AnalyticalPrecision.successorWitness.toOption.getD false)'))
s=(w/'generate_accuracy1162_experiment.py').read_text().replace('accuracy','precision').replace('AnalyticalAccuracy','AnalyticalPrecision').replace('1162','1309').replace('ACCURACY_SPEC','PRECISION_SPEC')
for a,b in [('referenceWitness','identityWitness'),('measurandWitness','conditionsWitness'),('truenessWitness','spreadWitness'),('uncertaintyWitness','classWitness'),('boundaryWitness','adverseWitness')]:s=s.replace(a,b)
s=s.replace('AnalyticalPrecision.successorWitness].all','(AnalyticalPrecision.successorWitness.toOption.getD false)].all')
(w/'generate_precision1309_experiment.py').write_text(s);exec(s,{})
s=(r/'AnalyticalAccuracyValidation.lean').read_text().replace('AnalyticalAccuracy','AnalyticalPrecision').replace('exactAccuracyAnalysis','exactPrecisionAnalysis');(r/'AnalyticalPrecisionValidation.lean').write_text(s)
print('Precision grammar,evidence,experiment and full validator composition staged with original8targets')
