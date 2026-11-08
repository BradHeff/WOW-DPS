-- ReputationData.lua
-- How to raise each reputation, for the Reputations page's popout (Reputations.lua).
-- PathForeverData.Reputations[factionID] = { sections = { { header, body }, ... }, vendors = {...}, rewards = {...} }
--
--   Keyed by the client's own faction ID (the one GetFactionDataByIndex returns, and the
--   first column of research/db2/Faction.csv), so nothing here decides which reputations a
--   character has: the page lists the ones the game reports, and looks each one up here.
--   A reputation with no entry shows "Nothing on file for this one yet".
--   sections : { header, body } blocks. Plain ASCII, " - " bullets, no numbers that only
--              hold for another version of the game: where a number is given it is from the
--              Classic guides listed below.
--
-- ---- Sources (2026-10-30) -------------------------------------------
-- The Classic guides on almarsguides.com (Bloodsail Buccaneers, Argent Dawn, Thorium
-- Brotherhood, Timbermaw Hold, Cenarion Circle, Hydraxian Waterlords, Ravenholdt,
-- Shen'dralar, Darkmoon Faire, Battlegrounds) and warcrafttavern.com's Bloodsail guide;
-- for the new Forever factions warcrafttavern.com's "Waylaid Supplies factions spotted in
-- WoW Forever" and kami-labs.fr's list of the leaked reputation names. None of it is
-- Wowhead Forever, so every entry is "from Classic" until it has been checked in the game;
-- check each one against the in-game reputation window and foreverdb.net after launch.
-- Never copy another addon's text here.

PathForeverData = PathForeverData or {}


-- the capital cities share one set of ways: quests, hand-ins and Alterac Valley
local function Capital(name, side, extra)
    return {
        sections = {
            { "Earn it", "Quests for the city and the zones around it, each one gives reputation as well as XP and gold.\n - Hand in the items the city asks for where it offers repeatable turn-ins, such as cloth.\n - Alterac Valley hand-ins raise every capital of your side at once."
                .. (extra and ("\n - " .. extra) or "") },
            { "Good to know", "Reputation from quests shrinks once the quest is far below your level, so do them as you pass." },
        },
    }
end

PathForeverData.Reputations = {
    -- ---- Alliance capitals ----
    [72] = Capital("Stormwind", "Alliance"),
    [47] = Capital("Ironforge", "Alliance"),
    [69] = Capital("Darnassus", "Alliance"),
    [54] = Capital("Gnomeregan Exiles", "Alliance", "Killing the troggs and leper gnomes in Gnomeregan, and the quests there, raise it faster than anything else."),
    -- ---- Horde capitals ----
    [76] = Capital("Orgrimmar", "Horde"),
    [81] = Capital("Thunder Bluff", "Horde"),
    [68] = Capital("Undercity", "Horde"),
    [530] = Capital("Darkspear Trolls", "Horde", "Its quests start on the Echo Isles and around Sen'jin Village in Durotar."),

    -- ---- Steamwheedle Cartel ----
    [169] = {
        sections = {
            { "Earn it", "Raise the four towns, not this line: its standing follows them.\n - Each town raises from its own quests and from killing the pirates and bandits that trouble it." },
        },
    },
    [21] = {
        sections = {
            { "Earn it", "Quests in Stranglethorn Vale and Booty Bay.\n - Kill Bloodsail pirates around the Stranglethorn coast." },
            { "Good to know", "Killing Booty Bay's guards and Bruisers lowers it and every Steamwheedle town, and raises the Bloodsail Buccaneers. The other towns turn hostile when it falls." },
        },
    },
    [470] = {
        sections = {
            { "Earn it", "Quests in the Barrens and Ratchet.\n - Kill the Southsea pirates near Ratchet." },
        },
    },
    [369] = {
        sections = {
            { "Earn it", "Quests in Tanaris and Gadgetzan.\n - Kill the pirates and bandits around Tanaris." },
        },
    },
    [577] = {
        sections = {
            { "Earn it", "Quests in Winterspring and Everlook." },
        },
    },
    [87] = {
        sections = {
            { "Earn it", "Kill Booty Bay's people. Open the reputation window, select Booty Bay and tick At War, then untick it for the Bloodsail Buccaneers so you do not fight your new friends.\n - The Booty Bay Bruisers in the town are the quickest, but they are level 57 elites that net and shoot you. Fight them near the water.\n - Blackwater Raiders in Faldir's Cove give less but are easier, and only count while they are around your level (about 35 to 46)." },
            { "Good to know", "The climb from Hated to Neutral is long, about a thousand kills. Booty Bay quests and Bloodsail kills made while leveling push you further down. Standing normally stops at Friendly; Honored needs you to hold back the last quest." },
            { "Rewards", "Neutral: the Buccaneer's Uniform from the quest Dressing the Part.\n - Friendly: the Bloodsail Admiral's Hat, which calls a parrot pet." },
            { "Cost", "Steamwheedle towns turn hostile, their quests close and their banks and auction houses stop working for you." },
        },
    },

    -- ---- Zones and dungeons ----
    [349] = {
        sections = {
            { "Earn it", "Kill Syndicate members in Hillsbrad Foothills and the Alterac Mountains, about 5 reputation each, up to Honored.\n - Ravenholdt's quests add the last stretch of Honored.\n - After Honored, hand in Heavy Junkboxes, which rogues pickpocket from level 55 to 60 mobs in the Blackrock Spires." },
        },
    },
    [576] = {
        sections = {
            { "Earn it", "Kill the other furbolg tribes: ordinary ones are 5 reputation, named chiefs 15.\n - Hand in Deadwood Headdress Feathers (Felwood) or Winterfall Spirit Beads (Winterspring) for 50 each, repeatable.\n - Large camps, such as the one in northern Felwood, are the fastest." },
            { "Rewards", "Enchanting and alchemy recipes (Enchant Weapon - Agility, Transmute Earth to Water) and, at Exalted, a trinket that calls a furbolg to fight with you." },
        },
    },
    [92] = {
        sections = {
            { "Earn it", "Quests for the Gelkis, and kill Magram centaurs." },
            { "Good to know", "The two clans are enemies: every point with one costs you with the other." },
        },
    },
    [93] = {
        sections = {
            { "Earn it", "Quests for the Magram, and kill Gelkis centaurs." },
            { "Good to know", "The two clans are enemies: every point with one costs you with the other." },
        },
    },
    [609] = {
        sections = {
            { "Earn it", "Silithus quests, including the repeatable one where you hand in 10 Encrypted Twilight Texts from Twilight camps for 500 reputation. Going from Friendly to Exalted is about 86 hand-ins.\n - Ahn'Qiraj raids are the fastest way, for groups that can run them." },
        },
    },
    [529] = {
        sections = {
            { "Earn it", "Kill Scourge in the Plaguelands and in Stratholme and Scholomance: ordinary mobs about 5 to 10, bosses about 150 to 250.\n - Wear an Argent Dawn Commission and collect Scourgestones. Each hand-in is 50 reputation, and its mark adds 75. 20 Minion's make 10 Invader's, and 10 Invader's make a Corrupter's." },
            { "Good to know", "Stratholme's Baron Rivendare can drop a rare mount." },
        },
    },
    [59] = {
        sections = {
            { "Earn it", "Start with the faction's quests in Searing Gorge (about 2,000 of the first 3,000).\n - To Friendly: hand in Incendosaur Scales and Coal with Heavy Leather, Iron Bars or Kingsblood.\n - To Honored: hand in Dark Iron Residue from Blackrock Depths trash, about 960.\n - To Exalted: at Lokhtos Darkbargainer in Blackrock Depths, hand in Dark Iron Ore, Core Leather, or a Fiery Core, Lava Core or Blood of the Mountain." },
            { "Rewards", "Blacksmithing plans, mostly sold in Blackrock Depths." },
        },
    },
    [749] = {
        sections = {
            { "Earn it", "Molten Core's ordinary mobs raise it up to the end of Honored; after Revered only its bosses do.\n - Duke Hydraxis's quests in Azshara are the way in." },
        },
    },
    [270] = {
        sections = {
            { "Earn it", "Run Zul'Gurub: its bosses and mobs raise it.\n - Hand in the coins and bijous the raid drops to the tribe's NPCs on Yojamba Isle." },
        },
    },
    [809] = {
        sections = {
            { "Earn it", "Inside Dire Maul, turn in Librams (Focus, Protection, Rapidity) that you make from Dire Maul drops and dungeon materials such as a Pristine Black Diamond.\n - Each material is unique, so turn a Libram in as soon as you have its parts." },
        },
    },
    [909] = {
        sections = {
            { "Earn it", "Hand in Thorium Widgets, Evil Bat Eyes and Glowing Scorpid Blood to start.\n - Later, hand in complete Darkmoon decks. Each deck needs an Ace from a boss in the level 60 dungeons." },
        },
    },
    [910] = {
        sections = {
            { "Earn it", "Kill the creatures of the Ahn'Qiraj raids. It needs raids, so it waits until they open." },
        },
    },

    -- ---- Battlegrounds ----
    [70] = { sections = { { "Who", "Everyone starts Hated." }, { "Earn it", "Not known yet. The Syndicate is a human criminal organization in Hillsbrad Foothills and Alterac Mountains, and what raises it is decided on Blizzard's servers." } } },
    [729] = { sections = { { "Earn it", "Win Alterac Valley, kill enemy NPCs, destroy towers, and hand in Armor Scraps and Blood in the valley." } } },
    [730] = { sections = { { "Earn it", "Win Alterac Valley, kill enemy NPCs, destroy towers, and hand in Armor Scraps and Blood in the valley." } } },
    [889] = { sections = { { "Earn it", "Capture flags and win Warsong Gulch." } } },
    [890] = { sections = { { "Earn it", "Capture flags and win Warsong Gulch." } } },
    [510] = { sections = { { "Earn it", "Collect resources in Arathi Basin: a little for every 200 your side gathers, and a win." } } },
    [509] = { sections = { { "Earn it", "Collect resources in Arathi Basin: a little for every 200 your side gathers, and a win." } } },

    -- ---- New in Forever ----
    -- who can earn each and where it starts is from foreverdb.net's reputation pages (the Forever client,
    -- build 1.60.1.70658, 2026-10-28); how a faction is earned is mostly not in the client, so a guide
    -- says so rather than guess. The two trade factions' gains are from early write-ups.
    [2586] = {
        sections = {
            { "Earn it", "Turn in supply crates and writs from your professions. A writ gives reputation with this faction and with Durotar Supply and Logistics.\n - Merchant's Favor is its currency, which both trade factions accept." },
            { "Where", "Alliance only: Horde characters cannot earn it. It opens at level 10. The main camp is at Three Corners in Redridge Mountains." },
        },
    },
    [2587] = {
        sections = {
            { "Earn it", "Turn in supply crates and writs from your professions. A writ gives reputation with this faction and with the Azeroth Commerce Authority.\n - Merchant's Favor is its currency, which both trade factions accept." },
            { "Good to know", "Horde only: Alliance characters cannot earn it. The Performance Bonus profession perk gives a chance of extra Merchant's Favor when you hand in a supply crate." },
        },
    },
    [2740] = {
        sections = {
            { "Who", "Alliance only. High Order Skyborne start Friendly, other Alliance start Neutral." },
            { "Earn it", "How it is earned is not known yet. It is tied to the City of Dalaran dungeon: Blizzard says its sewer entrance opens after you earn the Kirin Tor's trust." },
        },
    },
    [2799] = {
        sections = {
            { "Who", "Alliance only. It starts at Neutral." },
            { "Earn it", "Play the Darkspear Islands battleground (15 against 15, with a central flag and strategic points); its Call to Arms and its reputation events give reputation.\n - Queue at a battlemaster in any major capital, or at the Theramore base at Northwatch, where the base has vendors and quests for it." },
            { "Good to know", "Reaching Exalted with this faction or the Darkspear Raiders earns the Master of Darkspear Islands challenge." },
        },
    },
    [2798] = {
        sections = {
            { "Who", "Horde only. It starts at Neutral." },
            { "Earn it", "Play the Darkspear Islands battleground (15 against 15, with a central flag and strategic points); its Call to Arms and its reputation events give reputation.\n - The Darkspear Raiders' base at the Merchant Coast has vendors for the rewards." },
            { "Good to know", "Reaching Exalted with this faction or the Theramore Expeditionary Force earns the Master of Darkspear Islands challenge." },
        },
    },
    [2827] = {
        sections = {
            { "Who", "Everyone. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. It is the Steamwheedle Cartel's new port on the eastern sea route, Powderfuse Port, where gnolls, ogres, the Twilight's Hammer and the Brotherhood of the Horse also live." },
        },
    },
    [2747] = {
        sections = {
            { "Who", "Everyone. It starts at Hostile." },
            { "Earn it", "Use Ceremonial Mastic: each one is 150 reputation. No rewards need this standing yet." },
            { "Good to know", "A furbolg tribe of Mount Hyjal, untouched by corruption." },
        },
    },
    [2782] = {
        sections = {
            { "Who", "Horde only. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. They are former Twilight's Hammer members, exiled for betraying their false prophets. No rewards need this standing yet." },
        },
    },
    [2826] = {
        sections = {
            { "Who", "Alliance only. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. They are outcast Stormwind cavalry who built a home on the eastern coast, in one of the new zones. No rewards need this standing yet." },
        },
    },
    [2719] = {
        sections = {
            { "Who", "Everyone. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. Young nature lovers who explore and protect the wilds. No rewards need this standing yet." },
        },
    },
    [2787] = {
        sections = {
            { "Who", "Horde only. It starts at Neutral, and in Forever the most you can reach is Honored." },
            { "Earn it", "How it is earned is not known yet. It is the Horde's shamans and druids keeping nature in balance; its quests use Titan Relics (Elder Knowledge, Lost Relic Carry, then Earthen Echo or Prehistoric Prism)." },
        },
    },
    [2641] = {
        sections = {
            { "Who", "Everyone. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. A hastily gathered group of druids that works with both the Alliance and the Horde against the Nightmare Incursions. No rewards need this standing yet." },
        },
    },
    [2765] = {
        sections = {
            { "Who", "Everyone. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. A branch of the Cenarion Circle that guards Mount Hyjal and welcomes anyone willing to push back the forces of evil." },
        },
    },
    [2779] = {
        sections = {
            { "Who", "Alliance only. High Order Skyborne start Friendly, other Alliance start Neutral." },
            { "Earn it", "How it is earned is not known yet. The Skyborne descendants of the Highborne of Eldre'Thalas, whose starting area is Zephras Isle (levels 1 to 12). No rewards need this standing yet." },
        },
    },
    [2778] = {
        sections = {
            { "Who", "Horde only. Skyborne Windshapers start Friendly, other Horde start Neutral." },
            { "Earn it", "How it is earned is not known yet. The Skyborne shaman leaders of Zephras Isle, who study the elemental plane. No rewards need this standing yet." },
        },
    },
    [2758] = {
        sections = {
            { "Who", "Everyone. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. They are the secretive druids of Shadowgale Forest on Zephras Isle; their quests are around Nightclaw Cavern." },
            { "Good to know", "The rewards are the Azure and Cloudy tailoring and blacksmithing patterns and plans, then the Shadowgale Squirrel pet at Revered and the Nightclaw Mantle at Exalted, which also gives the title of the Nightclaw." },
        },
    },
    [2819] = {
        sections = {
            { "Who", "Everyone. It starts at Neutral." },
            { "Earn it", "How it is earned is not known yet. They are the night elf jailers and marshals of an underground prison network." },
        },
    },
    [471] = {
        sections = {
            { "Who", "Dwarves, Humans, Night Elves and Gnomes. It starts at Neutral and stops at Friendly." },
            { "Earn it", "The dwarves of Aerie Peak are not part of the Alliance but welcome it, and see the Horde as enemies. How it is earned is not known yet. No rewards need this standing." },
        },
    },
    [630] = {
        sections = {
            { "Who", "Horde only. It starts at Neutral." },
            { "Earn it", "The Horde's ravasaur tamers of Un'Goro Crater. How it is earned is not known yet. No rewards need this standing." },
        },
    },
    [589] = {
        sections = {
            { "Who", "Alliance only. It starts at Neutral." },
            { "Earn it", "The reclusive night elves who raise and train wintersabers in Winterspring. How it is earned is not known yet. No rewards need this standing." },
        },
    },
}

-- ---- Vendors and rewards ----
-- vendors : { { name =, zone =, map =, x =, y = } }, the first with a map is the one "Mark vendor on map" marks
--           (map = the client's uiMapID, x and y as 0-1 on that map).
-- rewards : { { standing, item name, item id } } in the order the vendor lists them; the popout colors the
--           ones the character has reached.
-- Reward lists and item IDs are the Forever client's own, as read by foreverdb.net (build 1.60.1.70658,
-- 2026-10-28): the items that require standing with the faction. Vendors and their positions are from
-- Wowhead Forever's NPC pages (2026-10-30); the map position is the NPC's own. Where no vendor is given,
-- Forever has not said who sells the rewards yet, so none is guessed. The capitals have no standing
-- rewards in the client at all. Classic-only quartermaster extras (Armaments of Battle, Mantles of the
-- Dawn) are left out: they are quests, or not in the client's list.
local function Sells(id, vendors, rewards)
    local e = PathForeverData.Reputations[id]
    if not e then return end
    e.vendors = vendors
    local list = {}
    for _, group in ipairs(rewards) do
        for i = 2, #group do list[#list + 1] = { group[1], group[i][1], group[i][2] } end
    end
    e.rewards = list
end

Sells(529, {
    { name = "Argent Quartermaster Hasana", zone = "The Bulwark, Tirisfal Glades", map = 1420, x = 0.832, y = 0.682 },
    { name = "Argent Quartermaster Lightspark", zone = "Chillwind Camp, Western Plaguelands", map = 1422, x = 0.428, y = 0.838 },
    { name = "Quartermaster Miranda Breechlock", zone = "Light's Hope Chapel, Eastern Plaguelands", map = 1423, x = 0.814, y = 0.600 },
}, {
    { "Friendly", { "Enriched Manna Biscuit", 13724 } },
    { "Honored",
        { "Recipe: Transmute Air to Fire", 13482 }, { "Drinkable Stratholme Holy Water", 227813 },
        { "Formula: Enchant Bracer - Mana Regeneration", 19446 }, { "Formula: Powerful Anti-Venom", 19442 },
        { "Hallowed Brazier", 22014 }, { "Pattern: Argent Boots", 19216 }, { "Pattern: Dawn Treaders", 19328 },
        { "Plans: Girdle of the Dawn", 19203 }, { "Sam's Tome", 1164 } },
    { "Revered",
        { "Plans: Dawnbringer Shoulders", 12698 }, { "Blessed Sunfruit", 13810 }, { "Blessed Sunfruit Juice", 13813 },
        { "Formula: Enchant Bracer - Healing", 19447 }, { "Pattern: Argent Shoulders", 19217 },
        { "Pattern: Golden Mantle of the Dawn", 19329 }, { "Plans: Gloves of the Dawn", 19205 },
        { "Plans: Icebane Gauntlets", 22704 } },
    { "Exalted", { "Plans: Icebane Breastplate", 22703 } },
})

Sells(609, {
    { name = "Mishta", zone = "Cenarion Hold, Silithus" },
}, {
    { "Friendly",
        { "Pattern: Bileblister Claws", 275586 }, { "Pattern: Broodwatcher's Clenchers", 275595 },
        { "Pattern: Hivethrasher's Claws", 275589 }, { "Pattern: Scalegut Clenchers", 275592 },
        { "Pattern: Swarmtender's Gloves", 275583 }, { "Pattern: Venomspew Gloves", 275580 },
        { "Plans: Clutchlord's Grips", 275601 }, { "Plans: Goregasher Grips", 275598 },
        { "Formula: Enchanted Repellent", 234272 }, { "Formula: Scroll: Wrath of the Swarm", 234271 },
        { "Formula: Enchant Cloak - Greater Fire Resistance", 20732 }, { "Pattern: Cenarion Herb Bag", 22310 },
        { "Pattern: Sylvan Shoulders", 22772 }, { "Scroll: Create Signet of Beckoning", 229897 } },
    { "Honored",
        { "Pattern: Bileblister Boots", 275588 }, { "Pattern: Bileblister Girdle", 275587 },
        { "Pattern: Broodwatcher's Belt", 275596 }, { "Pattern: Broodwatcher's Treaders", 275597 },
        { "Pattern: Hivethrasher's Boots", 275591 }, { "Pattern: Hivethrasher's Girdle", 275590 },
        { "Pattern: Scalegut Belt", 275593 }, { "Pattern: Scalegut Treaders", 275594 },
        { "Pattern: Swarmtender's Cord", 275584 }, { "Pattern: Swarmtender's Footpads", 275585 },
        { "Pattern: Venomspew Cord", 275581 }, { "Pattern: Venomspew Footpads", 275582 },
        { "Plans: Clutchlord's Stompers", 275603 }, { "Plans: Clutchlord's Support", 275602 },
        { "Plans: Goregasher Stompers", 275600 }, { "Plans: Goregasher Support", 275599 },
        { "Formula: Enchant Cloak - Greater Nature Resistance", 20733 }, { "Pattern: Sylvan Crown", 22773 } },
    { "Revered",
        { "Pattern: Gaea's Embrace", 22683 }, { "Pattern: Satchel of Cenarius", 22312 },
        { "Pattern: Sylvan Vest", 22774 }, { "Plans: Jagged Obsidian Shield", 22219 } },
    { "Exalted", { "Plans: Obsidian Mail Tunic", 22221 } },
})

Sells(59, {
    { name = "Lokhtos Darkbargainer", zone = "The Grim Guzzler, Blackrock Depths" },
}, {
    { "Friendly",
        { "Plans: Dark Iron Bracers", 17051 }, { "Formula: Enchant Weapon - Strength", 19444 },
        { "Pattern: Corehound Boots", 17022 }, { "Pattern: Flarecore Gloves", 17018 },
        { "Pattern: Molten Helm", 17023 }, { "Recipe: Transmute Elemental Fire", 20761 } },
    { "Honored",
        { "Plans: Dark Iron Destroyer", 17060 }, { "Plans: Dark Iron Reaver", 17059 },
        { "Plans: Fiery Chain Girdle", 17049 }, { "Formula: Enchant Cloak - Greater Fire Resistance", 229008 },
        { "Formula: Enchant Cloak - Greater Nature Resistance", 229009 }, { "Formula: Enchant Weapon - Mighty Spirit", 19448 },
        { "Pattern: Black Dragonscale Boots", 17025 }, { "Pattern: Flarecore Mantle", 17017 },
        { "Pattern: Flarecore Robe", 19219 }, { "Pattern: Lava Belt", 19330 }, { "Plans: Dark Iron Helm", 19206 } },
    { "Revered",
        { "Plans: Dark Iron Leggings", 17052 }, { "Plans: Fiery Chain Shoulders", 17053 },
        { "Formula: Enchant Weapon - Mighty Intellect", 19449 }, { "Pattern: Chromatic Gauntlets", 19331 },
        { "Pattern: Corehound Belt", 19332 }, { "Pattern: Flarecore Leggings", 19220 },
        { "Pattern: Molten Belt", 19333 }, { "Plans: Black Amnesty", 19208 }, { "Plans: Blackfury", 19209 },
        { "Plans: Dark Iron Gauntlets", 19207 } },
    { "Exalted",
        { "Plans: Blackguard", 19211 }, { "Plans: Dark Iron Boots", 20040 }, { "Plans: Ebon Hand", 19210 },
        { "Plans: Nightfall", 19212 } },
})

Sells(576, {
    { name = "Meilosh", zone = "Timbermaw Hold, Felwood" },
}, {
    { "Friendly",
        { "Recipe: Transmute Earth to Water", 13484 }, { "Formula: Enchant 2H Weapon - Agility", 22392 },
        { "Pattern: Warbear Harness", 20253 }, { "Pattern: Warbear Woolies", 20254 } },
    { "Honored",
        { "Formula: Enchant Weapon - Agility", 19445 }, { "Pattern: Heavy Timbermaw Belt", 19202 },
        { "Pattern: Might of the Timbermaw", 19326 }, { "Pattern: Wisdom of the Timbermaw", 19215 } },
    { "Revered",
        { "Formula: Enchant Shield - Law of Nature", 228982 }, { "Pattern: Mantle of the Timbermaw", 19218 },
        { "Plans: Bagh Nakh", 251470 }, { "Plans: Stormcarver", 251469 },
        { "Pattern: Heavy Timbermaw Boots", 19204 }, { "Pattern: Timbermaw Brawlers", 19327 } },
    { "Exalted", { "Defender of the Timbermaw", 21326 } },
})

Sells(270, {
    { name = "Rin'wosho the Trader", zone = "Yojamba Isle" },
}, {
    { "Friendly",
        { "Formula: Brilliant Mana Oil", 20757 }, { "Pattern: Bloodvine Boots", 19766 },
        { "Pattern: Primal Batskin Bracers", 19771 }, { "Plans: Bloodsoul Gauntlets", 19778 },
        { "Plans: Darksoul Shoulders", 19781 }, { "Recipe: Greater Dreamless Sleep", 20012 },
        { "Schematic: Bloodvine Lens", 20001 } },
    { "Honored",
        { "Formula: Brilliant Wizard Oil", 20756 }, { "Formula: Magnificent Trollshine", 232610 },
        { "Pattern: Blood Tiger Shoulders", 19773 }, { "Pattern: Bloodvine Leggings", 19765 },
        { "Pattern: Primal Batskin Gloves", 19770 }, { "Plans: Bloodsoul Shoulders", 19777 },
        { "Plans: Darksoul Leggings", 19780 }, { "Recipe: Major Troll's Blood Elixir", 20014 },
        { "Schematic: Bloodvine Goggles", 20000 } },
    { "Revered",
        { "Pattern: Blood Tiger Breastplate", 19772 }, { "Pattern: Bloodvine Vest", 19764 },
        { "Pattern: Primal Batskin Jerkin", 19769 }, { "Plans: Bloodsoul Breastplate", 19776 },
        { "Plans: Darksoul Breastplate", 19779 }, { "Recipe: Mageblood Elixir", 20011 } },
    { "Exalted", { "Recipe: Living Action Potion", 20013 } },
})

-- Forever's new rewards: who sells them is not known yet
Sells(21, nil, {
    { "Friendly", { "Deckswabber's Mitts", 274745 }, { "Sea Giant's Toe Ring", 274746 }, { "Soggy Boots", 274747 } },
    { "Honored", { "Booty Bay Bruiser's Buckshot", 274748 }, { "Souvenir Sea Shell", 274749 } },
    { "Revered", { "Tough Guy's Eyepatch", 274022 } },
})
Sells(749, nil, {
    { "Revered", { "Enchanted Sigil: Flowing Waters", 228979 }, { "Plans: Icebane Bracers", 22705 } },
})

-- ---- New in Forever: rewards (the client's lists, foreverdb.net 2026-10-28; no vendor is named for them) ----
Sells(2586, nil, {
    { "Honored", { "Advertising License Application", 270888 } },
    { "Exalted", { "Azeroth Commerce Authority Tabard", 262765 }, { "Skyborne Tabard", 280449 } },
})
Sells(2587, nil, {
    { "Honored", { "Advertising License Application", 270887 } },
    { "Exalted", { "Durotar Supply and Logistics Tabard", 262764 } },
})
Sells(2740, nil, {
    { "Friendly",
        { "Pattern: Azure Gustwoven Hood", 276986 }, { "Pattern: Azure Gustwoven Spaulders", 276987 },
        { "Pattern: Azure Stormsewn Cowl", 276990 }, { "Pattern: Azure Stormsewn Epaulets", 276991 },
        { "Pattern: Azure Windraveled Cover", 276988 }, { "Pattern: Azure Windraveled Drapes", 276989 },
        { "Plans: Azure Skyforged Helm", 276984 }, { "Plans: Azure Skyforged Pauldrons", 276985 } },
    { "Exalted", { "Kirin Tor Tabard", 285327 } },
})
Sells(2799, nil, {
    { "Friendly", { "Enriched Seal", 271903 }, { "Volunteer's Lucky Seal", 271906 } },
    { "Honored",
        { "Expeditionary's Cape", 271907 }, { "Militant's Band", 271913 }, { "Seal of the Expedition", 271917 },
        { "Theramore Signet", 271908 } },
    { "Revered",
        { "Clever Expeditionary's Spellblade", 271928 }, { "Guerrilla's Jagged Mace", 271936 },
        { "Insurgent's Manifesto", 271932 }, { "Rebels' Rugged Reaper", 271924 } },
    { "Exalted",
        { "Theramore Epaulets", 271956 }, { "Theramore Gauntlets", 271940 }, { "Theramore Gloves", 271948 },
        { "Theramore Handguards", 271950 }, { "Theramore Handwraps", 271945 }, { "Theramore Mantle", 271957 },
        { "Theramore Pauldrons", 271955 }, { "Theramore Shoulderguards", 272957 },
        { "Theramore Shoulderpads", 271953 }, { "Theramore Shoulders", 271954 }, { "Theramore Spaulders", 271959 },
        { "Theramore Battle Tabard", 276504 } },
})
Sells(2798, nil, {
    { "Friendly", { "Darkspear Voodoo Seal", 272061 }, { "Relentless Raider's Seal", 272060 } },
    { "Honored",
        { "Darkspear Raider's Cloak", 272063 }, { "Darkspear Signet", 272068 }, { "Darkspear Warding Pendant", 272072 },
        { "Insurgent's Band", 272064 } },
    { "Revered",
        { "Darkspear Insurgent's Spellblade", 272083 }, { "Darkspear Raider's Reaper", 272079 },
        { "Darkspear Skirmisher's Bludgeon", 272091 }, { "Tome of the Darkspear Prophecy", 272087 } },
    { "Exalted",
        { "Darkspear Epaulets", 272106 }, { "Darkspear Mantle", 272107 }, { "Darkspear Pauldrons", 272105 },
        { "Darkspear Shoulderguards", 272958 }, { "Darkspear Shoulderpads", 272103 }, { "Darkspear Shoulders", 272104 },
        { "Darkspear Spaulders", 272108 }, { "Raider Gauntlets", 272095 }, { "Raider Gloves", 272099 },
        { "Raider Handguards", 272101 }, { "Raider Handwraps", 272097 }, { "Darkspear Battle Tabard", 276502 } },
})
Sells(2827, nil, {
    { "Friendly", { "Crawler's Clackers", 276200 }, { "Disengagement Ring", 276202 }, { "Misplaced Pantaloons", 276201 } },
    { "Honored", { "Primitive Fishing Pole", 276203 }, { "Thrash's Trash", 276204 } },
    { "Revered", { "Haughty Fellow's Monocle", 276199 } },
})
Sells(2787, nil, {
    { "Friendly",
        { "Pattern: Cloudy Gustwoven Hood", 276978 }, { "Pattern: Cloudy Gustwoven Spaulders", 276979 },
        { "Pattern: Cloudy Stormsewn Cowl", 276982 }, { "Pattern: Cloudy Stormsewn Epaulets", 276983 },
        { "Pattern: Cloudy Windraveled Cover", 276980 }, { "Pattern: Cloudy Windraveled Drapes", 276981 },
        { "Plans: Cloudy Skyforged Helm", 276976 }, { "Plans: Cloudy Skyforged Pauldrons", 276977 } },
})
Sells(2765, nil, {
    { "Revered", { "Rousing Seed Pod", 274379 } },
    { "Exalted", { "Guardians of Hyjal Tabard", 274025 } },
})
Sells(2758, nil, {
    { "Friendly",
        { "Pattern: Azure Gustwoven Belt", 276961 }, { "Pattern: Azure Gustwoven Boots", 276963 },
        { "Pattern: Azure Gustwoven Bracers", 276959 }, { "Pattern: Azure Gustwoven Gloves", 276960 },
        { "Pattern: Azure Stormsewn Cord", 276973 }, { "Pattern: Azure Stormsewn Cuffs", 276971 },
        { "Pattern: Azure Stormsewn Handwraps", 276972 }, { "Pattern: Azure Stormsewn Shoes", 276975 },
        { "Pattern: Azure Windraveled Armguards", 276965 }, { "Pattern: Azure Windraveled Footwraps", 276969 },
        { "Pattern: Azure Windraveled Mitts", 276966 }, { "Pattern: Azure Windraveled Strap", 276967 },
        { "Pattern: Cloudy Gustwoven Belt", 276937 }, { "Pattern: Cloudy Gustwoven Boots", 276939 },
        { "Pattern: Cloudy Gustwoven Bracers", 276935 }, { "Pattern: Cloudy Gustwoven Gloves", 276936 },
        { "Pattern: Cloudy Stormsewn Cord", 276949 }, { "Pattern: Cloudy Stormsewn Cuffs", 276947 },
        { "Pattern: Cloudy Stormsewn Handwraps", 276948 }, { "Pattern: Cloudy Stormsewn Shoes", 276951 },
        { "Pattern: Cloudy Windraveled Armguards", 276941 }, { "Pattern: Cloudy Windraveled Footwraps", 276945 },
        { "Pattern: Cloudy Windraveled Mitts", 276942 }, { "Pattern: Cloudy Windraveled Strap", 276943 },
        { "Plans: Azure Skyforged Chain", 276955 }, { "Plans: Azure Skyforged Gauntlets", 276954 },
        { "Plans: Azure Skyforged Greaves", 276957 }, { "Plans: Azure Skyforged Wristguards", 276953 },
        { "Plans: Cloudy Skyforged Chain", 276931 }, { "Plans: Cloudy Skyforged Gauntlets", 276930 },
        { "Plans: Cloudy Skyforged Greaves", 276933 }, { "Plans: Cloudy Skyforged Wristguards", 276929 } },
    { "Honored",
        { "Pattern: Azure Gustwoven Harness", 276958 }, { "Pattern: Azure Gustwoven Trousers", 276962 },
        { "Pattern: Azure Stormsewn Leggings", 276974 }, { "Pattern: Azure Stormsewn Vest", 276970 },
        { "Pattern: Azure Windraveled Jerkin", 276964 }, { "Pattern: Azure Windraveled Pants", 276968 },
        { "Pattern: Cloudy Gustwoven Harness", 276934 }, { "Pattern: Cloudy Gustwoven Trousers", 276938 },
        { "Pattern: Cloudy Stormsewn Leggings", 276950 }, { "Pattern: Cloudy Stormsewn Vest", 276946 },
        { "Pattern: Cloudy Windraveled Jerkin", 276940 }, { "Pattern: Cloudy Windraveled Pants", 276944 },
        { "Plans: Azure Skyforged Chainmail", 276952 }, { "Plans: Azure Skyforged Legguards", 276956 },
        { "Plans: Cloudy Skyforged Chainmail", 276928 }, { "Plans: Cloudy Skyforged Legguards", 276932 } },
    { "Revered", { "Shadowgale Squirrel", 280347 } },
    { "Exalted", { "Nightclaw Mantle", 280363 } },
})
Sells(2819, nil, {
    { "Friendly",
        { "Initiate's Signet of Brilliance", 275969 }, { "Initiate's Signet of Ferocity", 275968 },
        { "Initiate's Signet of Resolve", 275970 }, { "Initiate's Signet of Vigilance", 275971 } },
    { "Honored",
        { "Nelanna's Enchanted Jewel", 277519 }, { "Tracker's Signet of Brilliance", 275973 },
        { "Tracker's Signet of Ferocity", 275972 }, { "Tracker's Signet of Resolve", 275974 },
        { "Tracker's Signet of Vigilance", 275975 }, { "Intricate Filigree", 277153 } },
    { "Revered",
        { "Watcher's Signet of Brilliance", 275977 }, { "Watcher's Signet of Ferocity", 275976 },
        { "Watcher's Signet of Resolve", 275979 }, { "Watcher's Signet of Vigilance", 275980 } },
    { "Exalted",
        { "Warden's Signet of Brilliance", 275982 }, { "Warden's Signet of Ferocity", 275981 },
        { "Warden's Signet of Resolve", 275983 }, { "Warden's Signet of Vigilance", 275984 } },
})

-- ---- The older factions: quest gains and rewards the Forever client lists (foreverdb.net, 2026-10-28) ----
-- The client lists only a few of each faction's quests (the rest are decided on Blizzard's servers), so
-- these are the ones it names, with their gain. Vendors for these are not named anywhere in the client.
local function Quests(id, body)
    local e = PathForeverData.Reputations[id]
    if e then e.sections[#e.sections + 1] = { "Quests that give rep", " - " .. body } end
end

Quests(470, "350 each: Deepmoss Spider Eggs, Egg Collection, Free From the Hold, Fuel for the Zapping, Gerenzo's Orders, Miner's Fortune, Samophlange Manual, The Escape.")
Quests(369, "500 each: Divino-matic Rod, Scarab Shells.\n - 350 each: Egg Collection, Fuel for the Zapping, Ledger from Tanaris, Rise of the Silithid.")
Quests(577, "350 each: Are We There, Yeti?, Egg Collection, Fuel for the Zapping, Zapped Giants.\n - 250 each: Broodling Essence, Chillwind Horns, High Chief Winterfall, Strange Sources.")
Quests(809, "500 each: Codex of Defense, Enchanted Thorium Platemail: Volume I, II and III, Garona: A Study on Stealth and Treachery, Harnessing Shadows, Pusillin and the Elder Azj'Tordin, The Arcanist's Cookbook.")
Quests(909, "The Darkmoon Faire gives 75 on one quest and 50 on the other.")
Quests(349, "The Azure Key 350.\n - Encoded Fragments, Sealed Azure Bag and The Manor, Ravenholdt 250 each.\n - Junkboxes Needed 75, A Simple Request 10.")
Quests(910, "500 each: Atiesh, Greatstaff of the Guardian, Bang a Gong!, Dirge's Kickin' Chimaerok Chops, Mortal Champions, Nefarius's Corruption, Return to Narain, The Fall of Ossirian, The Isle of Dread!.\n - Each Ahn'Qiraj Temple boss gives 500.")

Sells(470, nil, {
    { "Friendly", { "Quilted Cloak", 274740 }, { "Ratchet Wristwraps", 274742 }, { "Rumpled Kilt", 274741 } },
    { "Honored", { "Barrens Basher", 274744 }, { "Defective Samophlange", 274743 } },
    { "Revered", { "Barrens Headband", 274021 } },
})
Sells(369, nil, {
    { "Friendly", { "Reflective Wristguards", 274750 }, { "Sandstorm Cover", 274752 }, { "Sunburn Spaulders", 274751 } },
    { "Honored", { "Jhordy's Misplaced Screwdriver", 274753 }, { "Suspicious Spare Part", 274754 } },
    { "Revered", { "Stolen Wastewander Cowl", 274023 } },
})
Sells(577, nil, {
    { "Friendly",
        { "Coldmetal Guard", 274758 }, { "Impractical Headwarmer", 274756 }, { "Steamwheedle Grips", 274755 },
        { "Substandard Belt Chain", 274757 } },
    { "Honored", { "Everlook Delivery Bot", 274760 }, { "Everlook Pathcarver", 274759 }, { "Parachute-Priest Pager", 274761 } },
    { "Revered", { "Fizzbolt's Fashionable Fedora", 274024 } },
})
Sells(910, nil, {
    { "Neutral", { "Signet Ring of the Bronze Dragonflight", 21196 } },
    { "Friendly", { "Signet Ring of the Bronze Dragonflight", 21197 } },
    { "Honored", { "Signet Ring of the Bronze Dragonflight", 21198 } },
    { "Revered", { "Signet Ring of the Bronze Dragonflight", 21199 } },
    { "Exalted", { "Signet Ring of the Bronze Dragonflight", 21200 } },
})

-- ---- Gelkis, Magram and the battleground factions (foreverdb.net, 2026-10-28; the client lists only some quests) ----
Quests(92, "250 each: Gelkis Alliance, Strange Alliance.")
Quests(93, "250 each: Brutal Politics, Magram Alliance.")
Quests(730, "500 each: Korrak the Bloodrager, Legendary Heroes, The Battle of Alterac, The Eye of Command.\n - 350: Earned Reverence.\n - 250 each: Alterac Valley Graveyards, Armor Scraps, Brotherly Love.")
Quests(729, "500 each: Legendary Heroes, The Eye of Command, The Legend of Korrak.\n - 350: Earned Reverence.\n - 250 each: Brotherly Love, Fallen Sky Lords, Honored Amongst the Clan, In Defense of Frostwolf.")
Quests(890, "500: Vanquish the Invaders.\n - 150: Concerted Efforts.\n - 100: Fight for Warsong Gulch (several versions).\n - A flag capture gives 35 and 10, a win 42.")
Quests(889, "500: Quell the Silverwing Usurpers.\n - 150: For Great Honor.\n - 100: Battle of Warsong Gulch (several versions).\n - A flag capture gives 35 and 10, a win 42.")
Quests(509, "1000: Control Four Bases.\n - 500: Control Five Bases.\n - 150: Concerted Efforts.\n - 100 each: the five Claiming Arathi Basin quests.\n - 10 for each resource tick of the battleground.")
Quests(510, "1000: Take Four Bases.\n - 500: Take Five Bases.\n - 150: For Great Honor.\n - 100 each: the five Conquering Arathi Basin quests.\n - 10 for each resource tick of the battleground.")

Sells(509, nil, {
    { "Friendly",
        { "Talisman of Arathor", 20071 }, { "Highlander's Enriched Ration", 20225 }, { "Highlander's Field Ration", 20226 },
        { "Highlander's Iron Ration", 20227 }, { "Highlander's Mageweave Bandage", 20237 },
        { "Highlander's Runecloth Bandage", 20243 }, { "Highlander's Silk Bandage", 20244 } },
    { "Honored",
        { "Highlander's Chain Girdle", 20043 }, { "Highlander's Cloth Girdle", 20047 }, { "Highlander's Lamellar Girdle", 20042 },
        { "Highlander's Leather Girdle", 20045 }, { "Highlander's Lizardhide Girdle", 20046 },
        { "Highlander's Mail Girdle", 20044 }, { "Highlander's Plate Girdle", 20041 } },
    { "Revered",
        { "Highlander's Chain Greaves", 20050 }, { "Highlander's Cloth Boots", 20054 }, { "Highlander's Lamellar Greaves", 20049 },
        { "Highlander's Leather Boots", 20052 }, { "Highlander's Lizardhide Boots", 20053 },
        { "Highlander's Mail Greaves", 20051 }, { "Highlander's Plate Greaves", 20048 } },
    { "Exalted",
        { "Cloak of the Honor Guard", 20073 }, { "Highlander's Chain Pauldrons", 20055 }, { "Highlander's Epaulets", 20061 },
        { "Highlander's Lamellar Spaulders", 20058 }, { "Highlander's Leather Shoulders", 20059 },
        { "Highlander's Lizardhide Shoulders", 20060 }, { "Highlander's Mail Pauldrons", 20056 },
        { "Highlander's Plate Spaulders", 20057 }, { "Ironbark Staff", 20069 }, { "Sageclaw", 20070 },
        { "Arathor Battle Tabard", 20132 }, { "Tabard Project (Aidan)", 215450 } },
})
Sells(510, nil, {
    { "Friendly",
        { "Defiler's Talisman", 20072 }, { "Defiler's Enriched Ration", 20222 }, { "Defiler's Field Ration", 20223 },
        { "Defiler's Iron Ration", 20224 }, { "Defiler's Mageweave Bandage", 20232 },
        { "Defiler's Runecloth Bandage", 20234 }, { "Defiler's Silk Bandage", 20235 } },
    { "Honored",
        { "Defiler's Chain Girdle", 20150 }, { "Defiler's Cloth Girdle", 20163 }, { "Defiler's Lamellar Girdle", 20177 },
        { "Defiler's Leather Girdle", 20190 }, { "Defiler's Lizardhide Girdle", 20171 }, { "Defiler's Mail Girdle", 20195 },
        { "Defiler's Plate Girdle", 20204 } },
    { "Revered",
        { "Defiler's Chain Greaves", 20154 }, { "Defiler's Cloth Boots", 20159 }, { "Defiler's Lamellar Greaves", 20181 },
        { "Defiler's Leather Boots", 20186 }, { "Defiler's Lizardhide Boots", 20167 }, { "Defiler's Mail Greaves", 20199 },
        { "Defiler's Plate Greaves", 20208 } },
    { "Exalted",
        { "Deathguard's Cloak", 20068 }, { "Defiler's Chain Pauldrons", 20158 }, { "Defiler's Epaulets", 20176 },
        { "Defiler's Lamellar Spaulders", 20184 }, { "Defiler's Leather Shoulders", 20194 },
        { "Defiler's Lizardhide Shoulders", 20175 }, { "Defiler's Mail Pauldrons", 20203 },
        { "Defiler's Plate Spaulders", 20212 }, { "Ironbark Staff", 20220 }, { "Mindfang", 20214 },
        { "Battle Tabard of the Defilers", 20131 } },
})

-- Darkspear Islands gear: sold in the Barrens (wowhead.com/forever PvP guide, 2026-10-30)
PathForeverData.Reputations[2799].vendors = {
    { name = "Bryanna Embreeze", zone = "Northwatch Hold, The Barrens", map = 1413, x = 0.634, y = 0.586 } }
PathForeverData.Reputations[2798].vendors = {
    { name = "Creeg Bothunk", zone = "North of Ratchet, The Barrens", map = 1413, x = 0.650, y = 0.346 } }
