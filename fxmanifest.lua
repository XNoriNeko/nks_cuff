fx_version 'cerulean'
game 'gta5'

author 'MapleOS'
description 'cuff script for ESX optimized'
version '1.0.0'

client_script 'client/client.lua'
server_script 'server/server.lua'
shared_script '@es_extended/imports.lua'

files {
    'stream/p_cs_cuffs_02_s.ydr',
    'config.json'
}

data_file 'DLC_ITYP_REQUEST' 'stream/p_cs_cuffs_02_s.ydr'
