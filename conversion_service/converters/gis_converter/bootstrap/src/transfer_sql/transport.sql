-----------------
-- transport_a --
-----------------
DROP TABLE if exists osmaxx.transport_a; 
CREATE TABLE osmaxx.transport_a(
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
	tags text
);
INSERT INTO osmaxx.transport_a
  SELECT osm_id as osm_id,
	osm_timestamp as lastchange, 
	CASE 
	 WHEN osm_id<0 THEN 'R' -- Relation
	 ELSE 'W' 		-- Way
	 END AS geomtype, 
	ST_Multi(way) AS geom,  
-- Combining Tags for different kinds of Transport POIs --
	case
	 when railway='station'  or railway='halt' or (public_transport='stop_position' and train='yes') then 'railway'
	 when railway='tram_stop' or (public_transport='stop_position' and tram='yes') then 'tram'
	 when highway='bus_stop' or (public_transport='stop_position' and bus='yes') or  amenity='bus_station' then 'bus'
	 when amenity='taxi' then 'taxi'
	 when amenity='airport' or aeroway in ('aerodrome','runway','helipad','taxiway','apron')  then 'air_traffic'
	 when amenity='ferry_terminal' then 'water_traffic'
	 when aerialway='station' then 'other_traffic'
	 when public_transport is not null then 'public_transport'
	 when aeroway is not null then 'aeroway'
	 when aerialway is not null then 'aerialway'
	end as aggtype,
	case
	 when railway='station' then 'railway_station'
	 when railway='halt' or (public_transport='stop_position' and train='yes') then 'railway_halt'
	 when railway='tram_stop' or (public_transport='stop_position' and tram='yes') then 'tram_stop'
	 when highway='bus_stop' or (public_transport='stop_position' and bus='yes')  then 'bus_stop'
	 when amenity='bus_station' or public_transport='station' then amenity
	 when amenity='taxi' then 'taxi_stand'
	 when amenity='airport' or aeroway='aerodrome' then 'airport'
	 when aeroway in  ('runway','helipad','taxiway','apron') then aeroway
	 when amenity='ferry_terminal' then 'ferry_terminal'
	 when aerialway='station' then 'aerialway_station'
	 when public_transport is not null then public_transport 
	 when aeroway is not null then 'aeroway'
	 when aerialway is not null then 'aerialway'
	 else 'others'
	end as type,

	name as name,
	"name:en" as name_en, 
	"name:fr" as name_fr, 
	"name:es" as name_es, 
	"name:de" as name_de, 
	int_name as name_int, 
	transliterate(name) as label,
	cast(tags as text) as tags
  FROM osm_polygon
  WHERE railway in ('station', 'halt','tram_stop') 
	or highway='bus_stop' 
	or amenity in ('bus_stop','taxi','airport','ferry_terminal') 
	or aeroway is not null 
	or aerialway is not null 
	or public_transport in ('stop_position', 'station','platform');

-----------------
-- transport_p --
-----------------
DROP TABLE if exists osmaxx.transport_p; 
CREATE TABLE osmaxx.transport_p(
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
	tags text
);
INSERT INTO osmaxx.transport_p
  SELECT osm_id as osm_id,
	osm_timestamp as lastchange, 
	'N' AS geomtype, 	-- Node
	way AS geom,
-- Combining Tags for different kinds of Transport POIs --
	case
	 when railway='station'  or railway='halt' or (public_transport='stop_position' and train='yes') then 'railway'
	 when railway='tram_stop' or (public_transport='stop_position' and tram='yes') then 'tram'
	 when highway='bus_stop' or (public_transport='stop_position' and bus='yes') or  amenity='bus_station' or public_transport='station' then 'bus'
	 when amenity='taxi' then 'taxi'
	 when amenity='airport' or aeroway in ('aerodrome','runway','helipad','taxiway','apron')  then 'air_traffic'
	 when amenity='ferry_terminal' then 'water_traffic'
	 when aerialway='station' then 'other_traffic'
	 when public_transport is not null then 'public_transport'
	 when aeroway is not null then 'aeroway'
	 when aerialway is not null then 'aerialway'
	end as aggtype,
	case
	 when railway='station' then 'railway_station'
	 when railway='halt' or (public_transport='stop_position' and train='yes') then 'railway_halt'
	 when railway='tram_stop' or (public_transport='stop_position' and tram='yes') then 'tram_stop'
	 when highway='bus_stop' or (public_transport='stop_position' and bus='yes')  then 'bus_stop'
	 when amenity='bus_station' or public_transport='station' then amenity
	 when amenity='taxi' then 'taxi_stand'
	 when amenity='airport' or aeroway='aerodrome' then 'airport'
	 when aeroway in  ('runway','helipad','taxiway','apron') then aeroway
	 when amenity='ferry_terminal' then 'ferry_terminal'
	 when aerialway='station' then 'aerialway_station'
	 when public_transport is not null then public_transport
	 when aeroway is not null then 'aeroway'
	 when aerialway is not null then 'aerialway'
	 else 'others'
	end as type,

	name as name,
	"name:en" as name_en, 
	"name:fr" as name_fr, 
	"name:es" as name_es, 
	"name:de" as name_de, 
	int_name as name_int, 
	transliterate(name) as label,
	cast(tags as text) as tags
  FROM osm_point
  WHERE railway in ('station', 'halt','tram_stop') 
	or highway='bus_stop' 
	or amenity in ('bus_stop','taxi','airport','ferry_terminal') 
	or aeroway is not null 
	or aerialway is not null 
	or public_transport in ('stop_position', 'station','platform')
UNION
  SELECT osm_id as osm_id,
	osm_timestamp as lastchange, 
	CASE 
	 WHEN osm_id<0 THEN 'R' -- Relation	
	 ELSE 'W' 		-- Way
	 END AS geomtype, 
	ST_Centroid(way) AS geom,  
-- Combining Tags for different kinds of Transport POIs --
	case
	 when railway='station'  or railway='halt' or (public_transport='stop_position' and train='yes') then 'railway'
	 when railway='tram_stop' or (public_transport='stop_position' and tram='yes') then 'tram'
	 when highway='bus_stop' or (public_transport='stop_position' and bus='yes') or  amenity='bus_station' then 'bus'
	 when amenity='taxi' then 'taxi'
	 when amenity='airport' or aeroway in ('aerodrome','runway','helipad','taxiway','apron') then 'air_traffic'
	 when amenity='ferry_terminal' then 'water_traffic'
	 when aerialway='station' then 'other_traffic'
	 when public_transport is not null then 'public_transport'
	 when aeroway is not null then 'aeroway'
	 when aerialway is not null then 'aerialway'
	end as aggtype,
	case
	 when railway='station' then 'railway_station'
	 when railway='halt' or (public_transport='stop_position' and train='yes') then 'railway_halt'
	 when railway='tram_stop' or (public_transport='stop_position' and tram='yes') then 'tram_stop'
	 when highway='bus_stop' or (public_transport='stop_position' and bus='yes')  then 'bus_stop'
	 when amenity='bus_station' or public_transport='station' then amenity
	 when amenity='taxi' then 'taxi_stand'
	 when amenity='airport' or aeroway='aerodrome' then 'airport'
	 when aeroway in  ('runway','helipad','taxiway','apron') then aeroway
	 when amenity='ferry_terminal' then 'ferry_terminal'
	 when aerialway='station' then 'aerialway_station'
	 when public_transport is not null then public_transport
	 when aeroway is not null then 'aeroway'
	 when aerialway is not null then 'aerialway'
	 else 'others'
	end as type,
	name as name,
	"name:en" as name_en, 
	"name:fr" as name_fr, 
	"name:es" as name_es, 
	"name:de" as name_de, 
	int_name as name_int, 
	transliterate(name) as label,
	cast(tags as text) as tags
  FROM osm_polygon
  WHERE railway in ('station', 'halt','tram_stop') 
	or highway='bus_stop' 
	or amenity in ('bus_stop','taxi','airport','ferry_terminal') 
	or aeroway is not null 
	or aerialway is not null 
	or public_transport in ('stop_position', 'station','platform');
