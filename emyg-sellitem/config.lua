Config = {}

Config.NPCs = {
    {
        model = 'a_m_m_farmer_01',
        coords = vector3(967.59, -1867.37, 31.45),
        heading = 172.3,
        blip = {
            enabled = true,
            name = 'Toptancı',
            sprite = 280,
            color = 2,
            scale = 0.8
        },
        items = {
            {label = "Karpuz", value = "kesilmiskarpuz", price = 100},
            {label = "Tavuk", value = "packagedchicken", price = 200},
            {label = "Kereste", value = "kereste", price = 200},
        }
    },
    {
        model = 'a_m_y_business_01',
        coords = vector3(-1038.28, -1396.94, 5.55),
        heading = 74.65,
        blip = {
            enabled = true,
            name = 'Şarap Satış',
            sprite = 280,
            color = 7,
            scale = 0.8
        },
        items = {
            {label = "Şarap", value = "wine", price = 300},
        }
    },
    {
        model = 'a_m_y_business_01',
        coords = vector3(-780.29, -608.85, 30.28),
        heading = 355.19,
        blip = {
            enabled = true,
            name = 'Rehin Dükkanı',
            sprite = 605,
            color = 0,
            scale = 0.8
        },
        items = {
            {label = "Elmas", value = "diamond", price = 20000},
            {label = "Alyın", value = "gold", price = 10000},
            {label = "Rolex Saat", value = "rolex", price = 30000},
            {label = "İnci Kolye", value = "necklace", price = 30000},
        }
    },
}
