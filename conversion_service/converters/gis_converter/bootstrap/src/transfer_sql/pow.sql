-----------------
----  pow_a ----
-----------------
DROP TABLE if exists osmaxx.pow_a; 
CREATE TABLE osmaxx.pow_a (
	osm_id bigint, 
	lastchange timestamp without time zone, 
	geomtype char(1),
	geom geometry(MULTIPOLYGON,900913),
	aggtype text,
	type text, 
	name text, 
	name_en text, 
	name_fr text, 
	name_es text, 
	name_de text,
	int_name text,
	label text,
	tags text,
	website text,
	wikipedia text,
	phone text,
	contact_phone text,
	opening_hours text,
	"access" text
);
INSERT INTO osmaxx.pow_a
  SELECT osm_id as osm_id,
	osm_timestamp as lastchange, 
	CASE 
	 WHEN osm_id<0 THEN 'R' -- Relation
	 ELSE 'W' 		-- Way
	 END AS geomtype, 
	ST_Multi(way) AS geom,  
-- Combining the different tags in Religion --
	case
	 when religion in ('buddhist','hindu','jewish','shinto','sikh','taoist','christian','muslim') then religion
	 else 'place_of_worship'
	end as aggtype,
	case 
	 when religion in ('buddhist','hindu','jewish','shinto','sikh','taoist') then religion
	 when religion='christian' then 
		case 
		 when denomination in ('anglican','baptist','catholic','evangelical','lutheran','methodist','orthodox','protestant','mormon','presbyterian') then denomination
		 else 'christian'
		end
	 when religion='muslim' then
		case 
		 when denomination in ('shia', 'sunni') then denomination
		 else 'muslim'
		end
	 else 'place_of_worship'
	end as type,
	name as name,
	"name:en" as name_en, 
	"name:fr" as name_fr, 
	"name:es" as name_es, 
	"name:de" as name_de, 
	int_name as name_int, 
	transliterate(name) as label,
	cast(tags as text) as tags,
	website as website,
	wikipedia as wikipedia,
	phone as phone,
	"contact:phone" as contact_phone,
	opening_hours as opening_hours,
	"access" as "access"
  FROM osm_polygon
  WHERE religion is not null or amenity='place_of_worship';

-----------------
----  pow_p ----
-----------------
DROP TABLE if exists osmaxx.pow_p; 
CREATE TABLE osmaxx.pow_p (
	osm_id bigint, 
	lastchange timestamp without time zone, 
	geomtype text,
	geom geometry(POINT,900913),
	aggtype text,
	type text, 
	name text, 
	name_en text, 
	name_fr text, 
	name_es text, 
	name_de text,
	int_name text,
	label text,
	tags text,
	website text,
	wikipedia text,
	phone text,
	contact_phone text,
	opening_hours text,
	"access" text
);
INSERT INTO osmaxx.pow_p
  SELECT osm_id as osm_id,
	osm_timestamp as lastchange, 
	'N' AS geomtype, 	-- Node
	way AS geom,
-- Combining the different tags in Religion --
	case
	 when religion in ('buddhist','hindu','jewish','shinto','sikh','taoist','christian','muslim') then religion
	 else 'place_of_worship'
	end as aggtype,
	case 
	 when religion in ('buddhist','hindu','jewish','shinto','sikh','taoist') then religion
	 when religion='christian' then 
		case 
		 when denomination in ('anglican','baptist','catholic','evangelical','lutheran','methodist','orthodox','protestant','mormon','presbyterian') then denomination
		 else 'christian'
		end
	 when religion='muslim' then
		case 
		 when denomination in ('shia', 'sunni') then denomination
		 else 'muslim'
		end
	 else 'place_of_worship'
	end as type,
	name as name,
	"name:en" as name_en, 
	"name:fr" as name_fr, 
	"name:es" as name_es, 
	"name:de" as name_de, 
	int_name as name_int, 
	transliterate(name) as label,
	cast(tags as text) as tags,
	website as website,
	wikipedia as wikipedia,
	phone as phone,
	"contact:phone" as contact_phone,
	opening_hours as opening_hours,
	"access" as "access"
  FROM osm_point
  WHERE religion is not null or amenity='place_of_worship'
UNION 
  SELECT osm_id as osm_id,
	osm_timestamp as lastchange, 
	CASE 
	 WHEN osm_id<0 THEN 'R' -- Relation
	 ELSE 'W' 		-- Way
	 END AS geomtype, 
	ST_Centroid(way) AS geom,  
-- Combining the different tags in Religion --
	case
	 when religion in ('buddhist','hindu','jewish','shinto','sikh','taoist','christian','muslim') then religion
	 else 'place_of_worship'
	end as aggtype,
	case 
	 when religion in ('buddhist','hindu','jewish','shinto','sikh','taoist') then religion
	 when religion='christian' then 
		case 
		 when denomination in ('anglican','baptist','catholic','evangelical','lutheran','methodist','orthodox','protestant','mormon','presbyterian') then denomination
		 else 'christian'
		end
	 when religion='muslim' then
		case 
		 when denomination in ('shia', 'sunni') then denomination
		 else 'muslim'
		end
	 else 'place_of_worship'
	end as type,
	name as name,
	"name:en" as name_en, 
	"name:fr" as name_fr, 
	"name:es" as name_es, 
	"name:de" as name_de, 
	int_name as name_int, 
	transliterate(name) as label,
	cast(tags as text) as tags,
	website as website,
	wikipedia as wikipedia,
	phone as phone,
	"contact:phone" as contact_phone,
	opening_hours as opening_hours,
	"access" as "access"
  FROM osm_polygon
  WHERE religion is not null or amenity='place_of_worship';
