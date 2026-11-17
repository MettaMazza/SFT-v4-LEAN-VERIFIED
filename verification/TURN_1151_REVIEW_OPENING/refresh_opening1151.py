from pathlib import Path
import re,json,hashlib,fcntl
lock=open('work/entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
r=Path('work/turn1064_recovery');p=r/'ZENODO_PAPER_DRAFT.txt';before=p.read_text();s=before;pin='724fe652112d5d639a34757fce10f40a1293baa9'
old='This 500-entry edition retains the completed Unified Constants object and its seven-sector assembly and extends the cumulative exposition through chemistry and materials.'
new='This working edition toward 750 entries retains the completed Unified Constants object and its seven-sector assembly. The additions since the published 500-entry edition extend the physics, chemistry, materials and biological-organization derivations, together with their original empirical comparisons.'
assert s.count(old)==1;s=s.replace(old,new)
s=s.replace('Following this 500-entry edition, expanded editions are planned at every further 250 completed entries, with a final edition at all 2,781 entries.','The next review checkpoint is 750 completed entries, followed by 1,000 and every further 250 completed entries, with a final edition at all 2,781 entries.')
marker='The full scientific exposition follows in the same manuscript.'
featured='Featured additions: the generated Dirac square and three-space Maxwell construction are developed in Sections 758 and 764; the Majorana discriminator and its original empirical status are developed in Sections 795 and 801. The later physics exposition includes the Higgs comparison (Section 973), gravitational-wave chirp and remnant vector (Section 982), and the Physics Grand Lock dependency and eleven-field assembly with its original empirical controls (Sections 983 and 989–990). The chemical derivations continue through state order, isotope exchange and coordination; the biological exposition reaches retained repair organization and maintenance (Section 1091). Each result retains its own derivation, native proof, source and timeline references in the corresponding section.\n\n'
assert s.count(marker)==1;s=s.replace(marker,featured+marker)
s=s.replace('The immutable scientific code checkpoint for this 500-entry edition is 43a7295f5d39a1df4ca25b2c1e9b8a21164d55ee','The immutable scientific code checkpoint for this working edition is '+pin)
s=s.replace('/blob/43a7295f5d39a1df4ca25b2c1e9b8a21164d55ee/COVERAGE.json','/blob/'+pin+'/COVERAGE.json').replace('Verified Lean checkpoint: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/43a7295f5d39a1df4ca25b2c1e9b8a21164d55ee','Verified Lean checkpoint: https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/'+pin)
s=s.replace('completed entries across the foundations, mathematics, information science, computation, physics, chemistry and materials.','completed entries across the foundations, mathematics, information science, computation, physics, chemistry, materials and biology.')
math=lambda t:re.findall(r'\\\[[\s\S]*?\\\]|\\\([\s\S]*?\\\)',t)
assert math(before)==math(s)
p.write_text(s);report=dict(status='PASS',scope='Opening overview and current-edition pointers; historical proof pins retained',mathematical_expressions_unchanged=len(math(s)),checkpoint=pin,before_sha256=hashlib.sha256(before.encode()).hexdigest(),after_sha256=hashlib.sha256(s.encode()).hexdigest())
Path('work/publication1151_opening_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
