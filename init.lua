local bonus_items = {  --[[ each element is {Itemstack, chance} --]]
    {ItemStack("default:stone 99"), .5},
    {ItemStack("default:mese"), .01},
    {ItemStack("default:apple 10"), .3},
    {ItemStack("default:obsidian 10"), .9},
    {ItemStack("default:dirt 1"), .1}
}

minetest.register_node("unknown_buyer:unknown_buyer",{
    description = "Unknown Item Buyer",
    tiles = {
        "unknown_buyer_chest_top.png",
        "unknown_buyer_chest_top.png",
        "unknown_buyer_chest_side.png",
        "unknown_buyer_chest_side.png",
        "unknown_buyer_chest_side.png",
        "unknown_buyer_chest_front.png",
    },
    groups = {cracky = 3},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local player_name = clicker:get_player_name()
        if itemstack:is_known() and itemstack:get_name() ~= "unknown" then
            return
        end
        if itemstack:get_count() < 10 then
            minetest.chat_send_player(player_name, "You should have at least 10 of an unknown item.")
            return
        end
        local spawn_pos = {x = pos.x, y = pos.y, z = pos.z -1}
        local r = math.random()
        local t = 0
        local random_item
        for _, item in ipairs(bonus_items) do
            local t_ = item[2]
            if r >= t and r < (t_+t) then
                random_item = item[1]
                break
            end
            t = t + t_
        end
        minetest.spawn_item(spawn_pos, random_item)
        itemstack:set_count(itemstack:get_count() - 10)
        return itemstack
    end
})
