-- Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'antiwater'

replace_level_meta 'gta5'
files { 'gta5.meta', 'water.xml' }

resource_type 'map' { gameTypes = { fivem = true } }

map 'map.lua'
this_is_a_map 'yes'