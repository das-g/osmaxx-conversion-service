-----------------------------------
-- Convert text to positive integer
-----------------------------------
-- drop function estimate_height(text);
create or replace function to_pos_int(txt text)
returns integer as $$
declare
  pos_int integer;
begin
  pos_int := coalesce(substring(txt, '([-]?[0-9]{1,19})')::int, 0);
  if pos_int <= 0 then
    pos_int := null;
  end if;
  return pos_int;
end;
$$ language plpgsql IMMUTABLE;

---------------------------------------------------------------------------------------
-- Estimate building height from height, building:levels and levels
-- out of key "building" is not null.
-- Returns estimated height in meters (integer).
-- EG. SELECT building_height(tags) from osm_polygon
--     SELECT building_height('height=>12.3, building:levels=>x, levels=>x'::hstore);
--     SELECT building_height('height=>x, building:height=>12.3, levels=>x'::hstore);
--     SELECT building_height('height=>x, building:levels=>3.4, levels=>x'::hstore);
--     SELECT building_height('height=>x, building:levels=>x, levels=>4.5'::hstore);
--     SELECT building_height('height=>12.3, building:levels=>3.4, levels=>x'::hstore);
---------------------------------------------------------------------------------------
create or replace function building_height(tags hstore)
returns integer as $$
declare
  height float := null;
  height1 float;
  height2 float;
  height3 float;
  height4 float;
begin
  select into height1,height2,height3,height4
    to_pos_int(tags->'height'), -- in meters
    to_pos_int(tags->'building:height'), -- in meters
    to_pos_int(tags->'building:levels') * 3.0, -- estimated average building height
    to_pos_int(tags->'levels') * 3.0; -- estimated average building height
  if height1 > 0 then
    height := height1;
  elseif height2 > 0 then
    height := height2;
  elseif height3 > 0 then
    height := height3;
  elseif height4 > 0 then
    height := height4;
  end if;
  return ceil(height);
end;
$$ language plpgsql immutable;

---------------------------------------------------------------------------------------
-- write or print (a letter or word) using the closest corresponding letters of
-- a different alphabet or language.
-- EG. select transliterate('Москва́');
--     Moskvá
---------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION transliterate(text) RETURNS text AS '$libdir/utf8translit', 'transliterate' LANGUAGE C STRICT;


------------------------------------------------------------------
-- Convert 'addr:interpolation' into set of points with addresses
-- 2015-04-26 KES
-- Dependencies: hstore extension, function to_pos_int()
------------------------------------------------------------------
drop table if exists addr_interpolated;
create table addr_interpolated as
-- BEGIN
with addr_interpolation_line as (
  select osm_id,
    hstore(tags)->'addr:interpolation' as interpolation_type,
    hstore(tags)->'addr:street' as addr_street,
    way
  from osm_line
  where (hstore(tags)->'addr:interpolation') in ('even','odd','all') -- TODO: 'alphabetic' for example 8a, 9b etc. 
),
addr_interpolation_line_nodes as (
  select l.*,
    nodes[1] as firstnode_id,
    nodes[array_length(nodes, 1)] as lastnode_id
  FROM osm_ways w
  join addr_interpolation_line l on l.osm_id=w.id
),
addr_interpolation_line_first_addr as (
  select l.*,
    to_pos_int( hstore(p.tags)->'addr:housenumber' ) as first_housenr,
    hstore(p.tags)->'addr:street' as first_addr_street
  FROM osm_point p
  join addr_interpolation_line_nodes l on l.firstnode_id=p.osm_id
),
addr_interpolation_line_last_addr as (
  select l.osm_id,
    to_pos_int( hstore(p.tags)->'addr:housenumber' ) as last_housenr,
    hstore(p.tags)->'addr:street' as last_addr_street
  FROM osm_point p
  join addr_interpolation_line_nodes l on l.lastnode_id=p.osm_id
)
select
  first.osm_id as line_id,
  coalesce(addr_street,first_addr_street,last_addr_street) as addr_street,
  interpolation_type,
  least(first_housenr,last_housenr) as first_housenr, -- swap first_housenr and last_housenr?
  greatest(first_housenr, last_housenr) as last_housenr, -- swap last_housenr and first_housenr?
  case when (first_housenr > last_housenr) then ST_Reverse(way)
    else way end as line_geom -- reverse geometry when a swap is needed?
from addr_interpolation_line_first_addr first
join addr_interpolation_line_last_addr last on last.osm_id=first.osm_id
where abs(first_housenr - last_housenr) < 1000 -- from-to-range too large
and first_housenr is not null -- endpoint_wrong_format
and last_housenr is not null  -- endpoint_wrong_format
and (                         -- interpolation even but number odd or inverse
  (abs(first_housenr - last_housenr) >= 2 AND interpolation_type IN ('even', 'odd'))
  or (abs(first_housenr - last_housenr) >= 1 AND interpolation_type = 'all')
  )
and (
  (interpolation_type='even' and first_housenr%2=0 and last_housenr%2=0)
  or (interpolation_type='odd' and first_housenr%2=1 and last_housenr%2=1)
  or interpolation_type='all'
  )
order by interpolation_type, addr_street;

-- CREATE TEMP TABLE temp_tbl(line_id integer, addr_street text, housenr integer, point_geom geometry);
create or replace function addr_interpolate(
    line_id bigint,
    addr_street text,
    interpolation_type text,
    first_housenr integer,
    last_housenr integer,
    line_geom geometry)
returns void as $$
declare
    delta integer := 2;
    countstart numeric;
    countend numeric;
    step numeric;
    location numeric;
begin
    if (interpolation_type = 'all') then
        delta := 1;
    else
        delta := 2;
    end if;
    countstart := first_housenr + delta;
    countend := last_housenr - delta;
    if countend = countstart then
        select 0.5 into step;
    else
        select 1/((countend - countstart) / delta::numeric + 2) into step;
    end if;
    select step into location;
    for housenr in countstart..countend by delta loop
      --
      -- >> TODO: Insert into (temp) table all interpolated address points! <<
      --
      --raise info 'info: %', housenr;
      INSERT INTO temp_tbl
	  select line_id, addr_street, housenr, st_line_interpolate_point(line_geom, location);
      select location+step into location;
    end loop;

end;
$$ language plpgsql volatile;
