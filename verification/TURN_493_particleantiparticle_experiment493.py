exec(open('work/particleantiparticle_spec493.py').read())
s=(r/'SFT/Physics/LeptonExperiment.lean').read_text().replace('import SFT.Physics.LeptonPrediction','import SFT.Physics.ObservationPrediction\nimport «work».ParticleAntiparticleEvidence493').replace('SFT.Physics.LeptonExperiment','SFT.Physics.ParticleAntiparticleExperiment').replace('open SFT.Host SFT.Host.Canonical LeptonPrediction','open SFT.Host SFT.Host.Canonical\nabbrev Held := CapabilityValues.Value\ndef heldValue := CapabilityValues.canonical\ndef nonblank := CapabilityValues.nonblank')
# Verify the existing helper namespace rather than assume it below.
a=s.index('structure TargetRow');b=s.index('def registration :',a)
s=s[:a]+'''abbrev TargetRow := ObservationCarrier.ExternalTargetRow
'''+''.join('def '+name+' : String := '+q(values[key])+'\n' for name,key in [('claimId','claim_id'),('experimentId','experiment_id'),('expectedLabel','expected_observation_label'),('frozenRelation','exact_result'),('sourcePath','source_snapshot_path'),('snapshotHash','source_snapshot_hash'),('falsification','falsification_condition')])+'''def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
'''+ 'def targetRows : List TargetRow := ['+','.join('⟨'+','.join(q(row[k]) for k in ['target_id','source_id','source_locator','observed_label'])+'⟩' for row in values['target_rows'])+']\n\n'+s[b:]
a=s.index('def specDependencies');b=s.index('def specDimensions',a);s=s[:a]+'def specDependencies : List String := ['+','.join(q(x) for x in values['dependencies'])+']\n\n'+s[b:]
a=s.index('def specWitnesses');b=s.index('def validateSpec',a);s=s[:a]+'''def specWitnesses : Except String Bool := .ok (ParticleAntiparticleEvidence.onePairWitness && ParticleAntiparticleEvidence.successorWitness)

'''+s[b:]
a=s.index('theorem registeredSpecValid');b=s.index('\nend ',a);s=s[:a]+'''theorem registeredSpecValid : validateSpec = .ok () := by decide
'''+s[b:]
s=s.replace('(.label "sealed-derivation" derivationSeal)', '(.label ⟨"sealed-derivation",derivationSeal⟩)').replace('.label "external-observation" row.observedLabel','.label ⟨"external-observation",row.observedLabel⟩')
s=s.replace('TargetRow.observedLabel','ObservationCarrier.ExternalTargetRow.observedLabel').replace('TargetRow.targetId','ObservationCarrier.ExternalTargetRow.targetId')
s=s.replace('abbrev Held := CapabilityValues.Value\ndef heldValue := CapabilityValues.canonical\n','def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]\n')
s=s.replace('heldValue (.label ⟨"sealed-derivation",derivationSeal⟩)','labelValue "sealed-derivation" derivationSeal').replace('List (String × Held)','List (String × Value)').replace('.label ⟨"external-observation",row.observedLabel⟩','labelValue "external-observation" row.observedLabel').replace('(targets.map fun (name,value) => (name,heldValue value))','targets').replace('validateSpec = .ok () := by decide','validateSpec = .ok () := rfl')
Path('work/ParticleAntiparticleExperiment493.lean').write_text(s)
