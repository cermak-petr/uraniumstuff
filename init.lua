local ingot_name = "technic:uranium0_ingot"
local stick_name = "default:stick"
local stone_name = "default:stone"
local stone_image = "default_stone.png"
local stone_sounds = nil
local uses = 400
local full_punch_interval = 0.3 --0.45
local damage_multiplier = 1.5

local MODNAME = minetest.get_current_modname()
local MODPATH = minetest.get_modpath(MODNAME)
local S = minetest.get_translator(MODNAME)


-- MineClone compatibility

if minetest.get_modpath("mcl_core") then
    stick_name = "mcl_core:stick"
    stone_name = "mcl_core:stone"
end

if minetest.get_modpath("mcl_sounds") then
    stone_sounds = mcl_sounds.node_sound_stone_defaults()
else
    stone_sounds = default.node_sound_stone_defaults()
end


-- Ore generation

if not minetest.get_modpath("technic") then
    ingot_name = "uraniumstuff:uranium_ingot"
    
    minetest.register_node("uraniumstuff:mineral_uranium", {
	    description = S("Uranium Ore"),
	    tiles = { stone_image .. "^uraniumstuff_mineral_uranium.png" },
	    is_ground_content = true,
	    groups = {cracky=3, radioactive=1},
	    sounds = stone_sounds,
	    drop = "uraniumstuff:uranium_lump",
    })

    minetest.register_ore({
	    ore_type = "scatter",
	    ore = "uraniumstuff:mineral_uranium",
	    wherein = stone_name,
	    clust_scarcity = 8*8*8*7,
	    clust_num_ores = 4,
	    clust_size = 3,
	    y_min = -300,
	    y_max = -80,
	    noise_params = uranium_params,
	    noise_threshold = uranium_threshold,
    })

    minetest.register_node("uraniumstuff:uranium_block", {
	    description = S("Uranium Block"),
	    tiles = { "uraniumstuff_uranium_block.png" },
	    is_ground_content = true,
	    groups = {cracky=1, level=2, radioactive=1},
	    sounds = stone_sounds
    })

    minetest.register_craftitem("uraniumstuff:uranium_lump", {
	    description = S("Uranium Lump"),
	    inventory_image = "uraniumstuff_uranium_lump.png",
    })

    minetest.register_craftitem("uraniumstuff:uranium_ingot", {
	    description = S("Uranium Ingot"),
	    inventory_image = "uraniumstuff_uranium_ingot.png",
	    groups = {uranium_ingot=1},
    })

    minetest.register_craft({
		output = "uraniumstuff:uranium_block",
		recipe = {
			{ingot_name, ingot_name, ingot_name},
			{ingot_name, ingot_name, ingot_name},
			{ingot_name, ingot_name, ingot_name},
		}
	})

	minetest.register_craft({
		output = ingot_name.." 9",
		recipe = {
			{"uraniumstuff:uranium_block"}
		}
	})

    minetest.register_craft({
	    type = 'cooking',
	    recipe = "uraniumstuff:uranium_lump",
	    output = "uraniumstuff:uranium_ingot",
    })
end

-- Tool Registration

if not minetest.get_modpath("toolranks") then
    uses = 400
end


-- Pickaxe

minetest.register_tool("uraniumstuff:uranium_pick", {
	description = S("Uranium Pickaxe"),
	inventory_image = "uraniumstuff_uranium_pick.png",
	tool_capabilities = {
		full_punch_interval = full_punch_interval,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = uses, maxlevel = 3},
		},
		damage_groups = {fleshy = 6*damage_multiplier},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})

minetest.register_craft({
    output = "uraniumstuff:uranium_pick",
    recipe = {
        {ingot_name, ingot_name, ingot_name},
        {"", stick_name, ""},
        {"", stick_name, ""}
    }
})


-- Shovel

minetest.register_tool("uraniumstuff:uranium_shovel", {
    description = S("Uranium Shovel"),
    inventory_image = "uraniumstuff_uranium_shovel.png",
    wield_image = "uraniumstuff_uranium_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = full_punch_interval,
		max_drop_level = 3,
		groupcaps = {
			crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = uses, maxlevel = 3},
		},
		damage_groups = {fleshy = 5*damage_multiplier},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})

minetest.register_craft({
    output = "uraniumstuff:uranium_shovel",
    recipe = {
        {ingot_name},
        {stick_name},
        {stick_name}
    }
})


-- Axe

minetest.register_tool("uraniumstuff:uranium_axe", {
    description = S("Uranium Axe"),
    inventory_image = "uraniumstuff_uranium_axe.png",
	tool_capabilities = {
		full_punch_interval = full_punch_interval,
		max_drop_level = 3,
		groupcaps = {
			choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = uses, maxlevel = 3},
			fleshy = {times = {[2] = 0.95, [3] = 0.30}, uses = uses, maxlevel = 2},
		},
		damage_groups = {fleshy = 8*damage_multiplier}
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})

minetest.register_craft({
    output = "uraniumstuff:uranium_axe",
    recipe = {
        {ingot_name, ingot_name, ""},
        {ingot_name, stick_name, ""},
        {"", stick_name, ""}
    }
})


-- Sword

minetest.register_tool("uraniumstuff:uranium_sword", {
    description = S("Uranium Sword"),
    inventory_image = "uraniumstuff_uranium_sword.png",
	tool_capabilities = {
		full_punch_interval = full_punch_interval,
		max_drop_level = 3,
		groupcaps = {
			fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = uses, maxlevel = 2},
			snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, uses = uses, maxlevel = 3},
			choppy = {times = {[3] = 0.65}, uses = uses, maxlevel = 0},
		},
		damage_groups = {fleshy = 10*damage_multiplier},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})

minetest.register_craft({
    output = "uraniumstuff:uranium_sword",
    recipe = {
        {ingot_name},
        {ingot_name},
        {stick_name}
    }
})


-- Hoe

minetest.register_tool("uraniumstuff:uranium_hoe", {
    description = S("Uranium Hoe"),
    inventory_image = "uraniumstuff_uranium_hoe.png",
	tool_capabilities = {
		full_punch_interval = full_punch_interval,
		max_drop_level = 3,
		max_uses = uses0,
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {hoe = 1}
})

minetest.register_craft({
    output = "uraniumstuff:uranium_sword",
    recipe = {
        {ingot_name},
        {ingot_name},
        {stick_name}
    }
})


-- Multitool

minetest.register_tool("uraniumstuff:uranium_multitool", {
    description = S("Uranium Multitool"),
    inventory_image = "uraniumstuff_uranium_multitool.png",
	tool_capabilities = {
		full_punch_interval = full_punch_interval,
		max_drop_level = 3,
        groupcaps = {
			cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = uses, maxlevel = 3},
            crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = uses, maxlevel = 3},
            choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = uses, maxlevel = 3},
			fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = uses, maxlevel = 2},
			snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, uses = uses, maxlevel = 3},
		},
        damage_groups = {fleshy = 10*damage_multiplier},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1, axe = 1, shovel = 1, pickaxe = 1}
})

minetest.register_craft({
    output = "uraniumstuff:uranium_multitool",
    recipe = {
        {"", "uraniumstuff:uranium_shovel", ""},
        {"uraniumstuff:uranium_axe", "uraniumstuff:uranium_pick", "uraniumstuff:uranium_sword"},
    }
})


-- Toolranks Integration

if minetest.get_modpath("toolranks") then
	minetest.override_item("uraniumstuff:uranium_sword", {
		description = toolranks.create_description(S("Uranium Sword"), 0, 1),
		original_description = S("Uranium Sword"),
		after_use = toolranks.new_afteruse
	})

	minetest.override_item("uraniumstuff:uranium_pick", {
		description = toolranks.create_description(S("Uranium Pickaxe"), 0, 1),
		original_description = S("Uranium Pickaxe"),
		after_use = toolranks.new_afteruse
	})

	minetest.override_item("uraniumstuff:uranium_axe", {
		description = toolranks.create_description(S("Uranium Axe"), 0, 1),
		original_description = S("Uranium Axe"),
		after_use = toolranks.new_afteruse
	})

	minetest.override_item("uraniumstuff:uranium_shovel", {
		description = toolranks.create_description(S("Uranium Shovel"), 0, 1),
		original_description = S("Uranium Shovel"),
		after_use = toolranks.new_afteruse
	})
end


-- Armor

if minetest.get_modpath("3d_armor") then
	armor.materials.uranium = ingot_name
	armor.config.material_uranium = true

	armor:register_armor("uraniumstuff:helmet_uranium", {
		description = S("Uranium Helmet"),
		inventory_image = "uraniumstuff_inv_uranium_helmet.png",
		light_source = 5, -- Texture will have a glow when dropped
		groups = {armor_head=1, armor_heal=12, armor_use=200, armor_fire=3},
		armor_groups = {fleshy=20, radiation=50},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("uraniumstuff:uranium_helmet", "uraniumstuff:helmet_uranium")

	armor:register_armor("uraniumstuff:chestplate_uranium", {
		description = S("Uranium Chestplate"),
		inventory_image = "uraniumstuff_inv_uranium_chestplate.png",
		light_source = 5, -- Texture will have a glow when dropped
		groups = {armor_torso=1, armor_heal=12, armor_use=200, armor_fire=3},
		armor_groups = {fleshy=30, radiation=50},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("uraniumstuff:uranium_chestplate", "uraniumstuff:chestplate_uranium")

	armor:register_armor("uraniumstuff:leggings_uranium", {
		description = S("Uranium Leggings"),
		inventory_image = "uraniumstuff_inv_uranium_leggings.png",
		light_source = 5, -- Texture will have a glow when dropped
		groups = {armor_legs=1, armor_heal=12, armor_use=200, armor_fire=3},
		armor_groups = {fleshy=30, radiation=50},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("uraniumstuff:uranium_leggings", "uraniumstuff:leggings_uranium")

	armor:register_armor("uraniumstuff:boots_uranium", {
		description = S("Uranium Boots"),
		inventory_image = "uraniumstuff_inv_uranium_boots.png",
		light_source = 5, -- Texture will have a glow when dropped
		groups = {armor_feet=1, armor_heal=12, armor_use=200, armor_fire=3, physics_jump=0.5, physics_speed = 1},
		armor_groups = {fleshy=20, radiation=50},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("uraniumstuff:uranium_boots", "uraniumstuff:boots_uranium")

	if minetest.get_modpath("shields") then
		armor:register_armor("uraniumstuff:shield_uranium", {
			description = S("Uranium Shield"),
			inventory_image = "uraniumstuff_inv_uranium_shield.png",
			light_source = 5, -- Texture will have a glow when dropped
			groups = {armor_shield=1, armor_heal=12, armor_use=200, armor_fire=3},
			armor_groups = {fleshy=30, radiation=50},
			damage_groups = {cracky=2, snappy=1, level=3},
			wear = 0,
		})
	    minetest.register_alias("uraniumstuff:uranium_shield", "uraniumstuff:shield_uranium")
	end
end

if minetest.get_modpath("3d_armor") or minetest.get_modpath("mcl_armor") then
	minetest.register_craft({
		output = "uraniumstuff:uranium_helmet",
		recipe = {
			{ingot_name, ingot_name, ingot_name},
			{ingot_name, "", ingot_name},
			{"", "", ""},
		}
	})

	minetest.register_craft({
		output = "uraniumstuff:uranium_chestplate",
		recipe = {
			{ingot_name, "", ingot_name},
			{ingot_name, ingot_name, ingot_name},
			{ingot_name, ingot_name, ingot_name},
		}
	})

	minetest.register_craft({
		output = "uraniumstuff:uranium_leggings",
		recipe = {
			{ingot_name, ingot_name, ingot_name},
			{ingot_name, "", ingot_name},
			{ingot_name, "", ingot_name},
		}
	})

	minetest.register_craft({
		output = "uraniumstuff:uranium_boots",
		recipe = {
			{ingot_name, "", ingot_name},
			{ingot_name, "", ingot_name},
		}
	})

	if not minetest.get_modpath("mcl_armor") then
		minetest.register_craft({
			output = "uraniumstuff:uranium_shield",
			recipe = {
				{ingot_name, ingot_name, ingot_name},
				{ingot_name, ingot_name, ingot_name},
				{"", ingot_name, ""},
			}
		})
	end
end
