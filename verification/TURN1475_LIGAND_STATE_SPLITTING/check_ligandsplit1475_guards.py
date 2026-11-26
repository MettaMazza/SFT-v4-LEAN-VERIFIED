exec(open('work/check_ligandsplit1475_core.py').read().split('expected=')[0])
s=m.forced_ligand_state_splitting(m.six_direct_axis_geometry());r=m.removed_ligand_remerging(s.central_identity);first=m.generate_complete_rank_two_support()[0]
from dataclasses import replace
cases=[lambda:m.ExactSplitLevel(m.EmptyOne(),()),lambda:m.ExactSplitLevel(m.EmptyOne(),(first,first)),lambda:replace(s,levels=(),adjacent_positive_separations=(),lower_distance_from_unsplit_or_absence=m.EmptyOne(),upper_distance_from_unsplit_or_absence=m.EmptyOne()),lambda:replace(s,unperturbed_positive_multiplicity=m.PositiveCount(4)),lambda:replace(s,adjacent_positive_separations=()),lambda:replace(s,lower_distance_from_unsplit_or_absence=m.EmptyOne()),lambda:replace(s,lower_distance_from_unsplit_or_absence=m.ExactPart.from_pair(1,2),upper_distance_from_unsplit_or_absence=m.ExactPart.from_pair(1,2)),lambda:replace(r,lower_distance_from_unsplit_or_absence=m.ExactPart.from_pair(1,2)),lambda:replace(s,complete_member_preservation=False)]
expected=[]
for case in cases:
 try:case();expected.append(dict(ok=True))
 except Exception as e:expected.append(dict(error=str(e)))
(w/'ligandsplit1475_guard_expected.json').write_text(json.dumps(expected,indent=2)+'\n');actual=json.loads((w/'ligandsplit1475_guard_output.json').read_text());assert actual==expected
(w/'ligandsplit1475_guard_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),all_original_errors_and_successes_match=True,source_sha256={'SFT/Chemistry/LigandStateSplitting.lean':hashlib.sha256((w/'turn1064_recovery/SFT/Chemistry/LigandStateSplitting.lean').read_bytes()).hexdigest()}),indent=2)+'\n');print('PASS9 exact constructor cases')
