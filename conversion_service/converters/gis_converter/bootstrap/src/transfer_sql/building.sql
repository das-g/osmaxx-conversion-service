-----------------
--  building_a --
-----------------
DROP TABLE if exists osmaxx.building_a; 
CREATE TABLE osmaxx.building_a (
	osm_id bigint, 
	lastchange timestamp without time zone, 
	geomtype char(1),
	geom geometry(MULTIPOLYGON,900913), 
	type text, 
	name text, 
	name_en text, 
	name_fr text, 
	name_es text, 
	name_de text,
	int_name text,
	label text,
	tags text,
	height float
);

INSERT INTO osmaxx.building_a
  SELECT osm_id as osm_id,
	osm_timestamp as lastchange , 
	CASE 
	 WHEN osm_id<0 THEN 'R' -- R=Relation
	 ELSE 'W' 		-- W=Way
	 END AS geomtype, 
	ST_Multi(way) AS geom,  
	building as type, 
	name as name,
	"name:en" as name_en, 
	"name:fr" as name_fr, 
	"name:es" as name_es, 
	"name:de" as name_de, 
	int_name as name_int, 
	transliterate(name) as label,
	cast(tags as text) as tags,
	cast(nullif(height,'') as float) as height
  FROM osm_polygon
  WHERE building is not null;

