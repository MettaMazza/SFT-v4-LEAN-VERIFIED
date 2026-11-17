from pathlib import Path
r=Path('work/turn1064_recovery/SFT/Chemistry');s=(r/'NuclearElectronicValidation.lean').read_text().replace('import SFT.Chemistry.NuclearElectronicExperiment','import SFT.Chemistry.ResolvedRovibronicExperiment\nimport SFT.Chemistry.ResolvedRovibronicAnalysis').replace('namespace SFT.Chemistry.NuclearElectronicValidation','namespace SFT.Chemistry.ResolvedRovibronicValidation').replace('end SFT.Chemistry.NuclearElectronicValidation','end SFT.Chemistry.ResolvedRovibronicValidation').replace('SFT.Physics NuclearElectronicExperiment','SFT.Physics ResolvedRovibronicExperiment').replace('complete-NIST-H2-HD-D2-comparator/1','complete-resolved-H2-HD-D2-comparator/1').replace('external-nuclear-electronic-row','external-resolved-spectrum-row').replace('ELEC-012 prediction package differs','ELEC-013 prediction package differs')
a=s.index('def measurement');b=s.index('structure Validation',a);s=s[:a]+'''def measurement (row : Value) : Except String String := do
 return Text.intercalate "" [← rowText row "target_id",": multiplicity ",← rowText row "multiplicity",
  "; vibration ",← rowText row "vibration","; rotation ",← rowText row "rotation",
  "; band ",← rowText row "band","; pass ",boolText (rowPassed row)]
'''+s[b:]
a=s.index(' let comparisons ←');b=s.index(' let targetIdentity',a);s=s[:a]+''' let comparisons ← rows.mapM fun row => ResolvedRovibronicAnalysis.rowComparison row released
 let counts ← ResolvedRovibronicAnalysis.counts rows
 let expected : List (String × Nat) := [("rows",95),("cells",1235),("singlet",54),("triplet",41),
  ("positive_vibration",78),("positive_rotation",60),("joint_vibration_rotation",56),
  ("transition_designation",92),("positive_band_origin",83),("source_zero_electronic_origin",3),
  ("absent_electronic_origin",3),("held_signed_inscriptions",8)]
 let countsExact := counts.length==expected.length && (counts.zip expected).all (fun ((a,n),(b,m)) => Text.equal a b && n==m)
 let ms ← comparisons.mapM fun row => rowText row "multiplicity"
 let distinct := ms.foldl (fun acc m => if acc.any (Text.equal · m) then acc else acc++[m]) ([] : List String)
 let signed := counts.any fun (k,n) => Text.equal k "held_signed_inscriptions" && n==8
 let adverse : List (String × Bool) := [("exact_counts",countsExact),("all_rows",comparisons.all rowPassed),
  ("omission_rejected",(rows.take (rows.length-1)).length != 95),
  ("multiplicity_erasure_rejected",distinct.length==2),("signed_values_held",signed)]
 let passed := adverse.all Prod.snd
'''+s[b:]
a=s.index(' let payload : Value',s.index('def validate '));b=s.index(' return ⟨.object',a);s=s[:a]+''' let payload : Value := .object [("comparisons",.array comparisons),
  ("counts",.object (counts.map fun (k,n) => (k,.integer (.ofNat n)))),
  ("adverse",.object (adverse.map fun (k,b) => (k,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← comparisons.mapM measurement
 let messages := rowMessages ++ counts.map (fun (key,n) => Text.intercalate "" ["count ",key,": ",toString n])
'''+s[b:];s=s.replace('NIST-CHEMISTRY-WEBBOOK-SRD69-H2-HD-D2-DIATOMIC-CONSTANTS-2026','NIST-CHEMISTRY-WEBBOOK-SRD69-H2-HD-D2-RESOLVED-DIATOMIC-SURFACE-2026');(r/'ResolvedRovibronicValidation.lean').write_text(s)
