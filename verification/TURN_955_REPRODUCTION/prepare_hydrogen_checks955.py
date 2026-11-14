from pathlib import Path
w=Path('work')
def change(s):
 return s.replace('MolecularSpectroscopy','HydrogenRydberg').replace('molecularspectroscopy','hydrogenrydberg').replace('molecular_spectroscopy_successor','hydrogen_rydberg_successor').replace('MOLECULAR_SPECTROSCOPY_SPEC','HYDROGEN_RYDBERG_SPEC').replace('MOLECULAR_EMPIRICAL_SPEC','HYDROGEN_RYDBERG_EMPIRICAL_SPEC').replace('SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005','SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005').replace('954','955').replace("'HydrogenRydberg','MolecularLadders'","'HydrogenRydberg'")
for name in ['check_molecularspectroscopy_entry954.py','check_molecularspectroscopy_original954.py','check_molecularspectroscopy_empirical_original954.py','check_molecularspectroscopy_program954.py','check_molecularspectroscopy_independent954.py','prepare_molecularspectroscopy_native954.py','audit_molecularspectroscopy954_all.py','finish_molecularspectroscopy954_checks.py']:
 (w/change(name)).write_text(change((w/name).read_text()))
p=w/'constants-recovery/MolecularSpectroscopyProgram954.lean';(p.parent/change(p.name)).write_text(change(p.read_text()))
# Use the established fresh empirical-spec comparator, which matches the source's separate 256-form empirical spec.
s=change((w/'check_molecularspectroscopyempirical_program954.py').read_text());(w/'check_hydrogenrydbergempirical_program955.py').write_text(s)
