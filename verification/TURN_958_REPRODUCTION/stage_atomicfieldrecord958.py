from pathlib import Path
w=Path('work');s=(w/'stage_atomictransitionrecord957.py').read_text().replace('AtomicTransitionRate','AtomicFieldSplitting').replace('atomictransitionrate957','atomicfieldsplitting958').replace('atomic_transition_rate_successor','atomic_field_splitting_successor').replace('atomic transition-rate','atomic field-splitting')
s=s.replace("row=record['sources']['nist_atomic_spectroscopy'];stage(row['snapshot_path']);",'')
s=s.replace("\\ndef componentHash : String := {q(src.NIST_ATSPEC_HASH)}",'')
s=s.replace('["nist_atomic_spectroscopy","nist_argon_metastable","nist_aluminium_clock"]','["nist_zeeman","nbs_hydrogen_linear_stark","nist_cesium_quadratic_stark"]')
a=s.index(' let atspec ←');b=s.index(' pure record\n',a);s=s[:a]+s[b:]
a=s.index("s+='def componentFiles");b=s.index("s+='def registeredRecord",a);s=s[:a]+"s+='def componentFiles : List (String × String) := []\\n'\n"+s[b:]
s=s[:s.index("print(json.dumps")]
(w/'stage_atomicfieldrecord958_generated.py').write_text(s);exec(compile(s,'original-field-record','exec'),{})
