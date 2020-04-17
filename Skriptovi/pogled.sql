create or replace view pogled as select naz_izv izvodjac, naz_zon zona, naz_fes festival from izvodjac izv
    inner join dolazi dol on izv.sif_izv = dol.izv_sif_izv
    inner join zona z on z.sif_zon = dol.b_z_sif_zon
    inner join festival fes on fes.ozn_fes = z.rf_f_ozn_fes
    where z.naz_zon='Main Stage Zona' order by izvodjac;