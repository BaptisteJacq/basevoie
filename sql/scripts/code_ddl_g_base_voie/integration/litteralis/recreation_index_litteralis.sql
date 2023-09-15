/*
Recréation des index des tables nécessaires au projet LITTERALIS
*/
SET SERVEROUTPUT ON
DECLARE

BEGIN
	EXECUTE IMMEDIATE'CREATE INDEX TA_SECTEUR_VOIRIE_SIDX ON G_BASE_VOIE.TA_SECTEUR_VOIRIE(GEOM) INDEXTYPE IS MDSYS.SPATIAL_INDEX PARAMETERS(''sdo_indx_dims=2, layer_gtype=MULTIPOLYGON, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';
END;