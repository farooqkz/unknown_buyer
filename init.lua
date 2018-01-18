--[[
unknown_buyer mod for Minetest
Copyright (C) 2018 Farooq Karimi Zadeh <farooghkarimizadeh at gmail dot com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
--]]
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
