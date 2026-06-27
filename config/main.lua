





--──────────────────────────────────────────────────────────────────────────────
--  Quasar Store · Configuration Guidelines
--──────────────────────────────────────────────────────────────────────────────
--  This configuration file defines all adjustable parameters for the script.
--  Comments are standardized to help you identify which sections you can safely edit.
--
--  • [EDIT] – Safe for users to modify. Adjust these values as needed.
--  • [INFO] – Informational note describing what the variable or block does.
--  • [ADV]  – Advanced settings. Change only if you understand the logic behind it.
--  • [CORE] – Core functionality. Do not modify unless you are a developer.
--  • [AUTO] – Automatically handled by the system. Never edit manually.
--
--  Always make a backup before editing configuration files.
--  Incorrect changes in [CORE] or [AUTO] sections can break the resource.
--──────────────────────────────────────────────────────────────────────────────

Config                                 = {} -- [CORE] Main configuration table.

--──────────────────────────────────────────────────────────────────────────────
-- Locale Selection                                                          [EDIT]
-- [INFO] Choose your preferred language for this script.
-- Files are located in locales/* — you can add your own if missing.
-- Available: ar, bg, bn, ca, cs, da, de, el, en, es, et, fa, fi, fr, he, hi, hr, hu, id,
-- it, ja, ko, lt, lv, ms, nl, no, pl, pt, ro, ru, sk, sl, sv, sw, th, tr, uk, ur, vi, zh

--──────────────────────────────────────────────────────────────────────────────
Config.Locale                          = 'en'
Config.Path                            = 'nui://qs-housing/web/'  -- [ADV]  Base NUI path (keep if you didn't move /web).
Config.ImagePath                       = Config.Path .. 'images/' -- [ADV]  Asset path for images.

--──────────────────────────────────────────────────────────────────────────────
-- Money Type                                                                  [EDIT]
-- [INFO] Defines the base money system for quick interactions.
-- [INFO] Large systems (like housing rent) may still use “bank” internally.
--──────────────────────────────────────────────────────────────────────────────
Config.MoneyType                       = 'money' -- [EDIT] Options: 'money' | 'bank'
Config.EnableQuests                    = true    -- [EDIT] Enable quests

-- If you want to use a custom currency when purchasing a house, add it here and then don't forget to update `RemoveAccountMoney`, `AddAccountMoney`, and `GetAccountMoney` according to your own currency.
Config.MoneyTypes                      = {
    {
        name = 'money',
        label = 'Cash Money',
    },
    {
        name = 'bank',
        label = 'Bank Transfer',
    },
}

--──────────────────────────────────────────────────────────────────────────────
-- Framework Detection                                                         [AUTO]
-- [INFO] Automatically detects ESX/QB. If renamed, create adapters in:
-- client/custom/framework/* and server/custom/framework/*
-- [ADV] Only modify if you know what you're doing.
--──────────────────────────────────────────────────────────────────────────────
local frameworks                       = { -- [CORE] Resource name → internal alias
    ['es_extended'] = 'esx',
    ['qb-core']     = 'qb',
    ['qbx_core']    = 'qb'
}
Config.Framework                       = DependencyCheck(frameworks) or 'standalone' -- [AUTO]

--──────────────────────────────────────────────────────────────────────────────
-- FiveGuard / InteractSound                                                   [EDIT]
-- [INFO] Set your FiveGuard resource name if used, or false if not.
-- [INFO] You can disable interaction sounds if your anticheat blocks them.
--──────────────────────────────────────────────────────────────────────────────
Config.FiveGuard                       = false -- [EDIT] false | 'your-resource-name'
Config.DisableInteractSound            = false -- [EDIT] true to disable ring doorbell.
-- FurniCreator · Client Graphics & Capture                                    [EDIT]
-- [INFO] Interval between thumbnail captures (increase on low-end PCs).
--──────────────────────────────────────────────────────────────────────────────
Config.FurniCreator                    = { interval = 300 } -- [EDIT] ms between captures.
Config.FurniCreatorCommand             = 'housingfurniture'

--──────────────────────────────────────────────────────────────────────────────
-- Inventory System Detection                                                  [AUTO]
-- [INFO] Automatically detects your inventory system.
-- [INFO] To add support for another one, create adapters in:
-- client/custom/inventory/*.lua
--──────────────────────────────────────────────────────────────────────────────
local inventories                      = { -- [CORE]
    ['qs-inventory']     = 'qs-inventory',
    ['qb-inventory']     = 'qb-inventory',
    ['ps-inventory']     = 'ps-inventory',
    ['ox_inventory']     = 'ox_inventory',
    ['core_inventory']   = 'core_inventory',
    ['codem-inventory']  = 'codem-inventory',
    ['inventory']        = 'inventory',
    ['origen_inventory'] = 'origen_inventory',
    ['jaksam_inventory'] = 'jaksam_inventory',
    ['tgiann-inventory'] = 'tgiann-inventory',
    ['ak47_inventory']   = 'ak47_inventory',
}
Config.Inventory                       = DependencyCheck(inventories) or 'default' -- [AUTO]

--──────────────────────────────────────────────────────────────────────────────
-- Dispatch System Detection                                                   [AUTO]
-- [INFO] Detects the active dispatch system for alerts/calls.
-- [INFO] To integrate another, create adapters in:
-- client/custom/dispatch/*.lua
--──────────────────────────────────────────────────────────────────────────────
local dispatch                         = { -- [CORE]
    ['qs-dispatch'] = 'qs-dispatch'
}
Config.Dispatch                        = DependencyCheck(dispatch) or 'default' -- [AUTO]
Config.DefaultRequestModelTimeout      = 15000

--──────────────────────────────────────────────────────────────────────────────
-- Phone System Detection                                                      [AUTO]
-- [INFO] Handles communication features for sale boards, etc.
-- [INFO] To integrate another phone, use adapters in:
-- server/custom/phone/*.lua
--──────────────────────────────────────────────────────────────────────────────
local phones                           = { -- [CORE]
    ['qs-smartphone-pro'] = 'qs-smartphone-pro',
    ['qs-smartphone']     = 'qs-smartphone',
    ['lb-phone']          = 'lb-phone',
    ['gksphone']          = 'gksphone',
    ['okokPhone']         = 'okokPhone',
    ['roadphone']         = 'roadphone',
    ['codem-phone']       = 'codem-phone'
}
Config.Phone                           = DependencyCheck(phones) or 'default' -- [AUTO]

--──────────────────────────────────────────────────────────────────────────────
-- Wardrobe / Appearance Detection                                             [AUTO]
-- [INFO] Detects your clothing/appearance system automatically.
-- [INFO] To add support for a new one, create adapters in:
-- client/custom/wardrobe/*.lua
--──────────────────────────────────────────────────────────────────────────────
local wardrobes                        = { -- [CORE]
    ['qs-appearance']         = 'qs-appearance',
    ['qb-clothing']           = 'qb-clothing',
    ['codem-appearance']      = 'codem-appearance',
    ['ak47_clothing']         = 'ak47_clothing',
    ['fivem-appearance']      = 'fivem-appearance',
    ['illenium-appearance']   = 'illenium-appearance',
    ['raid_clothes']          = 'raid_clothes',
    ['rcore_clothes']         = 'rcore_clothes',
    ['origen_clothing']       = 'origen_clothing',
    ['rcore_clothing']        = 'rcore_clothing',
    ['sleek-clothestore']     = 'sleek-clothestore',
    ['tgiann-clothing']       = 'tgiann-clothing',
    ['p_appearance']          = 'p_appearance',
    ['0r-clothingv2']         = '0r-clothingv2',
    ['17mov_CharacterSystem'] = '17mov_CharacterSystem'
}
Config.Wardrobe                        = DependencyCheck(wardrobes) or 'default' -- [AUTO]
--──────────────────────────────────────────────────────────────────────────────
-- Garage System Detection                                                     [AUTO]
-- [INFO] Auto-detects a compatible garage resource. If none is running, the
-- feature falls back to 'standalone' (garages disabled for this asset).
-- [INFO] To integrate a custom one, add adapters in: server/custom/garage/*.lua
--──────────────────────────────────────────────────────────────────────────────
local garages                          = { -- [CORE] Resource name → internal alias
    ['qb-garages']         = 'qb-garages',
    ['qs-advancedgarages'] = 'qs-advancedgarages',
    ['jg-advancedgarages'] = 'jg-advancedgarages',
    ['cd_garage']          = 'cd_garage',
    ['okokGarage']         = 'okokGarage',
    ['loaf_garage']        = 'loaf_garage',
    ['rcore_garage']       = 'rcore_garage',
    ['zerio-garage']       = 'zerio-garage',
    ['codem-garage']       = 'codem-garage',
    ['ak47_garage']        = 'ak47_garage',
    ['ak47_qb_garage']     = 'ak47_qb_garage',
    ['vms_garagesv2']      = 'vms_garagesv2',
    ['cs-garages']         = 'cs-garages',
    ['msk_garage']         = 'msk_garage',
    ['RxGarages']          = 'RxGarages',
    ['ws_garage-v2']       = 'ws_garage-v2',
    ['op-garages']         = 'op-garages',
    ['op_garages_v2']      = 'op_garages_v2',
    ['bazufix-garages']    = 'bazufix-garages'
}
Config.Garage                          = DependencyCheck(garages) or 'standalone' -- [AUTO]

--──────────────────────────────────────────────────────────────────────────────
-- General Settings                                                            [EDIT]
-- [INFO] Core toggles and behaviors for targeting, upgrades, creation flow,
-- limits, menus, pricing, and display. Adjust to fit your server design.
--──────────────────────────────────────────────────────────────────────────────

-- Points must be used from inside their poly? (entry, board, customHouse, shell)
Config.NeedToBeInsidePoints            = { -- [EDIT]
    ['entry']       = true,                -- [INFO] Require to be inside entry poly to interact.
    ['board']       = true,                -- [INFO] Require to be inside board poly to interact.
    ['customHouse'] = false,               -- [INFO] Allow custom house actions from outside.
    ['shell']       = false                -- [INFO] Force shell interactions inside shell poly.
}

-- Targeting (qb-target / ox_target). If false, fallback to draw/markers where applicable.
Config.UseTarget                       = false -- [EDIT] true | false
Config.TargetLength                    = 5.0   -- [EDIT] Target box length
Config.TargetWidth                     = 5.0   -- [EDIT] Target box width

-- Upgrade catalog (UI list). Only visual/data; logic is handled internally.
Config.Upgrades                        = { -- [EDIT]
    {
        name = 'alarm',
        title = 'Security Alarm',
        description = 'Advanced security system that alerts authorities when your property is breached. Provides 24/7 monitoring and instant notifications.',
        price = 10000
    },
    {
        name = 'camera',
        title = 'Security Cameras',
        description = 'High-definition surveillance system with night vision and motion detection. Monitor your property from anywhere with remote access.',
        price = 35000
    },
    {
        name = 'sensor',
        title = 'Motion Sensor',
        description = 'Smart motion detection system that can distinguish between humans and animals. Integrates with your security network.',
        price = 45000
    },
    {
        name = 'vault',
        title = 'Vault Lock',
        description = 'Military-grade security vault with biometric access and time-delay mechanisms. Maximum protection for your valuables.',
        price = 50000
    },
    {
        name = 'furniture',
        title = 'Furniture Upgrade',
        description = 'Expand your property\'s furniture capacity from 100 to 150 items. Perfect for larger homes and extensive decoration.',
        price = 60000
    },
    {
        name = 'doorbell',
        title = 'Custom Doorbell',
        description = 'Unlock the ability to customize your doorbell sound. Choose from a variety of unique doorbell sounds to personalize your home.',
        price = 15000
    },
    {
        name = 'assistant',
        title = 'Aura Assistant',
        description = 'Unlock Aura voice assistant controls for this property, including voice shortcuts for lights, deliveries, and quick actions.',
        price = 30000
    },
    {
        name = 'wallart',
        title = 'Wall Art Upgrade',
        description = 'Unlock custom wall art placement and live URL texture updates for your property.',
        price = 25000
    },
}

Config.FurnitureLimits                 = {
    normal = 50,  -- Default limit
    upgrade = 150 -- Upgrade Limit
}

-- Stash access rule
-- [INFO] If true, only owners (or those with the vault code) can open the stash.
-- [INFO] Use this to prevent exploit-based entries into MLO interiors.
Config.StashNeedsKey                   = false -- [EDIT] true | false

--──────────────────────────────────────────────────────────────────────────────
-- Society / Company Integration                                               [EDIT]
-- [INFO] Choose your society/banking backend for commissions and payouts.
-- Options:
--   'none','esx_society','ap-government','qb-management','qb-banking',
--   'Renewed-Banking','okokBanking','zpx-banking','tgg-banking','crm-banking', 'tgiann-bank'
--──────────────────────────────────────────────────────────────────────────────
Config.Society                         = 'esx_society' -- [EDIT] Pick from list above.
Config.SocietyCommision                = 0.3           -- [EDIT] 0.30 = 30% of house price to company.

-- Fees / Taxes (pure functions for clarity)
-- [INFO] Adjust percentages as needed. Use integers for whole-number math, or
-- set Config.UseMathCeilOnFees to round up final fees.
Config.BankFee                         = function(price) return price / 100 * 10 end -- [EDIT] 10%
Config.BrokerFee                       = function(price) return price / 100 * 5 end  -- [EDIT] 5%
Config.Taxes                           = function(price) return price / 100 * 5 end  -- [EDIT] 5%

-- Round up fee totals?
Config.UseMathCeilOnFees               = true -- [EDIT] true = ceil final computed fees

--──────────────────────────────────────────────────────────────────────────────
-- Fallback Outfit (Naked Safety)                                              [EDIT]
-- [INFO] Applied if outfit fails to load or player is considered "naked".
--──────────────────────────────────────────────────────────────────────────────
Config.NakedPlayerClothes              = { -- [EDIT]
    Male = {
        ['hat']     = { item = 0, texture = 0 },
        ['glass']   = { item = 0, texture = 0 },
        ['mask']    = { item = 0, texture = 0 },
        ['t-shirt'] = { item = 15, texture = 0 },
        ['torso2']  = { item = 15, texture = 0 },
        ['arms']    = { item = 15, texture = 0 },
        ['pants']   = { item = 14, texture = 0 },
        ['shoes']   = { item = 34, texture = 0 },
        ['vest']    = { item = 0, texture = 0 }
    },
    Female = {
        ['hat']     = { item = 0, texture = 0 },
        ['glass']   = { item = 0, texture = 0 },
        ['mask']    = { item = 0, texture = 0 },
        ['t-shirt'] = { item = 2, texture = 0 },
        ['torso2']  = { item = 18, texture = 0 },
        ['arms']    = { item = 15, texture = 0 },
        ['pants']   = { item = 19, texture = 0 },
        ['shoes']   = { item = 35, texture = 0 },
        ['vest']    = { item = 0, texture = 0 }
    }
}

--──────────────────────────────────────────────────────────────────────────────
-- House Creation Permissions & Limits                                         [EDIT]
-- [INFO] Restrict who can create houses and tweak limits/visuals/behavior.
--──────────────────────────────────────────────────────────────────────────────
Config.CreatorJobs                     = {    -- [EDIT] Allowed jobs for creation mode
    { job = 'realestate',    grade = { 0, 1, 2, 3 } },
    { job = 'realestatejob', grade = false }, -- [INFO] All grades
}

Config.AllowAdminsToCreateHouses       = true             -- [EDIT] Allow admins to create houses
Config.TestRemTime                     = 1                -- [EDIT] House visit time (minutes)
Config.MinZOffset                      = 30               -- [EDIT] Minimum shell Z spawn offset
Config.CreatorAlpha                    = 200              -- [EDIT] Creator ghost alpha (visual aid)
Config.SignTextScale                   = 0.6              -- [EDIT] For-sale poster text scale
Config.TimeInterior                    = 23               -- [EDIT] Interior time to avoid shadow flicker
Config.GroupBlips                      = false            -- [EDIT] True = shorter/hidden address on blips
Config.CategoryBlips                   = true             -- [EDIT] True = use category blips
Config.MaxOwnedHouses                  = 15               -- [EDIT] Per-player ownership limit
Config.SellObjectCommision             = 0.3              -- [EDIT] Furniture sale commission (0.30 = 30%)
Config.EnableBoard                     = false            -- [EDIT] Enable/disable sales board feature
Config.BoardObject                     = 'qs_salesign_01' -- [EDIT] For-sale sign prop
Config.BoardSpawnDistance              = 35.0             -- [EDIT] Sign spawn distance
Config.UseDrawTextOnBoard              = false            -- [EDIT] Use DrawText3D on board
Config.MaxApartmentCount               = 50               -- [EDIT] Max apartments per house (performance-sensitive)
Config.DefaultLightIntensity           = 20.0             -- [EDIT] Default light intensity inside shells
Config.MaxVaultCodes                   = 3                -- [EDIT] Vaults per home
Config.MinPointLength                  = 50.0             -- [EDIT] Minimum polygon length for areas
Config.ShowClosestBlips                = true             -- [IMPORTANT] If true, the closest blips will be shown on the map. Otherwise after the 70 blip limit is reached, the blip's names will be hidden.

--──────────────────────────────────────────────────────────────────────────────
-- Currency Formatting                                                         [EDIT]
-- [INFO] Intl options for price rendering in UI. Purely visual formatting.
--──────────────────────────────────────────────────────────────────────────────
Config.Intl                            = { -- [EDIT]
    locales = 'en-US',                     -- e.g. 'en-US','pt-BR','es-ES','fr-FR','de-DE','ru-RU','zh-CN'
    options = {
        style = 'currency',                -- 'decimal' | 'currency' | 'percent' | 'unit'
        currency = 'USD',                  -- 'USD','EUR','BRL','RUB','CNY', etc.
        minimumFractionDigits = 0          -- 0..5
    }
}

--──────────────────────────────────────────────────────────────────────────────
-- Map Blips Configuration                                                     [EDIT]
-- [INFO] Controls the display of property-related blips on the map.
--──────────────────────────────────────────────────────────────────────────────
Config.Blip                            = { -- [EDIT]
    forSale = { enabled = true },
    owned = { enabled = true, color = 3 },
    ownedOther = { enabled = true, color = 3 },
    officialOwned = { enabled = true, color = 2 }, -- [INFO] Houses rented by the official owner
    rentable = { enabled = true, color = 5 },
    purchasable = { enabled = true, color = 4 }
}

Config.DisableAllHouseBlips            = false -- [EDIT] true = disables all blips

--──────────────────────────────────────────────────────────────────────────────
-- Keybinds                                                                    [EDIT]
-- [INFO] Controls which keys open the in-game menus.
--──────────────────────────────────────────────────────────────────────────────
Config.OpenHouseMenu                   = 'F3'                      -- [EDIT] Open house internal menu
Config.OpenJobMenu                     = 'F7'                      -- [EDIT] Open creation/job menu
Config.EnableF3Shop                    = true                      -- [EDIT] Disable decoration purchase from F3
Config.DisableHouseMenuKeybind         = false                     -- [EDIT] Disable keyboard access to house management menu
-- When true, hides only enter/exit house DrawText3D (door + interior exit). For radial/target etc. using housing:radial:enterHouse / housing:radial:exitHouse. E and exit quick menu unchanged.
Config.DisableHouseEnterExitDrawText   = false                     -- [EDIT]
Config.TabletModel                     = 'custom_smart_home_panel' -- [EDIT] Tablet model used for management
Config.TabletInteractDistance          = 1.8                       -- [EDIT] Interaction distance for non-target tablet usage
Config.TabletTargetLength              = 0.7                       -- [EDIT] Tablet target box length
Config.TabletTargetWidth               = 0.7                       -- [EDIT] Tablet target box width

Config.Cleaning                        = true
Config.JunkObjects                     = {
    'qs_dust_prop_01',
    'qs_dust_prop_01',
    'qs_garbage_prop_01',
    'qs_garbage_prop_02',
    'qs_garbage_prop_03'
}
Config.JunkObjectTime                  = 10 * 60 * 1000 -- 10 minutes
Config.MaxJunkPerHouse                 = 10             -- Maximum junk objects per house

-- Cleaner Robot Settings                                                        [EDIT]
-- [INFO] Settings for the autonomous cleaning robot furniture.
Config.CleanerRobot                    = {
    moveSpeed = 0.012,               -- Base movement speed (very slow, realistic)
    maxSpeed = 0.024,                -- Maximum movement speed
    acceleration = 0.0003,           -- How fast robot accelerates
    deceleration = 0.0008,           -- How fast robot decelerates
    raycastDistance = 0.8,           -- Distance for obstacle detection
    junkDetectRadius = 1.0,          -- Radius to detect junk to clean
    maxDistanceFromDock = 12.0,      -- Maximum distance robot can travel from dock (prevents leaving house)
    cleaningTimeout = 5 * 60 * 1000, -- Time (ms) before robot auto-returns to dock (5 minutes)
    randomDirectionTime = 15000,     -- Time (ms) before random direction change
    maxStuckTime = 5000,             -- Time (ms) before robot tries to unstick itself
    wobbleEnabled = true,            -- Enable slight wobble for realism
    wobbleAmount = 0.15,             -- Wobble intensity (degrees)
    wobbleSpeed = 0.08,              -- Wobble oscillation speed
}

--──────────────────────────────────────────────────────────────────────────────
-- Illegal System Settings                                                     [EDIT]
-- [INFO] Configure items, jobs, and requirements for robberies/raids.
--──────────────────────────────────────────────────────────────────────────────
Config.RequiredCop                     = 0                       -- [EDIT] Minimum police required (for lockpicking)
Config.PoliceJobs                      = { 'police', 'sheriff' } -- [EDIT] Jobs counted as police

Config.EnableRobbery                   = true                    -- [EDIT] Enable usable item for robberies
Config.EnableRaid                      = true                    -- [EDIT] Enable usable item for raids
Config.RobberyItem                     = 'lockpick'              -- [EDIT] Item to start robbery
Config.StomRamItem                     = 'police_stormram'       -- [EDIT] Item to start police search
Config.RequireOwnerOnline              = true                    -- [EDIT] Require house owner to be online for robbery

-- House security alarm (battering ram / lockpick when upgrade 'alarm' is owned)
Config.HouseAlarmDurationMs            = 35000                              -- [EDIT] How long the alarm sound plays (ms), then stops automatically
Config.HouseAlarmHearRange             = 80.0                               -- [EDIT] Players within this distance (m) of house entry hear the alarm
Config.HouseAlarmSoundName             = 'VEHICLES_HORNS_AMBULANCE_WARNING' -- [EDIT] GTA audio name for PlaySoundFromCoord

--──────────────────────────────────────────────────────────────────────────────
-- Meta Key System                                                              [EDIT]
-- [INFO] Meta key system allows players to have physical key items in their
-- inventory. These keys have metadata containing the house ID they belong to.
-- When a player uses the key or tries to enter a house, the system checks
-- if they have a meta key for that specific house in their inventory.
--──────────────────────────────────────────────────────────────────────────────
Config.EnableMetaKey                   = true       -- [EDIT] Enable meta key system
Config.MetaKeyItem                     = 'housekey' -- [EDIT] The item name for house keys
Config.MetaKeyCheckOnEntry             = true       -- [EDIT] Check meta key when entering house
Config.MetaKeyCanOpenDoor              = true       -- [EDIT] Meta key holders can lock/unlock doors
Config.MetaKeyCreatePrice              = 500        -- [EDIT] Price to create a meta key (in Config.MoneyType currency)

--──────────────────────────────────────────────────────────────────────────────
-- Rental & Mortgage Configuration                                             [EDIT]
-- [INFO] Defines how rental and mortgage systems behave and charge intervals.
--──────────────────────────────────────────────────────────────────────────────
Config.CreditEnable                    = true         -- [EDIT] Enable mortgage in house contracts
Config.CreditEq                        = 0.3          -- [EDIT] Loan collection percentage
Config.CreditTime                      = 5            -- [EDIT] Interval (minutes) for loan collection
Config.HireRenterCommand               = 'hireRenter' -- [EDIT] Command to expel tenants (admin)

Config.RentTime                        = 5            -- [EDIT] Interval (minutes) for rent collection (used when RentScheduler.Mode = 'interval')
Config.EnableRentable                  = true         -- [EDIT] Enable rental system
Config.CreatedRentableHousesManageable = false        -- [EDIT] If false, realestate cannot cancel leases

Config.RentScheduler                   = {
    Enabled = true,
    Mode = 'monthly_utc_anniversary', -- 'interval' | 'monthly_utc_anniversary'
    PollMinutes = 5,                  -- how often due rents are checked (monthly mode only)
}

Config.Bills                           = {
    Enabled = true,
    IntervalHours = 1,         -- in hours
    Electricity = {
        kilowattPerHour = 1.5, -- Hourly kilowatt consumption when lights are on
        pricePerKilowatt = 50, -- Price per kilowatt ($)
    },
    RandomRanges = {           -- Random bill amounts
        water = { min = 30, max = 150 },
        internet = { min = 80, max = 300 }
    },
    -- Auto eviction system: Remove house owner after X unpaid bills This system can reset the ownership of homes that are not actively used on your server. However, be careful. If the bills for rented homes are not paid, their ownership will also be revoked.
    AutoEviction = {
        Enabled = true,                                  -- Enable/disable auto eviction system
        MaxUnpaidBills = 400,                            -- Maximum unpaid bills before eviction (default: 400) 400 bills = 20 days (1 hour = 1 bill)
        NotifyOwnerAtBills = { 30, 100, 200, 300, 400 }, -- Notify owner when unpaid bills reach these counts
        NotifyOnEviction = true,                         -- Notify owner when evicted
    }
}

-- Invoices and rents are collected after 100 data, regardless of whether they are paid. Therefore, they are automatically deleted so they don't clutter your database.
Config.Cleanup                         = {
    Enabled = true,
    IntervalHours = 1, -- How often to run cleanup (hours)
    Bills = {
        KeepDays = 30, -- Keep paid bills for X days
    },
    Rent = {
        KeepDays = 30, -- Keep paid rent records for X days
    }
}

Config.ManagementButtons               = {
    wardrobe        = true, -- [EDIT] Show/hide wardrobe button
    storage         = true, -- [EDIT] Show/hide storage button
    charge          = true, -- [EDIT] Show/hide charge button (qs-smartphone battery housing chargers)
    delivery        = true, -- [EDIT] Show/hide IKEA delivery point button
    music           = true, -- [EDIT] Show/hide music button
    decorate        = true, -- [EDIT] Show/hide decorate button
    rent            = true, -- [EDIT] Show/hide rent button
    cancelRent      = true, -- [EDIT] Show/hide cancel rent button
    sellBank        = true, -- [EDIT] Show/hide sell to bank button
    sellPlayer      = true, -- [EDIT] Show/hide sell to player button
    cancelSellHouse = true, -- [EDIT] Show/hide cancel sell house button
    transferHouse   = true, -- [EDIT] Show/hide transfer house button
    leave           = true, -- [EDIT] Show/hide leave button
    toggleDoor      = true, -- [EDIT] Show/hide toggle door button
    fixDoor         = true, -- [EDIT] Show/hide fix door button
    changeTheme     = true, -- [EDIT] Show/hide change theme button
    createMetaKey   = true, -- [EDIT] Show/hide create meta key button (requires Config.EnableMetaKey = true)
}

Config.DoorBellSounds                  = {
    { label = 'Doorbell',   value = 'doorbell' },
    { label = 'Doorbell 2', value = 'doorbell2' },
    { label = 'Doorbell 3', value = 'doorbell3' },
    { label = 'Doorbell 4', value = 'doorbell4' },
    { label = 'Doorbell 5', value = 'doorbell5' },
    { label = 'Doorbell 6', value = 'doorbell6' },
    { label = 'Doorbell 7', value = 'doorbell7' }
}

--──────────────────────────────────────────────────────────────────────────────
-- Decoration & Stash Configuration                                            [EDIT]
-- [INFO] Controls decorating access and stash system per property.
--──────────────────────────────────────────────────────────────────────────────
Config.SpawnDistance                   = 100.0 -- [EDIT] Object spawn radius (meters)
Config.MaximumDistanceForDecorate      = 350.0 -- [EDIT] Max decorate distance or false to disable
Config.DecorateOnlyAccessForOwner      = true  -- [EDIT] Only owner can decorate

Config.DefaultStashData                = {     -- [EDIT] Default stash size for houses
    maxweight = 1000000,
    slots = 30,
}

Config.Music                           = 'decorate' -- [EDIT] false to disable music
Config.MusicVolume                     = 0.05       -- [EDIT] Music volume (0.0–1.0)

--──────────────────────────────────────────────────────────────────────────────
-- Shells & Interior Models                                                    [EDIT]
-- [INFO] Define available interior shells (MLO replacements or instanced).
-- [INFO] Each shell can include custom stash settings.
--──────────────────────────────────────────────────────────────────────────────
Config.Shells                          = { -- [EDIT]
    -- SubhamPRO Colab Shells
    {
        model = 'mv_sh_01_subhampro_tebex_io',
        stash = { maxweight = 1000000, slots = 5 },
        shower = {
            ptfxOffset = vec3(-6.0, 15.639, 2.300),
            animationOffset = vec4(-6.0, 15.639, 1.112, 260.764)
        },
        sink = {
            ptfxOffset = vec3(-6.2, 12.620, 1.08),
            animationOffset = vec4(-5.688, 12.683, 1.040, 176.396),
        },
        cooking = {
            animationOffset = vec4(2.283, 2.628, 1.040, 20.58),
            recipes = Config.CookingRecipes
        },
        toilet = {
            -- default (-5.720, 13.954, 1.040, 136.999
            ptfxOffset = vec3(-5.720, 13.954, 1.040),
            animationOffset = vec4(-5.8, 13.918, 0.872, 180.427),
        }
    },
    {
        model = 'mv_sh_02_subhampro_tebex_io',
        stash = { maxweight = 1000000, slots = 5 },
        shower = {
            ptfxOffset = vec3(-0.740, -5.059, 4.939),
            animationOffset = vec4(-0.740, -5.059, 3.739, -95.915)
        },
        sink = {
            ptfxOffset = vec3(0.955, -2.797, 3.698),
            animationOffset = vec4(0.955, -2.797, 3.698, -3.518),
        },
        cooking = {
            animationOffset = vec4(-2.344, -3.053, 3.698, -1.552),
            recipes = Config.CookingRecipes
        },
        toilet = {
            ptfxOffset = vec3(-0.352, -3.046, 3.698),
            animationOffset = vec4(-0.352, -3.046, 3.698, -183.579),
        }
    },
    { model = 'm_sh_01_subhampro_tebex_io', stash = { maxweight = 1000000, slots = 5 } },
    { model = 'm_sh_02_subhampro_tebex_io', stash = { maxweight = 1000000, slots = 5 } },
    { model = 'm_sh_03_subhampro_tebex_io', stash = { maxweight = 1000000, slots = 5 } },
    {
        model = 'm_sh_04_subhampro_tebex_io',
        stash = { maxweight = 1000000, slots = 5 },
        shower = {
            ptfxOffset = vec3(-1.540, 12.319, 2.500),
            animationOffset = vec4(-1.540, 12.319, 1.335, -273.424)
        },
        sink = {
            ptfxOffset = vec3(2.616, 11.784, 1.293),
            animationOffset = vec4(2.616, 11.784, 1.293, -268.504),
        },
        toilet = {
            ptfxOffset = vec3(0.327, 10.127, 2.015),
            animationOffset = vec4(0.437, 10.760, 1.293, -86.416),
        }
    },
    {
        model = 'm_sh_05_subhampro_tebex_io',
        stash = { maxweight = 1000000, slots = 5 },
        shower = {
            ptfxOffset = vec3(11.600, 0.673, 2.242),
            animationOffset = vec4(11.600, 0.673, 1.042, -2.045)
        },
        sink = {
            ptfxOffset = vec3(8.135, 5.857, 1.055),
            animationOffset = vec4(8.135, 5.857, 1.055, -267.979),
        },
        toilet = {
            ptfxOffset = vec3(11.048, 6.612, 1.378),
            animationOffset = vec4(11.026, 5.858, 1.042, 89.050),
        }
    },
    { model = 'm_sh_06_subhampro_tebex_io', stash = { maxweight = 1000000, slots = 5 } },
    {
        model = 'm_sh_07_subhampro_tebex_io',
        stash = { maxweight = 1000000, slots = 5 },
        shower = {
            ptfxOffset = vec3(0.418, 10.911, 2.443),
            animationOffset = vec4(0.418, 10.911, 1.243, -357.594)
        },
        cooking = {
            animationOffset = vec4(7.377, -12.090, 1.182, -90.973),
            recipes = Config.CookingRecipes
        }
    },
    {
        model = 'm_sh_08_subhampro_tebex_io',
        stash = { maxweight = 1000000, slots = 5 },
        shower = {
            ptfxOffset = vec3(8.148, 6.933, 10.028),
            animationOffset = vec4(8.148, 6.933, 11.828, -357.893)
        },
        sink = {
            ptfxOffset = vec3(2.568, 10.106, 11.828),
            animationOffset = vec4(2.568, 10.106, 11.828, -270.582),
        },
        cooking = {
            animationOffset = vec4(-3.333, 2.839, 7.396, -84.002),
            recipes = Config.CookingRecipes
        },
        toilet = {
            ptfxOffset = vec3(-0.677, 9.846, 12.319),
            animationOffset = vec4(-0.173, 9.804, 11.828, 175.883),
        }
    },
    {
        model = 'm_sh_09_subhampro_tebex_io',
        stash = { maxweight = 1000000, slots = 5 },
        shower = {
            ptfxOffset = vec3(-10.636, 1.814, 3.0),
            animationOffset = vec4(-10.636, 1.814, 1.837, -264.619)
        },
        sink = {
            ptfxOffset = vec3(-7.883, 5.023, 1.795),
            animationOffset = vec4(-7.883, 5.023, 1.795, -270.620),
        },
        cooking = {
            animationOffset = vec4(-1.818, 16.028, 1.795, -0.140),
            recipes = Config.CookingRecipes
        },
        toilet = {
            ptfxOffset = vec3(-8.010, 1.430, 1.795),
            animationOffset = vec4(-8.010, 1.430, 1.795, -90.884),
        }
    },

    -- NavyPanda Colab Shells
    { model = 'd3_shell_shellv1',           stash = { maxweight = 1000000, slots = 5 } },
    { model = 'd3_shell_shellv2',           stash = { maxweight = 1000000, slots = 5 } },
    { model = 'd3_shell_shellv3',           stash = { maxweight = 1000000, slots = 5 } },

    -- Maruii Colab Shells
    { model = 'mv13_shell_demo1',           stash = { maxweight = 1000000, slots = 5 } },
    { model = 'mv13_shell_demo2',           stash = { maxweight = 1000000, slots = 5 } },
    { model = 'mv13_shell_demo3',           stash = { maxweight = 1000000, slots = 5 } },
}

Config.DeliveriesEnabled               = true                  -- [EDIT] true | false  Enable/disable the food delivery system
Config.DancersEnabled                  = true                  -- [EDIT] true | false  Enable/disable the private dancer system
Config.IkeaDeliveryEnabled             = true                  -- [EDIT] true | false  Enable/disable delayed IKEA furniture delivery system
Config.IkeaDeliveryDelayMinutes        = 0.1                   -- [EDIT] minutes before IKEA furniture orders become collectible
Config.IkeaDeliveryStatusCheckMs       = 15000                 -- [EDIT] server polling interval for pending IKEA orders
Config.IkeaDeliveryBoxModel            = 'v_ind_meatboxsml_02' -- [EDIT] delivery crate object model
Config.IkeaDeliveryPedModel            = 's_m_m_dockwork_01'   -- [EDIT] delivery ped model
Config.IkeaDeliveryPedAnim             = {                     -- [EDIT] delivery ped box-carry animation
    dict = 'anim@heists@box_carry@',
    name = 'idle'
}
Config.IkeaDeliveryPedAttach           = { -- [EDIT] delivery box attach offsets for ped hand
    bone = 18905,
    pos = vec3(0.11, -0.02, -0.02),
    rot = vec3(-35.0, 0.0, 20.0)
}
Config.PedStreaming                    = {
    -- Global fallback for any streamed ped
    default = {
        spawnDistance = 70.0,
        despawnDistance = 85.0
    },
    -- Realtor NPC in housebrowser
    realEstate = {
        spawnDistance = 70.0,
        despawnDistance = 85.0
    },
    -- Robbery sell NPC
    robbery = {
        spawnDistance = 70.0,
        despawnDistance = 85.0
    },
    -- Dancers placed in houses
    dancers = {
        spawnDistance = 35.0,
        despawnDistance = 45.0
    },
    -- IKEA delivery worker ped
    ikeaDelivery = {
        spawnDistance = 55.0,
        despawnDistance = 65.0
    },
}

Config.Deliveries                      = {
    {
        title = 'Urban Sandwich',
        description = 'Freshly made sandwiches, simple, fast and always tasty',
        price = 80,
        items = {
            'sandwich'
        },
        -- Delivery time in minutes
        -- Can be a number (fixed time) or table with min and max (random time)
        deliveryTime = 0.05 -- Random between 1-2 minutes
        -- deliveryTime = 7 -- Fixed 7 minutes
    },

    {
        title = 'Burger Shot',
        description = 'Classic burgers, fries and fast food',
        price = 120,
        items = {
            'burger',
            'fries'
        },
        deliveryTime = { min = 2, max = 4 }
    },

    {
        title = 'Pizza This',
        description = 'Hot pizza delivered straight to your door',
        price = 150,
        items = {
            'pizza_slice'
        },
        deliveryTime = { min = 3, max = 5 }
    },

    {
        title = 'Bean Machine',
        description = 'Fresh coffee and sweet pastries',
        price = 90,
        items = {
            'coffee',
            'donut'
        },
        deliveryTime = { min = 1, max = 3 }
    },

    {
        title = 'Cluckin Bell',
        description = 'Fast chicken meals for hungry citizens',
        price = 110,
        items = {
            'chickenwrap'
        },
        deliveryTime = { min = 2, max = 4 }
    },

    {
        title = 'Up-n-Atom',
        description = 'Atomic burgers with explosive flavor',
        price = 140,
        items = {
            'burger',
            'cola'
        },
        deliveryTime = { min = 3, max = 6 }
    },

    {
        title = 'Taco Bomb',
        description = 'Mexican food with extra spice',
        price = 130,
        items = {
            'taco'
        },
        deliveryTime = { min = 2, max = 5 }
    },

    {
        title = 'Healthy Life',
        description = 'Healthy meals and fresh salads',
        price = 160,
        items = {
            'salad',
            'water'
        },
        deliveryTime = { min = 3, max = 6 }
    }
}

Config.Dancers                         = {
    {
        title = 'Valentina Rouge',
        description = 'A luxury escort known for elegance, charm, and an exclusive high-end private show.',
        price = 1350,
        pedModel = 'csb_stripper_01',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/csb_stripper_01.png',
        time = 40 * 60 * 1000,              -- 40 minutes
        deliveryTime = { min = 3, max = 8 } -- Random between 3-8 minutes
    },
    {
        title = 'Velvet Rose',
        description = 'An experienced private dancer who knows exactly how to set the mood.',
        price = 700,
        pedModel = 's_f_y_stripper_01',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/s_f_y_stripper_01.png',
        time = 10 * 60 * 1000,               -- 10 minutes
        --deliveryTime = 0.05    -- Random between 1-2 minutes
        deliveryTime = { min = 3, max = 10 } -- Random between 3-10 minutes
    },
    {
        title = 'Raul',
        description = 'A mysterious dancer with surprising moves and a long, unforgettable show.',
        price = 850,
        pedModel = 'a_m_m_tranvest_01',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/a_m_m_tranvest_01.png',
        time = 70 * 60 * 1000,              -- 70 minutes
        deliveryTime = { min = 2, max = 6 } -- Random between 2-6 minutes
    },
    {
        title = 'Scarlet Desire',
        description = 'A premium dancer offering an exclusive and unforgettable private show.',
        price = 1500,
        pedModel = 's_f_y_stripper_02',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/s_f_y_stripper_02.png',
        time = 15 * 60 * 1000,              -- 15 minutes
        deliveryTime = { min = 2, max = 8 } -- Random between 2-8 minutes
    },
    {
        title = 'Candy Blaze',
        description = 'A bold and seductive performer known for her fiery attitude and unforgettable private shows.',
        price = 900,
        pedModel = 'csb_stripper_02',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/csb_stripper_02.png',
        time = 30 * 60 * 1000,              -- 30 minutes
        deliveryTime = { min = 2, max = 6 } -- Random between 2-6 minutes
    },
    {
        title = 'Turbo Tammy',
        description = 'Fast, cheap, and surprisingly energetic. Turbo Tammy brings chaotic dance moves.',
        price = 350,
        pedModel = 'a_f_m_fatcult_01',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/a_f_m_fatcult_01.png',
        time = 20 * 60 * 1000,              -- 20 minutes
        deliveryTime = { min = 1, max = 3 } -- Random between 1-3 minutes
    },
    {
        title = 'Señorita Ricardo',
        description = 'A confident dance legend with bold moves and unforgettable attitude.',
        price = 920,
        pedModel = 'a_f_m_bodybuild_01',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/a_f_m_bodybuild_01.png',
        time = 20 * 60 * 1000,              -- 20 minutes
        deliveryTime = { min = 1, max = 3 } -- Random between 1-3 minutes
    },
    {
        title = 'Dr. Lola Sin',
        description = 'A seductive doctor dancer with a taste for exotic fantasies.',
        price = 950,
        pedModel = 'mp_f_cocaine_01',
        anim = {
            dict = 'mp_safehouse',
            name = 'lap_dance_girl'
        },
        image = Config.ImagePath .. 'dancers/mp_f_cocaine_01.png',
        time = 35 * 60 * 1000,              -- 35 minutes
        deliveryTime = { min = 2, max = 6 } -- Random between 2-6 minutes
    }
}

Config.CookingRecipes                  = {
    {
        title = 'Toast',
        description = 'Simple toasted bread. Fast and easy to prepare.',
        ingredients = {
            ['bread'] = 1,
        },
        rewards = {
            ['toast'] = 1,
        },
        time = 35000
    },
    {
        title = 'Sandwich',
        description = 'A classic homemade sandwich, prepared in seconds.',
        ingredients = {
            ['bread'] = 2,
            ['cheese'] = 1,
        },
        rewards = {
            ['sandwich'] = 1,
        },
        time = 26000
    },
    {
        title = 'Hot Dog',
        description = 'Quick grilled sausage in a soft bun.',
        ingredients = {
            ['bread'] = 1,
            ['sausage'] = 1,
        },
        rewards = {
            ['hotdog'] = 1,
        },
        time = 26000
    },
    {
        title = 'Cheese Burger',
        description = 'Juicy burger with melted cheese, cooked fast at home.',
        ingredients = {
            ['bread'] = 1,
            ['meat'] = 1,
            ['cheese'] = 1,
        },
        rewards = {
            ['burger'] = 1,
        },
        time = 27000
    },
    {
        title = 'Pasta',
        description = 'Simple pasta dish with a basic tomato sauce.',
        ingredients = {
            ['pasta'] = 1,
            ['tomato'] = 2,
        },
        rewards = {
            ['pasta_plate'] = 1,
        },
        time = 18000
    },
    {
        title = 'Pizza',
        description = 'Fresh homemade pizza, straight from the oven.',
        ingredients = {
            ['dough'] = 1,
            ['cheese'] = 2,
            ['tomato'] = 2,
        },
        rewards = {
            ['pizza'] = 1,
        },
        time = 29000
    },
    {
        title = 'Grilled Steak',
        description = 'Perfectly grilled steak, ready in minutes.',
        ingredients = {
            ['meat'] = 2,
        },
        rewards = {
            ['steak'] = 1,
        },
        time = 28000
    },

    {
        title = 'Chicken Meal',
        description = 'Quick roasted chicken meal, filling and tasty.',
        ingredients = {
            ['chicken'] = 1,
            ['spices'] = 1,
        },
        rewards = {
            ['chicken_meal'] = 1,
        },
        time = 29000
    },

    {
        title = 'Luxury Dinner',
        description = 'High-end homemade dinner prepared surprisingly fast.',
        ingredients = {
            ['meat'] = 2,
            ['wine'] = 1,
            ['spices'] = 2,
        },
        rewards = {
            ['luxury_dinner'] = 1,
        },
        time = 10000
    },
    {
        title = 'Salad',
        description = 'Fresh and healthy homemade salad. Light but refreshing.',
        ingredients = {
            ['lettuce'] = 1,
            ['tomato'] = 1,
        },
        rewards = {
            ['salad'] = 1,
        },
        time = 5000
    },

    {
        title = 'Omelette',
        description = 'Simple egg omelette cooked in minutes. Perfect for breakfast.',
        ingredients = {
            ['egg'] = 2,
            ['cheese'] = 1,
        },
        rewards = {
            ['omelette'] = 1,
        },
        time = 36000
    },

    {
        title = 'Fish & Chips',
        description = 'Crispy fried fish with golden fries. A classic comfort meal.',
        ingredients = {
            ['fish'] = 1,
            ['potato'] = 2,
        },
        rewards = {
            ['fish_chips'] = 1,
        },
        time = 29000
    }
}

Config.Robbery                         = {
    enabled = true,
    sell = {
        enabled = true,
        location = vec4(40.167038, -1022.545044, 29.515747, 68.031494),
        pedModel = 'g_m_m_chigoon_02',
        anim = {
            dict = 'anim@amb@business@bgen@bgen_no_work@',
            name = 'stand_phone_phoneputdown_idle_nowork'
        },
        blip = {
            enabled = true,
            sprite = 176,
            color = 4,
            scale = 0.7,
            display = 4,
            highDetail = true,
            text = 'Robbery Sell'
        },
        price = 0.1 -- 10% del precio
    }
}

Config.RealeStateNPC                   = {
    enabled = true,

    location = vec4(-253.978027, -970.457153, 31.217529, 161.574799), -- [EDIT] NPC location coordinates

    pedModel = 'a_m_m_business_01',                                   -- [EDIT] Business / real estate agent ped

    anim = {
        dict = 'amb@world_human_stand_guard@male@idle_a', -- [EDIT] Arms crossed, professional guard stance
        name = 'idle_a'
    },

    blip = {
        enabled = true,
        sprite  = 374, -- [INFO] Real Estate icon
        color   = 3,
        scale   = 0.8,
        text    = 'Real Estate'
    }
}

Config.HouseBrowserCommand             = true -- [EDIT] Enable/disable housebrowser command

--──────────────────────────────────────────────────────────────────────────────
-- Optional Insurance Integration                                              [AUTO]
-- [INFO] Automatically detects if 'm-insurance' is running.
--──────────────────────────────────────────────────────────────────────────────
Config.MInsurance                      = GetResourceState('m-insurance') == 'started' -- [AUTO]

--──────────────────────────────────────────────────────────────────────────────
-- Shared Export                                                               [CORE]
-- [INFO] Provides shell data to other scripts when requested.
--──────────────────────────────────────────────────────────────────────────────
exports('getShells', function()
    return Config.Shells
end)

--──────────────────────────────────────────────────────────────────────────────
-- World Objects: Houses                                                       [EDIT]
-- [INFO] Static exterior objects used by the system. Extend as needed.
--──────────────────────────────────────────────────────────────────────────────
Config.HouseObjects                = {
    [1]  = { model = 'lf_house_04_' },
    [2]  = { model = 'lf_house_05_' },
    [3]  = { model = 'lf_house_07_' },
    [4]  = { model = 'lf_house_08_' },
    [5]  = { model = 'lf_house_09_' },
    [6]  = { model = 'lf_house_10_' },
    [7]  = { model = 'lf_house_11_' },
    [8]  = { model = 'lf_house_13_' },
    [9]  = { model = 'lf_house_15_' },
    [10] = { model = 'lf_house_16_' },
    [11] = { model = 'lf_house_17_' },
    [12] = { model = 'lf_house_18_' },
    [13] = { model = 'lf_house_19_' },
    [14] = { model = 'lf_house_20_' },
}

--──────────────────────────────────────────────────────────────────────────────
-- World Objects: Islands                                                      [EDIT]
-- [INFO] Floating/island props for special placements.
--──────────────────────────────────────────────────────────────────────────────
Config.Islands                     = {
    [1] = { model = 'qs_pineisland_01' },
    [2] = { model = 'qs_pineisland_02' },
    [3] = { model = 'qs_pineisland_03' },
    [4] = { model = 'qs_treeisland_01' },
    [5] = { model = 'qs_treeisland_02' },
    [6] = { model = 'qs_treeisland_03' },
    [7] = { model = 'qs_tropiisland_01' },
    [8] = { model = 'qs_tropiisland_02' },
    [9] = { model = 'qs_tropiisland_03' },
    -- Subham Collections
    [10] = { model = 'qs_island_01' },
    [11] = { model = 'qs_island_02' },
    [12] = { model = 'qs_island_03' },
    [13] = { model = 'qs_island_04' },
    [14] = { model = 'qs_island_05' },
    [15] = { model = 'qs_island_06' },
    [16] = { model = 'qs_island_07' },
}

--──────────────────────────────────────────────────────────────────────────────
-- IPL Interiors & Themes                                                      [EDIT]
-- [INFO] Preconfigured IPL entries (coords, themes, stash). Add/remove freely.
-- [INFO] For bob74_ipl entries, export returns the related IPL object.
--──────────────────────────────────────────────────────────────────────────────
Config.IplData                     = {
    {
        -- Apartment
        export       = function()
            return exports['bob74_ipl']:GetExecApartment1Object()
        end,
        defaultTheme = 'seductive',
        themes       = {
            { label = 'Modern',     value = 'modern',     price = 500, image = Config.ImagePath .. 'management/themes/apartment/modern.png' },
            { label = 'Moody',      value = 'moody',      price = 500, image = Config.ImagePath .. 'management/themes/apartment/moody.png' },
            { label = 'Vibrant',    value = 'vibrant',    price = 500, image = Config.ImagePath .. 'management/themes/apartment/vibrant.png' },
            { label = 'Monochrome', value = 'monochrome', price = 500, image = Config.ImagePath .. 'management/themes/apartment/monochrome.png' },
            { label = 'Seductive',  value = 'seductive',  price = 500, image = Config.ImagePath .. 'management/themes/apartment/seductive.png' },
            { label = 'Regal',      value = 'regal',      price = 500, image = Config.ImagePath .. 'management/themes/apartment/regal.png' },
            { label = 'Aqua',       value = 'aqua',       price = 500, image = Config.ImagePath .. 'management/themes/apartment/aqua.png' },
            -- { label = 'Sharp',   value = 'sharp',      price = 500, image = './assets/img/management/themes/apartment/sharp.png' }
        },
        exitCoords   = vec3(-787.44, 315.81, 217.64),
        iplCoords    = vec3(-787.78050000, 334.92320000, 215.83840000),
        stash        = { maxweight = 1000000, slots = 10 },
        shower       = {
            ptfxOffset = vec3(0.760, 15.928, 5.837),
            animationOffset = vec4(0.760, 15.928, 4.637, 175.785)
        },
        sink         = {
            ptfxOffset = vec3(-3.025, 17.0, 4.579),
            animationOffset = vec4(-2.561, 17.011, 4.600, 175.747),
        },
        cooking      = {
            animationOffset = vec4(-5.337, -5.332, 1.200, 91.176),
            recipes = Config.CookingRecipes
        },
        toilet       = {
            ptfxOffset = vec3(-2.954, 19.387, 5.113),
            animationOffset = vec4(-2.249, 19.414, 4.600, 177.101),
        }
    },
    {
        -- Office
        export       = function()
            return exports['bob74_ipl']:GetFinanceOffice1Object()
        end,
        defaultTheme = 'warm',
        themes       = {
            { label = 'Warm',         value = 'warm',         price = 500, image = Config.ImagePath .. 'management/themes/office/warm.png' },
            { label = 'Classical',    value = 'classical',    price = 500, image = Config.ImagePath .. 'management/themes/office/classical.png' },
            { label = 'Vintage',      value = 'vintage',      price = 500, image = Config.ImagePath .. 'management/themes/office/vintage.png' },
            { label = 'Contrast',     value = 'contrast',     price = 500, image = Config.ImagePath .. 'management/themes/office/contrast.png' },
            { label = 'Rich',         value = 'rich',         price = 500, image = Config.ImagePath .. 'management/themes/office/rich.png' },
            { label = 'Cool',         value = 'cool',         price = 500, image = Config.ImagePath .. 'management/themes/office/cool.png' },
            { label = 'Ice',          value = 'ice',          price = 500, image = Config.ImagePath .. 'management/themes/office/ice.png' },
            { label = 'Conservative', value = 'conservative', price = 500, image = Config.ImagePath .. 'management/themes/office/conservative.png' },
            { label = 'Polished',     value = 'polished',     price = 500, image = Config.ImagePath .. 'management/themes/office/polished.png' }
        },
        exitCoords   = vec3(-141.1987, -620.913, 168.8205),
        iplCoords    = vec3(-141.1987, -620.913, 168.8205),
        stash        = { maxweight = 1000000, slots = 10 },
    },
    {
        -- Clubhouse 1
        exitCoords = vec3(1121.037354, -3152.782471, -37.074707),
        iplCoords  = vec3(1107.04, -3157.399, -37.51859),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- Clubhouse 2
        exitCoords = vec3(997.028564, -3158.136230, -38.911377),
        iplCoords  = vec3(998.4809, -3164.711, -38.90733),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- Penthouse Casino
        exitCoords = vec3(980.83, 56.51, 116.16),
        iplCoords  = vec3(976.636, 70.295, 115.164),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- NightClub Warehouse
        exitCoords = vec3(-1520.88, -2978.54, -80.45),
        iplCoords  = vec3(-1505.783, -3012.587, -80.000),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- Vehicle Warehouse
        exitCoords = vec3(956.12, -2987.24, -39.65),
        iplCoords  = vec3(994.5925, -3002.594, -39.64699),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- 2133 Mad Wayne Thunder
        exitCoords = vec3(-1289.89, 449.83, 97.9),
        iplCoords  = vec3(-1288, 440.748, 97.69459),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- 2868 Hillcrest Avenue
        exitCoords = vec3(-758.3676, 619.0331, 144.1516),
        iplCoords  = vec3(-763.107, 615.906, 144.1401),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- Del Perro Heights, Apt 7
        exitCoords = vec3(-1453.86, -517.64, 56.93),
        iplCoords  = vec3(-1477.14, -538.7499, 55.5264),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- 4 Integrity Way, Apt 28
        exitCoords = vec3(-30.5111, -595.2331, 80.0309),
        iplCoords  = vec3(-9.9887, -582.3750, 79.4308),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- 4 Integrity Way, Apt 30
        exitCoords = vec3(-18.4784, -591.8953, 90.1148),
        iplCoords  = vec3(-29.0499, -574.6309, 88.7123),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    {
        -- Eclipse Towers, Apt 3
        exitCoords = vec3(-785.2117, 323.7787, 211.9972),
        iplCoords  = vec3(-773.407, 341.766, 211.397),
        stash      = { maxweight = 1000000, slots = 10 },
    },
    --Uncomment if you're going to use the experimental version
    --[[     {
        -- 3717 Mansion 1
        exitCoords = vec3(537.4049072265625, 749.0591430664062, 202.4766540527344),
        iplCoords  = vec3(533.525269, 725.169250, 202.293823),
        stash      = { maxweight = 1000000, slots = 10 },
        zone       = {
            points = {
                vec3(546.3588256835938, 809.3697509765625, 200.2849273681641),
                vec3(605.490478515625, 768.5374755859375, 203.1336212158203),
                vec3(540.7081909179688, 663.1214599609375, 162.0594940185547),
                vec3(466.2291259765625, 740.6036376953125, 198.61166381835935)

            }
        }
    },
    {
        -- 3717 Mansion 2
        exitCoords = vec3(-1666.8931884765625, 477.24078369140625, 129.33653259277344),
        iplCoords  = vec3(-1630.219727, 469.938477, 129.131836),
        stash      = { maxweight = 1000000, slots = 10 },
        zone       = {
            points = {
                vec3(-1709.6185302734375, 489.9075927734375, 129.32821655273438),
                vec3(-1643.3818359375, 528.0819091796875, 129.74615478515625),
                vec3(-1586.5408935546875, 427.3875122070313, 107.04544830322266),
                vec3(-1669.523193359375, 391.99224853515625, 89.07738494873047)
            }
        }
    },
    {
        -- 3717 Mansion 3
        exitCoords = vec3(-2587.67724609375, 1911.02001953125, 167.4906005859375),
        iplCoords  = vec3(-2602.984619, 1874.663696, 167.296753),
        stash      = { maxweight = 1000000, slots = 10 },
        zone       = {
            points = {
                vec3(-2610.777099609375, 1940.5137939453127, 171.35894775390625),
                vec3(-2531.7802734375, 1935.3734130859375, 171.43614196777344),
                vec3(-2548.482177734375, 1858.4361572265625, 171.41339111328125),
                vec3(-2665.338623046875, 1859.841552734375, 171.62115478515625)
            }
        }
    }, ]]
}

--──────────────────────────────────────────────────────────────────────────────
-- Construction System                                                          [EDIT]
-- [INFO] Enables timed/animated construction zones with worker NPCs.
-- [INFO] Durations are interpreted by the script (do not change units unless you know how it’s read).
--──────────────────────────────────────────────────────────────────────────────
Config.Construction                = false -- [EDIT] Enable construction timer/animations?

---@type table<string, Construction>
Config.Constructions               = { -- [EDIT] Per-model construction presets
    ['lf_house_04_'] = {
        duration = 10 * 60,            -- [EDIT]
        model = 'prop_pighouse2',      -- [EDIT] Temporary construction model
        peds = {                       -- [EDIT] Worker NPCs (add as needed)
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_05_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_07_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_08_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_09_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_10_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_11_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_13_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_15_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_16_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_17_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_18_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_19_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
    ['lf_house_20_'] = {
        duration = 10 * 60,
        model = 'prop_pighouse2',
        peds = {
            { model = 's_m_m_dockwork_01', offsets = vec3(0.0, 0.3, 0.0), heading = 65.54,  anim = 'base',   dict = 'anim@amb@office@boardroom@boss@male@' },
            { model = 's_m_m_gardener_01', offsets = vec3(1.0, 2.0, 0.0), heading = 179.27, anim = 'idle_a', dict = 'amb@world_human_picnic@female@idle_a' },
        }
    },
}

--──────────────────────────────────────────────────────────────────────────────
-- Shell / IPL / MLO Editor Controls                                           [EDIT]
-- [INFO] Keybinds used in edit modes for interiors and placement tools.
--──────────────────────────────────────────────────────────────────────────────
ActionControls                     = {
    leftClick              = { label = 'Left Click', codes = { 24 } },
    forward                = { label = 'Forward +/-', codes = { 33, 32 } },
    right                  = { label = 'Right +/-', codes = { 35, 34 } },
    up                     = { label = 'Up +/-', codes = { 52, 51 } },
    add_point              = { label = 'Add Point', codes = { 24 } },
    undo_point             = { label = 'Undo Last', codes = { 25 } },
    rotate_z               = { label = 'RotateZ +/-', codes = { 20, 73 } },
    rotate_z_scroll        = { label = 'RotateZ +/-', codes = { 17, 16 } },
    offset_z               = { label = 'Offset Z +/-', codes = { 44, 46 } },
    boundary_height        = { label = 'Z Boundary +/-', codes = { 20, 73 } },
    done                   = { label = 'Done', codes = { 191 } },
    cancel                 = { label = 'Cancel', codes = { 194 } },
    arrow_left             = { label = 'Previous', codes = { 174 } },
    arrow_right            = { label = 'Next', codes = { 175 } },
    -- Decorate (Modern Mode)
    place_object_on_ground = { label = 'Place Object on Ground', codes = { 47 } },
    toggle_free_mode       = { label = 'Toggle Free Mode', codes = { 167 } },
    toggle_cursor          = { label = 'Toggle Cursor', codes = { 166 } },
    toggle_editor_mode     = { label = 'Toggle Translate/Rotate', codes = { 311 } },
    toggle_gizmo_mode      = { label = 'Toggle Gizmo Mode', codes = { 244 } },
    toggle_free_camera     = { label = 'Toggle Free Camera', codes = { 170 } },
    focus_free_camera      = { label = 'Focus Object', codes = { 49 } },
    zoom                   = { label = 'Zoom +/-', codes = { 17, 16 } },

    -- DEPREACTED NEED TO CHECK
    increase_z             = { label = 'Z Boundary +/-', codes = { 180, 181 } },
    decrease_z             = { label = 'Z Boundary +/-', codes = { 21, 180, 181 } },
    change_shell           = { label = 'Change Shell +/-', codes = { 189, 190 } },
    leftApt                = { label = 'Previous Apartment', codes = { 174 } },
    rightApt               = { label = 'Next Apartment', codes = { 175 } },
}

--──────────────────────────────────────────────────────────────────────────────
-- NUI Decorate Keybinds                                                       [EDIT]
-- [INFO] JavaScript key names for the decoration UI (browser/NUI side).
-- These must match KeyboardEvent.key values.
-- See: https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values
--──────────────────────────────────────────────────────────────────────────────
Config.DecorateKeybinds            = {
    toggle_cursor          = 'F5',    -- [EDIT] Show/hide cursor
    toggle_hide_decorate   = 'F6',    -- [EDIT] Show/hide decoration UI
    place_object_on_ground = 'g',     -- [EDIT] Place furniture on ground
    toggle_editor_mode     = 'k',     -- [EDIT] Toggle translate/rotate mode
    toggle_space_mode      = 'q',     -- [EDIT] Toggle world/local space
    toggle_gizmo_mode      = 'm',     -- [EDIT] Toggle gizmo mode
    toggle_free_camera     = 'F3',    -- [EDIT] Toggle free camera
    buy_object             = 'Enter', -- [EDIT] Confirm / buy object
}

--──────────────────────────────────────────────────────────────────────────────
-- Door Logic                                                                  [EDIT]
-- [INFO] Interaction distances and duplicate detection.
--──────────────────────────────────────────────────────────────────────────────
Config.DoorDistance                = 1.5 -- [EDIT] Interaction distance for doors
Config.DoorDuplicateDistance       = 3.0 -- [EDIT] Merge doors if closer than this

--──────────────────────────────────────────────────────────────────────────────
-- Dynamic Doors & Credit Toggle                                               [EDIT]
-- [INFO] Dynamic doors require: setr game_enableDynamicDoorCreation "true" in server.cfg
--──────────────────────────────────────────────────────────────────────────────
Config.DynamicDoors                = true  -- [EDIT] Enable dynamic doors?
Config.CreditToggleActiveInDefault = false -- [EDIT] Default credit toggle state

--──────────────────────────────────────────────────────────────────────────────
-- Free Camera Options                                                          [EDIT]
-- [INFO] Tuning for editor/preview camera movement.
--──────────────────────────────────────────────────────────────────────────────
CameraOptions                      = { -- [EDIT]
    lookSpeedX  = 1000.0,              -- Horizontal camera speed.
    lookSpeedY  = 1000.0,              -- Vertical camera speed.
    moveSpeed   = 20.0,                -- Free-move speed.
    climbSpeed  = 10.0,                -- Up/down speed.
    rotateSpeed = 20.0,                -- Rotation speed.
}

--──────────────────────────────────────────────────────────────────────────────
-- Custom House Creation                                                        [ADV]
-- [INFO] Manual house definitions. Prefer the in-game creator (F7) unless you
-- know exactly what you’re doing.
--──────────────────────────────────────────────────────────────────────────────
CreatingHouse                      = {} -- [CORE] Runtime buffer (leave as is)

---@type table<string, House>
Config.Houses                      = { -- [EDIT] Add manual houses here (advanced)
    -- Example (keep commented as reference):
    -- ['Test House'] = {
    --     id = 1, owned = 0, price = 0, locked = true, address = 'Nikola p1', tier = 1,
    --     coords = {
    --         enter = { x=1303.0059, y=-527.4684, z=71.4657, h=311.8610 },
    --         PolyZone = {
    --             usePolyZone = true, thickness = 25.0,
    --             points = {
    --                 { x=1303.5743, y=-500.4180, z=71.0 },
    --                 { x=1293.0419, y=-537.6561, z=71.0 },
    --                 { x=1311.5504, y=-544.9465, z=71.0 },
    --                 { x=1327.7316, y=-498.8352, z=71.0 },
    --             }
    --         },
    --         cam  = { x=1303.0059, y=-527.4684, z=71.4657, h=311.8610, yaw=-10.0 },
    --         exit = { x=1264.6019, y=-545.8494, z=27.5634, h=246.8610 },
    --         interiorCoords = { x=1266.7444, y=-544.3600, z=26.5542, w=311.8610 },
    --         shellCoords    = { x=1266.7444, y=-544.3600, z=26.5542, h=311.8610 },
    --     },
    --     garage = {
    --         max = 4, access = {},
    --         slots = {
    --             [1] = { x=-125.6479, y=-1297.6467, z=29.4452, h=93.5560 },
    --         },
    --         coords = { x=-228.8, y=-990.41, z=29.34, h=267.02 },
    --     },
    -- }
}

--──────────────────────────────────────────────────────────────────────────────
-- Free Mode Keys                                                               [EDIT]
-- [INFO] Key table and bindings for free-move/edit modes (placement/rotation).
--──────────────────────────────────────────────────────────────────────────────
Keys                               = {
    ['ESC'] = 322,
    ['F1'] = 288,
    ['F2'] = 289,
    ['F3'] = 170,
    ['F5'] = 166,
    ['F6'] = 167,
    ['F7'] = 168,
    ['F8'] = 169,
    ['F9'] = 56,
    ['F10'] = 57,
    ['~'] = 243,
    ['1'] = 157,
    ['2'] = 158,
    ['3'] = 160,
    ['4'] = 164,
    ['5'] = 165,
    ['6'] = 159,
    ['7'] = 161,
    ['8'] = 162,
    ['9'] = 163,
    ['-'] = 84,
    ['='] = 83,
    ['BACKSPACE'] = 177,
    ['TAB'] = 37,
    ['Q'] = 44,
    ['W'] = 32,
    ['E'] = 38,
    ['R'] = 45,
    ['T'] = 245,
    ['Y'] = 246,
    ['U'] = 303,
    ['P'] = 199,
    ['['] = 39,
    [']'] = 40,
    ['ENTER'] = 18,
    ['CAPS'] = 137,
    ['A'] = 34,
    ['S'] = 8,
    ['D'] = 9,
    ['F'] = 23,
    ['G'] = 47,
    ['H'] = 74,
    ['K'] = 311,
    ['L'] = 182,
    ['LEFTSHIFT'] = 21,
    ['Z'] = 20,
    ['X'] = 73,
    ['C'] = 26,
    ['V'] = 0,
    ['B'] = 29,
    ['N'] = 249,
    ['M'] = 244,
    [','] = 82,
    ['.'] = 81,
    ['LEFTCTRL'] = 36,
    ['LEFTALT'] = 19,
    ['SPACE'] = 22,
    ['RIGHTCTRL'] = 70,
    ['HOME'] = 213,
    ['PAGEUP'] = 10,
    ['PAGEDOWN'] = 11,
    ['DELETE'] = 178,
    ['LEFT'] = 174,
    ['RIGHT'] = 175,
    ['TOP'] = 27,
    ['DOWN'] = 173,
    ['NENTER'] = 201,
    ['N4'] = 108,
    ['N5'] = 60,
    ['N6'] = 107,
    ['N+'] = 96,
    ['N-'] = 97,
    ['N7'] = 117,
    ['N8'] = 61,
    ['N9'] = 118
}

--──────────────────────────────────────────────────────────────────────────────
-- qs-smartphone · Housing app                                                 [EDIT]
-- [INFO] Remote actions from the phone app (housing:phone* callbacks).
--──────────────────────────────────────────────────────────────────────────────
Config.PhoneHousing                = {
    requireProximityForPurchase = true, -- [EDIT] Player must be near entrance to buy/rent from phone
    purchaseMaxDistance         = 48.0, -- [EDIT] Meters from house entrance
    actionCooldownSeconds       = 2,    -- [EDIT] Per-player throttle for phone housing actions
}

--──────────────────────────────────────────────────────────────────────────────
-- Debug                                                                        [EDIT]
-- [INFO] Verbose logging. Keep disabled on production servers.
--──────────────────────────────────────────────────────────────────────────────
Config.Debug                       = true  -- [EDIT] Debug mode
Config.ZoneDebug                   = false -- [EDIT] Zone/poly debug






