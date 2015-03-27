local items = {

    --System
    {
        name = "System",
        isSubMenu = true,
        subMenu = {
            {name="Sleep", cmd="systemctl suspend"},
            {name="Terminal", cmd="urxvtc"}
        }
    },

    --Games
    {
        name = "Games",
        isSubMenu = true,
        subMenu = {
            {name="Oolite", cmd="oolite"},
            {name="Super Tux Kart", cmd="supertuxkart"},
            {name="Xonotic", cmd="xonotic-glx"},
            {name="sauerbraten", cmd="sauerbraten-client"}
        }
    },

    --Quit awesome
    {
        name = "Quit Awesome",
        isSubMenu = false
    }
}

return items
