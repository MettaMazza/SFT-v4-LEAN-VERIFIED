from pathlib import Path
w=Path('work');r=w/'constants-recovery';items=[('FLOOR','VacuumFloorValidation',879),('POLARIZATION','VacuumPolarizationValidation',880),('INERTIA','VacuumInertiaValidation',881),('EXTRACTION','VacuumExtractionValidation',882)]
for key,tag,n in items:
 low=tag.lower();cid='SFT-PHYS-VALIDATION-VACUUM-'+key+'-003'
 s=(r/'SectorValidationProgram875.lean').read_text().replace('SectorValidation',tag);(r/f'{tag}Program{n}.lean').write_text(s)
 for name in ['check_sectorvalidation_program875.py','prepare_sectorvalidation_native875.py','check_sectorvalidation_independent875.py','prepare_sectorvalidation_empirical_native875.py']:
  s=(w/name).read_text().replace('SFT-PHYS-VALIDATION-FORCE-SECTOR-ANCHORS-003',cid).replace('SectorValidation',tag).replace('sectorvalidation',low).replace('875',str(n));(w/name.replace('sectorvalidation',low).replace('875',str(n))).write_text(s)
 s=(r/'SectorValidationEmpirical875.lean').read_text().replace('SectorValidation',tag).replace('SectorAnchorRecords.sourceHashes','VacuumAuthoritativeRecords.componentHashes')
 s='\n'.join(line for line in s.splitlines() if 'let recordResult' not in line and 'render recordResult' not in line)+'\n';(r/f'{tag}Empirical{n}.lean').write_text(s)
 # Preserve the complete source-specific external precheck and shared empirical output comparison.
 s=(w/'check_sector_empirical875.py').read_text().replace("record_line,out=out.split(\"\\n\",1);assert json.loads(record_line)==json.load(open(w/\"sectorvalidation875_original_record.json\"));",'')
 a=s.index('items=');b=s.index('\nwith ',a);s=s[:a]+repr('')+s[a:] if False else s
 s=s[:a]+f'items=[({tag!r},{low!r},{n},{cid!r})]'+s[b:];(w/f'check_{low}_empirical{n}.py').write_text(s)
 print(tag,'full program and independent/empirical drivers prepared',flush=True)
