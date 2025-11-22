QBConfig = {}

QBConfig.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- Gets max players from config file, default 48
QBConfig.DefaultSpawn = vector4(-1035.71, -2731.87, 12.86, 0.0)
QBConfig.UpdateInterval = 10 -- how often to update player data in minutes
QBConfig.StatusInterval = 5000 -- how often to check hunger/thirst status in milliseconds

QBConfig.Money = {}
QBConfig.Money.MoneyTypes = { cash = 500, bank = 5000, crypto = 0, coins = 0 } -- type = startamount - Add or remove money types for your server (for ex. blackmoney = 0), remember once added it will not be removed from the database!
QBConfig.Money.DontAllowMinus = { 'cash', 'crypto', 'paycheck', 'bank', 'coins'} -- Money that is not allowed going in minus
QBConfig.Money.PayCheckTimeOut = 10 -- The time in minutes that it will give the paycheck
QBConfig.Money.PayCheckSociety = false -- If true paycheck will come from the society account that the player is employed at, requires qb-management

QBConfig.Player = {}
QBConfig.Player.HungerRate = 6.2 -- Rate at which hunger goes down.
QBConfig.Player.ThirstRate = 5.8 -- Rate at which thirst goes down.
QBConfig.Player.Bloodtypes = {
    "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-",
}

QBConfig.Server = {} -- General server config
QBConfig.Server.Closed = false -- Set server closed (no one can join except people with ace permission 'qbadmin.join')
QBConfig.Server.ClosedReason = "Server Closed" -- Reason message to display when people can't join the server
QBConfig.Server.Uptime = 0 -- Time the server has been up.
QBConfig.Server.Whitelist = false -- Enable or disable whitelist on the server
QBConfig.Server.WhitelistPermission = 'admin' -- Permission that's able to enter the server when the whitelist is on
QBConfig.Server.PVP = true -- Enable or disable pvp on the server (Ability to shoot other players)
QBConfig.Server.Discord = "" -- Discord invite link
QBConfig.Server.CheckDuplicateLicense = true -- Check for duplicate rockstar license on join
QBConfig.Server.Permissions = { 'god', 'admin', 'operator', 'staff', 'supervisor', 'skilled', 'trusted', 'trial', 'mod', 'trial mod', 'support' } -- Add as many groups as you want here after creating them in your server.cfg
QBConfig.Server.PermissionList = {} -- permission list
QBConfig.Notify = {}

QBConfig.Notify.NotificationStyling = {
    group = false, -- Allow notifications to stack with a badge instead of repeating
    position = "right", -- top-left | top-right | bottom-left | bottom-right | top | bottom | left | right | center
    progress = true -- Display Progress Bar
}

-- These are how you define different notification variants
-- The "color" key is background of the notification
-- The "icon" key is the css-icon code, this project uses `Material Icons` & `Font Awesome`
QBConfig.Notify.VariantDefinitions = {
    success = {
        classes = 'success',
        icon = 'done'
    },
    primary = {
        classes = 'primary',
        icon = 'info'
    },
    error = {
        classes = 'error',
        icon = 'dangerous'
    },
    police = {
        classes = 'police',
        icon = 'local_police'
    },
    ambulance = {
        classes = 'ambulance',
        icon = 'fas fa-ambulance'
    }
}


QBConfig.PropList = {
    -- Casual Props
    ['PBadge'] = {
        ['name'] = 'Police Badge',
        ['prop'] = 'prop_fib_badge',
        ['hash'] = GetHashKey('prop_fib_badge'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['Drill'] = {
        ['name'] = 'Drill Boor',
        ['prop'] = 'hei_prop_heist_drill',
        ['hash'] = GetHashKey('hei_prop_heist_drill'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.14,
            ['Y'] = 0.0,
            ['Z'] = -0.01,
            ['XR'] = 90.0,
            ['YR'] = -90.0,
            ['ZR'] = 180.0,
        },
    },
    ['Duffel'] = {
        ['name'] = 'Duffel Bag',
        ['prop'] = 'xm_prop_x17_bag_01a',
        ['hash'] = GetHashKey('xm_prop_x17_bag_01a'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.27,
            ['Y'] = 0.15,
            ['Z'] = 0.05,
            ['XR'] = 35.0,
            ['YR'] = -125.0,
            ['ZR'] = 50.0,
        },
    },
    ['Trash'] = {
        ['name'] = 'Trash',
        ['prop'] = 'prop_cs_rub_binbag_01',
        ['hash'] = GetHashKey('prop_cs_rub_binbag_01'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.12,
            ['Y'] = 0.0,
            ['Z'] = -0.05,
            ['XR'] = 220.0,
            ['YR'] = 120.0,
            ['ZR'] = 0.0,
        },
    },
    ['Cup'] = {
        ['name'] = 'Paper Cup',
        ['prop'] = 'prop_cs_paper_cup',
        ['hash'] = GetHashKey('prop_cs_paper_cup'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['FishingRod'] = {
        ['name'] = 'Fishing Rod',
        ['prop'] = 'prop_fishing_rod_01',
        ['hash'] = GetHashKey('prop_fishing_rod_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.08,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = -100.0,
            ['YR'] = 0.0,
            ['ZR'] = -20.0,
        },
    },
    ['Boombox'] = {
        ['name'] = 'Boombox',
        ['prop'] = 'prop_boombox_01',
        ['hash'] = GetHashKey('prop_boombox_01'),
        ['bone-index'] = {
            ['bone'] = 1,
            ['X'] = 1,
            ['Y'] = 1,
            ['Z'] = 1,
            ['XR'] = 1,
            ['YR'] = 1,
            ['ZR'] = 1,
        },
    },
    ['Pills'] = {
        ['name'] = 'Pills',
        ['prop'] = 'prop_cs_pills',
        ['hash'] = GetHashKey('prop_cs_pills'),
        ['bone-index'] = {
            ['bone'] = 1,
            ['X'] = 1,
            ['Y'] = 1,
            ['Z'] = 1,
            ['XR'] = 1,
            ['YR'] = 1,
            ['ZR'] = 1,
        },
    },
    ['ShoppingBag'] = {
        ['name'] = 'Shopping Bag',
        ['prop'] = 'prop_shopping_bags01', 
        ['hash'] = GetHashKey('prop_shopping_bags01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.05,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 35.0,
            ['YR'] = -125.0,
            ['ZR'] = 0.0,
        },
    },
    ['CrackPipe'] = {
        ['name'] = 'Crack Pipe',
        ['prop'] = 'prop_cs_crackpipe',
        ['hash'] = GetHashKey('prop_cs_crackpipe'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.05,
            ['Z'] = 0.0,
            ['XR'] = 135.0,
            ['YR'] = -100.0,
            ['ZR'] = 0.0,
        },
    },
    ['Bong'] = {
        ['name'] = 'Bong',
        ['prop'] = 'prop_bong_01',
        ['hash'] = GetHashKey('prop_bong_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.11,
            ['Y'] = -0.23,
            ['Z'] = 0.01,
            ['XR'] = -90.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['HealthPack'] = {
        ['name'] = 'Health Pack',
        ['prop'] = 'prop_ld_health_pack',
        ['hash'] = GetHashKey('prop_ld_health_pack'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.15,
            ['Y'] = 0.08,
            ['Z'] = 0.1,
            ['XR'] = 180.0,
            ['YR'] = 220.0,
            ['ZR'] = 0.0,
        },
    },
    ['ReporterCam'] = {
        ['name'] = 'Weazel News Camera',
        ['prop'] = 'prop_v_cam_01',
        ['hash'] = GetHashKey('prop_v_cam_01'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.13,
            ['Y'] = 0.25,
            ['Z'] = -0.03,
            ['XR'] = -85.0,
            ['YR'] = 0.0,
            ['ZR'] = -80.0,
        },
    },
    ['ReporterMic'] = {
        ['name'] = 'Weazel News Mic',
        ['prop'] = 'p_ing_microphonel_01',
        ['hash'] = GetHashKey('p_ing_microphonel_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.1,
            ['Y'] = 0.05,
            ['Z'] = 0.0,
            ['XR'] = -85.0,
            ['YR'] = -80.0,
            ['ZR'] = -80.0,
        },
    },
    ['BriefCase'] = {
        ['name'] = 'Briefcase',
        ['prop'] = 'prop_ld_case_01',
        ['hash'] = GetHashKey('prop_ld_case_01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.09,
            ['Y'] = -0.012,
            ['Z'] = 0.01,
            ['XR'] = 320.0,
            ['YR'] = -100.0,
            ['ZR'] = 0.0,
        },
    },
    ['GunCase'] = {
        ['name'] = 'Weapon Case',
        ['prop'] = 'prop_box_guncase_01a',
        ['hash'] = GetHashKey('prop_box_guncase_01a'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.18,
            ['Y'] = 0.05,
            ['Z'] = 0.0,
            ['XR'] = 215.0,
            ['YR'] = -175.0,
            ['ZR'] = 100.0,
        },
    },
    ['Pickaxe'] = {
        ['name'] = 'Pickaxe',
        ['prop'] = 'prop_tool_pickaxe',
        ['hash'] = GetHashKey('prop_tool_pickaxe'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.09,
            ['Y'] = 0.03,
            ['Z'] = -0.02,
            ['XR'] = -78.0,
            ['YR'] = 13.0,
            ['ZR'] = 345.0,
        },
    },
    ['DarkmarketBox'] = {
        ['name'] = 'Dark Box',
        ['prop'] = 'prop_idol_case_01',
        ['hash'] = GetHashKey('prop_idol_case_01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.01,
            ['Y'] = -0.02,
            ['Z'] = -0.22,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['Phone'] = {
        ['name'] = 'Phone',
        ['prop'] = 'prop_npc_phone_02',
        ['hash'] = GetHashKey('prop_npc_phone_02'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['Tablet'] = {
        ['name'] = 'Tablet',
        ['prop'] = 'prop_cs_tablet',
        ['hash'] = GetHashKey('prop_cs_tablet'),
        ['bone-index'] = {
            ['bone'] = 60309,
            ['X'] = 0.03,
            ['Y'] = 0.002,
            ['Z'] = -0.0,
            ['XR'] = 0.0,
            ['YR'] = 160.0,
            ['ZR'] = 0.0,
        },
    },
    ['Box'] = {
        ['name'] = 'Box',
        ['prop'] = 'prop_cs_cardbox_01',
        ['hash'] = GetHashKey('prop_cs_cardbox_01'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.05,
            ['Y'] = 0.1,
            ['Z'] = -0.3,
            ['XR'] = 300.0,
            ['YR'] = 250.0,
            ['ZR'] = 20.0,
        },
    }, 
    ['StolenTv'] = {
        ['name'] = 'TV',
        ['prop'] = 'prop_tv_flat_02',
        ['hash'] = GetHashKey('prop_tv_flat_02'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.15,
            ['Y'] = 0.10,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 10.00,
        },
    },
    ['StolenPc'] = {
        ['name'] = 'PC',
        ['prop'] = 'prop_dyn_pc_02',
        ['hash'] = GetHashKey('prop_dyn_pc_02'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.15,
            ['Y'] = 0.10,
            ['Z'] = -0.22,
            ['XR'] = -80.00,
            ['YR'] = -15.00,
            ['ZR'] = -60.00,
        },
    },
    ['StolenMicro'] = {
        ['name'] = 'Microwave',
        ['prop'] = 'prop_microwave_1',
        ['hash'] = GetHashKey('prop_microwave_1'),
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.30,
            ['Y'] = 0.15,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 10.00,
        },
    },
    -- Food Props
    ['hamburger'] = {
        ['name'] = 'Hamburger',
        ['prop'] = 'prop_cs_burger_01',
        ['hash'] = GetHashKey('prop_cs_burger_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.07,
            ['Z'] = 0.02,
            ['XR'] = 120.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['sandwich'] = {
        ['name'] = 'Sandwich',
        ['prop'] = 'prop_sandwich_01',
        ['hash'] = GetHashKey('prop_sandwich_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.05,
            ['Z'] = 0.02,
            ['XR'] = -50.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['hotdog'] = {
        ['name'] = 'Hotdog',
        ['prop'] = 'prop_cs_hotdog_01',
        ['hash'] = GetHashKey('prop_cs_hotdog_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.05,
            ['Z'] = 0.02,
            ['XR'] = -50.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['chocolade'] = {
        ['name'] = 'Chocolade',
        ['prop'] = 'prop_choc_meto',
        ['hash'] = GetHashKey('prop_choc_meto'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.05,
            ['Z'] = 0.02,
            ['XR'] = -50.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['donut'] = {
        ['name'] = 'Donut',
        ['prop'] = 'prop_amb_donut',
        ['hash'] = GetHashKey('prop_amb_donut'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.05,
            ['Z'] = 0.02,
            ['XR'] = -50.0,
            ['YR'] = 16.0,
            ['ZR'] = 60.0,
        },
    },
    ['taco'] = {
        ['name'] = 'Taco',
        ['prop'] = 'prop_taco_01',
        ['hash'] = GetHashKey('prop_taco_01'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.07,
            ['Z'] = 0.02,
            ['XR'] = 160.0,
            ['YR'] = 0.0,
            ['ZR'] = -50.0,
        },
    },
    ['chips'] = {
        ['name'] = 'Chips',
        ['prop'] = 'ng_proc_food_chips01b',
        ['hash'] = GetHashKey('ng_proc_food_chips01b'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.20,
            ['Y'] = 0.07,
            ['Z'] = 0.02,
            ['XR'] = 220.0,
            ['YR'] = 0.0,
            ['ZR'] = -160.0,
        },
    },
    ['macncheese'] = {
        ['name'] = 'Macncheese',
        ['prop'] = 'v_res_fa_potnoodle',
        ['hash'] = GetHashKey('v_res_fa_potnoodle'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.13,
            ['Y'] = 0.07,
            ['Z'] = 0.02,
            ['XR'] = 160.0,
            ['YR'] = 0.0,
            ['ZR'] = -160.0,
        },
    },
    ['sushi-box'] = {
        ['name'] = 'Sushi',
        ['prop'] = 'v_ret_fh_noodle',
        ['hash'] = GetHashKey('v_ret_fh_noodle'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.12,
            ['Y'] = 0.04,
            ['Z'] = 0.05,
            ['XR'] = 130.0,
            ['YR'] = 8.0,
            ['ZR'] = 200.0,
        },
    },
    ['burger-fries'] = {
        ['name'] = 'Fries',
        ['prop'] = 'prop_food_bs_chips',
        ['hash'] = GetHashKey('prop_food_bs_chips'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.12,
            ['Y'] = 0.04,
            ['Z'] = 0.05,
            ['XR'] = 130.0,
            ['YR'] = 8.0,
            ['ZR'] = 200.0,
        },
    },
    ['apple'] = {
        ['name'] = 'Apple',
        ['prop'] = 'ng_proc_food_aple2a',
        ['hash'] = GetHashKey('ng_proc_food_aple2a'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.15,
            ['Y'] = 0.09,
            ['Z'] = 0.09,
            ['XR'] = 180.0,
            ['YR'] = 0.0,
            ['ZR'] = -50.0,
        },
    },
    ['banana'] = {
        ['name'] = 'Banana',
        ['prop'] = 'ng_proc_food_nana1a',
        ['hash'] = GetHashKey('ng_proc_food_nana1a'),
        ['bone-index'] = {
            ['bone'] = 18905,
            ['X'] = 0.16,
            ['Y'] = 0.02,
            ['Z'] = 0.04,
            ['XR'] = 160.0,
            ['YR'] = 0.0,
            ['ZR'] = -50.0,
        },
    },
    -- Drink Props
    ['water'] = {
        ['name'] = 'Boal of Wo a',
        ['prop'] = 'prop_ld_flow_bottle',
        ['hash'] = GetHashKey('prop_ld_flow_bottle'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['vodka'] = {
        ['name'] = 'Boal of Wo a',
        ['prop'] = 'prop_vodka_bottle',
        ['hash'] = GetHashKey('prop_vodka_bottle'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = -0.2,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['beer'] = {
        ['name'] = 'Boal of Wo a',
        ['prop'] = 'prop_cs_beer_bot_01',
        ['hash'] = GetHashKey('prop_cs_beer_bot_01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['whiskey'] = {
        ['name'] = 'Boal of Wo a',
        ['prop'] = 'prop_whiskey_bottle',
        ['hash'] = GetHashKey('prop_whiskey_bottle'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = -0.1,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['cocktail'] = {
        ['name'] = 'Cocktail',
        ['prop'] = 'prop_cocktail',
        ['hash'] = GetHashKey('prop_cocktail'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['coffee'] = {
        ['name'] = 'Coffee',
        ['prop'] = 'p_amb_coffeecup_01',
        ['hash'] = GetHashKey('p_amb_coffeecup_01'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['tea'] = {
        ['name'] = 'Thee',
        ['prop'] = 'prop_mug_02',
        ['hash'] = GetHashKey('prop_mug_02'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['cola'] = {
        ['name'] = 'Cola',
        ['prop'] = 'prop_ecola_can',
        ['hash'] = GetHashKey('prop_ecola_can'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = 0.0,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
    ['burger-soft'] = {
        ['name'] = 'Soft Drink',
        ['prop'] = 'ng_proc_sodacup_01a',
        ['hash'] = GetHashKey('ng_proc_sodacup_01a'),
        ['bone-index'] = {
            ['bone'] = 28422,
            ['X'] = 0.0,
            ['Y'] = 0.0,
            ['Z'] = -0.07,
            ['XR'] = 0.0,
            ['YR'] = 0.0,
            ['ZR'] = 0.0,
        },
    },
}