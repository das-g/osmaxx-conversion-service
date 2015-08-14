/*
Lowercase all the values in all the rows
This excludes osm_id, osm_timestamp, all names, ele, voltage, frequency, height, population, way, contact:phone, maxspeed, oneway, opening_hours, ref, osm_version, z_order, tags
*/
/*lower osm_line*/

UPDATE osm_line
SET 
"access"=lower("access"), "addr:city"=lower("addr:city"), "addr:housenumber"=lower("addr:housenumber"), "addr:interpolation"=lower("addr:interpolation"), "addr:place"=lower("addr:place"), "addr:postcode"=lower("addr:postcode"), "addr:street"=lower("addr:street"), admin_level=lower(admin_level), aerialway=lower(aerialway), aeroway=lower(aeroway), amenity=lower(amenity), area=lower(area), barrier=lower(barrier), brand=lower(brand),bridge=lower(bridge), boundary=lower(boundary), building=lower(building), bus=lower(bus), cuisine=lower(cuisine), denomination=lower(denomination), drinkable=lower(drinkable), emergency=lower(emergency), foot= lower(foot), "generator:source"=lower("generator:source"), highway=lower(highway), historic=lower(historic), information=lower(information), junction=lower(junction), landuse=lower(landuse), leisure=lower(leisure), man_made=lower(man_made),military=lower(military), "natural"=lower("natural"),office=lower(office), oneway=lower(oneway), operator=lower(operator), phone=lower(phone), "power"=lower("power"), power_source=lower(power_source), parking=lower(parking), place=lower(place), public_transport=lower(public_transport), "recycling:glass"=lower("recycling:glass"), "recycling:paper"=lower("recycling:paper"),  "recycling:clothes"=lower("recycling:clothes"), "recycling:scrap_metal"=lower("recycling:scrap_metal"),railway=lower(railway), religion=lower(religion), route=lower(route),service=lower(service), shop=lower(shop), sport=lower(sport), tourism=lower(tourism), "tower:type"=lower("tower:type"), traffic_calming=lower(traffic_calming),train=lower(train), tram=lower(tram), tunnel=lower(tunnel), type=lower(type), vending=lower(vending), water=lower(water), waterway=lower(waterway), website=lower(website), wetland=lower(wetland), wikipedia=lower(wikipedia), tracktype=lower(tracktype);
/*lower osm_point*/
UPDATE osm_point
SET 
"access"=lower("access"), "addr:city"=lower("addr:city"), "addr:housenumber"=lower("addr:housenumber"), "addr:interpolation"=lower("addr:interpolation"), "addr:place"=lower("addr:place"), "addr:postcode"=lower("addr:postcode"), "addr:street"=lower("addr:street"), admin_level=lower(admin_level), aerialway=lower(aerialway), aeroway=lower(aeroway), amenity=lower(amenity), area=lower(area), barrier=lower(barrier), brand=lower(brand),bridge=lower(bridge), boundary=lower(boundary), building=lower(building), bus=lower(bus), cuisine=lower(cuisine), denomination=lower(denomination), drinkable=lower(drinkable), emergency=lower(emergency), foot= lower(foot), "generator:source"=lower("generator:source"), highway=lower(highway), historic=lower(historic), information=lower(information), junction=lower(junction), landuse=lower(landuse), leisure=lower(leisure), man_made=lower(man_made),military=lower(military), "natural"=lower("natural"),office=lower(office), oneway=lower(oneway), operator=lower(operator), phone=lower(phone), "power"=lower("power"), power_source=lower(power_source), parking=lower(parking), place=lower(place), public_transport=lower(public_transport), "recycling:glass"=lower("recycling:glass"), "recycling:paper"=lower("recycling:paper"), "recycling:clothes"=lower("recycling:clothes"), "recycling:scrap_metal"=lower("recycling:scrap_metal"),railway=lower(railway), religion=lower(religion), route=lower(route), service=lower(service), shop=lower(shop), sport=lower(sport), tourism=lower(tourism), "tower:type"=lower("tower:type"), traffic_calming=lower(traffic_calming),train=lower(train), tram=lower(tram), tunnel=lower(tunnel), type=lower(type), vending=lower(vending), water=lower(water), waterway=lower(waterway), website=lower(website), wetland=lower(wetland), wikipedia=lower(wikipedia);
/*lower osm_polygon*/
UPDATE osm_polygon
SET 
"access"=lower("access"), "addr:city"=lower("addr:city"), "addr:housenumber"=lower("addr:housenumber"), "addr:interpolation"=lower("addr:interpolation"), "addr:place"=lower("addr:place"), "addr:postcode"=lower("addr:postcode"), "addr:street"=lower("addr:street"), admin_level=lower(admin_level), aerialway=lower(aerialway), aeroway=lower(aeroway), amenity=lower(amenity), area=lower(area), barrier=lower(barrier), brand=lower(brand),bridge=lower(bridge), boundary=lower(boundary), building=lower(building), bus=lower(bus), cuisine=lower(cuisine), denomination=lower(denomination), drinkable=lower(drinkable), emergency=lower(emergency), foot= lower(foot), "generator:source"=lower("generator:source"), highway=lower(highway), historic=lower(historic), information=lower(information), junction=lower(junction), landuse=lower(landuse), leisure=lower(leisure), man_made=lower(man_made),military=lower(military), "natural"=lower("natural"), oneway=lower(oneway), operator=lower(operator), phone=lower(phone), "power"=lower("power"), power_source=lower(power_source), parking=lower(parking), place=lower(place), public_transport=lower(public_transport), "recycling:glass"=lower("recycling:glass"), "recycling:paper"=lower("recycling:paper"), "recycling:clothes"=lower("recycling:clothes"), "recycling:scrap_metal"=lower("recycling:scrap_metal"),railway=lower(railway), religion=lower(religion), route=lower(route), service=lower(service), shop=lower(shop), sport=lower(sport), tourism=lower(tourism), "tower:type"=lower("tower:type"), traffic_calming=lower(traffic_calming),train=lower(train), tram=lower(tram), tunnel=lower(tunnel), type=lower(type), vending=lower(vending), water=lower(water), waterway=lower(waterway), website=lower(website), wetland=lower(wetland), wikipedia=lower(wikipedia);
/*End of lowercase*/

/*
trim all the values in all the rows
This excludes osm_id, osm_timestamp, all names, ele, voltage, frequency, height, population, way, contact:phone, maxspeed, oneway, opening_hours, ref, osm_version, z_order, tags
*/
/*trim osm_line*/
UPDATE osm_line
SET 
"access"=trim("access"), "addr:city"=trim("addr:city"), "addr:housenumber"=("addr:housenumber"), "addr:interpolation"=("addr:interpolation"), "addr:place"=("addr:place"), "addr:postcode"=("addr:postcode"), "addr:street"=("addr:street"),  admin_level=trim(admin_level), aerialway=trim(aerialway), aeroway=trim(aeroway), amenity=trim(amenity), area=trim(area), barrier=trim(barrier), brand=trim(brand),bridge=trim(bridge), boundary=trim(boundary), building=trim(building), bus=trim(bus), cuisine=trim(cuisine), denomination=trim(denomination), drinkable=trim(drinkable), emergency=trim(emergency), foot= trim(foot), "generator:source"=trim("generator:source"), highway=trim(highway), historic=trim(historic), information=trim(information), junction=trim(junction), landuse=trim(landuse), leisure=trim(leisure), man_made=trim(man_made),military=trim(military), "natural"=trim("natural"), office=trim(office), oneway=trim(oneway), operator=trim(operator), phone=trim(phone), "power"=trim("power"), power_source=trim(power_source), parking=trim(parking), place=trim(place), public_transport=trim(public_transport), "recycling:glass"=trim("recycling:glass"), "recycling:paper"=trim("recycling:paper"),  "recycling:clothes"=trim("recycling:clothes"), "recycling:scrap_metal"=trim("recycling:scrap_metal"),railway=trim(railway), religion=trim(religion), route=trim(route),service=trim(service), shop=trim(shop), sport=trim(sport), tourism=trim(tourism), "tower:type"=trim("tower:type"), traffic_calming=trim(traffic_calming),train=trim(train), tram=trim(tram), tunnel=trim(tunnel), type=trim(type), vending=trim(vending), water=trim(water), waterway=trim(waterway), website=trim(website), wetland=trim(wetland), wikipedia=trim(wikipedia), tracktype=trim(tracktype);
/*trim osm_point*/
UPDATE osm_point
SET 
"access"=trim("access"), "addr:city"=trim("addr:city"), "addr:housenumber"=("addr:housenumber"), "addr:interpolation"=("addr:interpolation"), "addr:place"=("addr:place"), "addr:postcode"=("addr:postcode"), "addr:street"=("addr:street"), admin_level=trim(admin_level), aerialway=trim(aerialway), aeroway=trim(aeroway), amenity=trim(amenity), area=trim(area), barrier=trim(barrier),  brand=trim(brand),bridge=trim(bridge), boundary=trim(boundary), building=trim(building), bus=trim(bus), cuisine=trim(cuisine), denomination=trim(denomination), drinkable=trim(drinkable), emergency=trim(emergency), foot= trim(foot), "generator:source"=trim("generator:source"), highway=trim(highway), historic=trim(historic), information=trim(information), junction=trim(junction), landuse=trim(landuse), leisure=trim(leisure), man_made=trim(man_made),military=trim(military), "natural"=trim("natural"),office=trim(office), oneway=trim(oneway), operator=trim(operator), phone=trim(phone), "power"=trim("power"), power_source=trim(power_source), parking=trim(parking), place=trim(place), public_transport=trim(public_transport), "recycling:glass"=trim("recycling:glass"), "recycling:paper"=trim("recycling:paper"), "recycling:clothes"=trim("recycling:clothes"), "recycling:scrap_metal"=trim("recycling:scrap_metal"),railway=trim(railway), religion=trim(religion), route=trim(route), service=trim(service), shop=trim(shop), sport=trim(sport), tourism=trim(tourism), "tower:type"=trim("tower:type"), traffic_calming=trim(traffic_calming),train=trim(train), tram=trim(tram), tunnel=trim(tunnel), type=trim(type), vending=trim(vending), water=trim(water), waterway=trim(waterway), website=trim(website), wetland=trim(wetland), wikipedia=trim(wikipedia);
/*trim osm_point*/
UPDATE osm_polygon
SET 
"access"=trim("access"), "addr:city"=trim("addr:city"), "addr:housenumber"=("addr:housenumber"), "addr:interpolation"=("addr:interpolation"), "addr:place"=("addr:place"), "addr:postcode"=("addr:postcode"), "addr:street"=("addr:street"), admin_level=trim(admin_level), aerialway=trim(aerialway), aeroway=trim(aeroway), amenity=trim(amenity), area=trim(area), barrier=trim(barrier),  brand=trim(brand),bridge=trim(bridge), boundary=trim(boundary), building=trim(building), bus=trim(bus), cuisine=trim(cuisine), denomination=trim(denomination), drinkable=trim(drinkable), emergency=trim(emergency), foot= trim(foot), "generator:source"=trim("generator:source"), highway=trim(highway), historic=trim(historic), information=trim(information), junction=trim(junction), landuse=trim(landuse), leisure=trim(leisure), man_made=trim(man_made),military=trim(military), "natural"=trim("natural"),office=trim(office), oneway=trim(oneway), operator=trim(operator), phone=trim(phone), "power"=trim("power"), power_source=trim(power_source), parking=trim(parking), place=trim(place), public_transport=trim(public_transport), "recycling:glass"=trim("recycling:glass"), "recycling:paper"=trim("recycling:paper"), "recycling:clothes"=trim("recycling:clothes"), "recycling:scrap_metal"=trim("recycling:scrap_metal"),railway=trim(railway), religion=trim(religion), route=trim(route), service=trim(service), shop=trim(shop), sport=trim(sport), tourism=trim(tourism), "tower:type"=trim("tower:type"), traffic_calming=trim(traffic_calming),train=trim(train), tram=trim(tram), tunnel=trim(tunnel), type=trim(type), vending=trim(vending), water=trim(water), waterway=trim(waterway), website=trim(website), wetland=trim(wetland), wikipedia=trim(wikipedia);
/*End of trimcase*/

/*Split concatenated values into seperate rows*/
/*Split shop*/
SELECT * INTO temp FROM osm_point LIMIT 0;
INSERT INTO temp
select
osm_id, "access", "addr:city", "addr:housenumber", "addr:interpolation", "addr:place", "addr:postcode", "addr:street", admin_level, aerialway, aeroway, amenity, area, barrier, brand, bridge, boundary, building, bus, "contact:phone", cuisine, denomination, drinkable, ele, emergency, foot, frequency, "generator:source", height, highway, historic, information, junction, landuse, layer, leisure, man_made, maxspeed, military, name, int_name, "name:en", "name:de", "name:fr", "name:es", "natural",office, oneway, opening_hours, operator, phone, "power", power_source, parking, place, population, public_transport, "recycling:glass", "recycling:paper",  "recycling:clothes", "recycling:scrap_metal", railway, "ref", religion, route, service, 
trim(both from regexp_split_to_table(shop,E';\\s*')), 
sport, tourism, "tower:type", traffic_calming, train, tram, tunnel, type, vending, voltage, water, waterway, website, wetland, width, wikipedia, z_order, osm_timestamp, osm_version, tags, way
from osm_point where shop like '%;%';
DELETE FROM osm_point where shop like '%;%';
INSERT INTO osm_point
select * from temp;
DROP TABLE temp;
/*Split amenity*/
SELECT * INTO temp FROM osm_point LIMIT 0;
INSERT INTO temp
select
osm_id, "access", "addr:city", "addr:housenumber", "addr:interpolation", "addr:place", "addr:postcode", "addr:street", admin_level, aerialway, aeroway, 
trim(both from regexp_split_to_table(amenity,E';\\s*')), 
area, barrier, brand, bridge, boundary, building, bus,"contact:phone",  cuisine, denomination, drinkable, ele, emergency, foot, frequency, "generator:source", height, highway, historic, information, junction, landuse, layer, leisure, man_made, maxspeed, military, name, int_name, "name:en", "name:de", "name:fr", "name:es", "natural", office, oneway, opening_hours, operator, phone, "power", power_source, parking, place, population, public_transport, "recycling:glass", "recycling:paper",  "recycling:clothes", "recycling:scrap_metal", railway, "ref", religion, route, service, shop, sport, tourism, "tower:type",traffic_calming, train, tram, tunnel, type, vending, voltage, water, waterway, website, wetland, width, wikipedia, z_order, osm_timestamp, osm_version, tags, way
from osm_point where amenity like '%;%';
DELETE FROM osm_point where amenity like '%;%';
INSERT INTO osm_point
select * from temp;
DROP TABLE temp;
/*Split sport*/
SELECT * INTO temp FROM osm_point LIMIT 0;
INSERT INTO temp
select
osm_id, "access", "addr:city", "addr:housenumber", "addr:interpolation", "addr:place", "addr:postcode", "addr:street", admin_level, aerialway, aeroway, amenity, area, barrier, brand, bridge, boundary, building, bus,"contact:phone",cuisine, denomination, drinkable, ele, emergency, foot, frequency, "generator:source", height, highway, historic, information, junction, landuse, layer, leisure, man_made, maxspeed, military, name, int_name, "name:en", "name:de", "name:fr", "name:es", "natural",office, oneway, opening_hours, operator, phone, "power", power_source, parking, place, population, public_transport, "recycling:glass", "recycling:paper",  "recycling:clothes", "recycling:scrap_metal", railway, "ref", religion, route, service, shop, 
trim(both from regexp_split_to_table(sport,E';\\s*')), 
tourism, "tower:type",traffic_calming, train, tram, tunnel, type, vending, voltage, water, waterway, website, wetland, width, wikipedia, z_order, osm_timestamp, osm_version, tags, way
from osm_point where sport like '%;%';
DELETE FROM osm_point where sport like '%;%';
INSERT INTO osm_point
select * from temp;
DROP TABLE temp;
/*End of split concatenated values into seperate rows*/

/*change all value '1' to yes*/
UPDATE osm_line
SET oneway='yes'
where oneway='1';

/*Height*/
UPDATE osm_point
SET height=(regexp_matches(height, '[-+]?[0-9]*\.?[0-9]*'))[1]
where height is not null;
UPDATE osm_polygon
SET height=(regexp_matches(height, '[-+]?[0-9]*\.?[0-9]*'))[1]
where height is not null;

/*Width*/
UPDATE osm_line
SET width=(regexp_matches(width, '[-+]?[0-9]*\.?[0-9]*'))[1]
where width is not null;


/*Population*/
UPDATE osm_line
SET population=(regexp_matches(population, '[-+]?[0-9]*\.?[0-9]*'))[1]
where population is not null;

UPDATE osm_point
SET population=(regexp_matches(population, '[-+]?[0-9]*\.?[0-9]*'))[1]
where population is not null;

/*Building Height*/
UPDATE osm_polygon
SET height=building_height(tags)
WHERE building is not null and height is null

