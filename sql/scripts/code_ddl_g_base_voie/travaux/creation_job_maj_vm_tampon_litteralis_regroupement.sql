/*
Création du job JOB_MAJ_VM_TAMPON_LITTERALIS_REGROUPEMENT rafraîchissant la VM VM_TAMPON_LITTERALIS_REGROUPEMENT le premier dimanche du mois à 17h00.
*/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
   job_name          =>  'JOB_MAJ_VM_TAMPON_LITTERALIS_REGROUPEMENT',
   job_type          =>  'PLSQL_BLOCK',
   job_action        =>  'DBMS_REFRESH.REFRESH(''"G_BASE_VOIE"."VM_TAMPON_LITTERALIS_REGROUPEMENT"'');', 
   start_date        =>  '02/09/23 17:00:00 EUROPE/PARIS',
   repeat_interval   =>  'FREQ=MONTHLY; INTERVAL=1; BYDAY=SAT',
   comments          =>  'Ce job rafraîchit la VM G_BASE_VOIE.VM_TAMPON_LITTERALIS_REGROUPEMENT le premier dimanche du mois à 17h00.');
END;
/

BEGIN
 DBMS_SCHEDULER.ENABLE ('JOB_MAJ_VM_TAMPON_LITTERALIS_REGROUPEMENT');
END;

/

