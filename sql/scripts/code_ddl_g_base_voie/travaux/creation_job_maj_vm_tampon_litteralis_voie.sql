/*
Création du job JOB_MAJ_VM_TAMPON_LITTERALIS_VOIE rafraîchissant la VM VM_TAMPON_LITTERALIS_VOIE le dernier dimanche de chaque mois à 18h00.
*/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
   job_name          =>  'JOB_MAJ_VM_TAMPON_LITTERALIS_VOIE',
   job_type          =>  'PLSQL_BLOCK',
   job_action        =>  'DBMS_REFRESH.REFRESH(''"G_BASE_VOIE"."VM_TAMPON_LITTERALIS_VOIE"'');', 
   start_date        =>  '25/06/23 18:00:00 EUROPE/PARIS',
   repeat_interval   =>  'FREQ=MONTHLY; INTERVAL=1; BYDAY=SUN',
   comments          =>  'Ce job rafraîchit la VM G_BASE_VOIE.VM_TAMPON_LITTERALIS_VOIE le dernier dimanche de chaque mois à 18h00.');
END;
/

BEGIN
 DBMS_SCHEDULER.ENABLE ('JOB_MAJ_VM_TAMPON_LITTERALIS_VOIE');
END;

/

