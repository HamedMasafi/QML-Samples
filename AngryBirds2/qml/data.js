var objects = [
    {
        "source": "pig.png",
        "texture": "pig",
        "damage": 10,
        "shape": "circle"
    },

    {
		"source": "wood-circle (1).png",
		"texture": "wood",
		"damage": 10,
		"shape": "circle"
	},
	{
		"source": "wood-circle (2).png",
		"texture": "wood",
		"damage": 10,
		"shape": "circle"
	},
	{
		"source": "wood-rectangle (1).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (2).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (3).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (4).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (5).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (6).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (7).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (9).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (10).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	{
		"source": "wood-rectangle (11).png",
		"texture": "wood",
		"damage": 10,
		"shape": "rectangle"
	},
	/*{
		"source": "wood-triangle (1).png",
		"texture": "wood",
		"damage": 10,
		"shape": "triangle"
	},
	{
		"source": "wood-triangle (2).png",
		"texture": "wood",
		"damage": 10,
		"shape": "triangle"
	},
	{
		"source": "glass-triangle (2).png",
		"texture": "glass",
        "damage": 2,
		"shape": "triangle"
	},*/
	{
		"source": "glass-circle (1).png",
		"texture": "glass",
        "damage": 2,
		"shape": "circle"
	},
	{
		"source": "glass-circle (2).png",
		"texture": "glass",
        "damage": 2,
		"shape": "circle"
	},
	{
		"source": "glass-rectangle (1).png",
		"texture": "glass",
        "damage": 2,
		"shape": "rectangle"
	},
	{
		"source": "glass-rectangle (2).png",
		"texture": "glass",
        "damage": 2,
		"shape": "rectangle"
	},
	{
		"source": "glass-rectangle (3).png",
		"texture": "glass",
        "damage": 2,
		"shape": "rectangle"
	},
	{
		"source": "glass-rectangle (4).png",
		"texture": "glass",
        "damage": 2,
		"shape": "rectangle"
	},
	{
		"source": "glass-rectangle (5).png",
		"texture": "glass",
        "damage": 2,
		"shape": "rectangle"
	},
	{
		"source": "glass-rectangle (6).png",
		"texture": "glass",
        "damage": 2,
		"shape": "rectangle"
	},
	/*{
		"source": "glass-triangle (1).png",
		"texture": "glass",
        "damage": 2,
		"shape": "triangle"
	},*/
	{
		"source": "stone-rectangle (4).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	},
	{
		"source": "stone-rectangle (5).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	},
	{
		"source": "stone-rectangle (6).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	},
	{
		"source": "stone-rectangle (7).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	},
	{
		"source": "stone-rectangle (8).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	},
	/*{
		"source": "stone-triangle (1).png",
		"texture": "stone",
        "damage": 90,
		"shape": "triangle"
	},
	{
		"source": "stone-triangle (2).png",
		"texture": "stone",
        "damage": 90,
		"shape": "triangle"
	},*/
	{
		"source": "stone-circle (1).png",
		"texture": "stone",
        "damage": 90,
		"shape": "circle"
	},
	{
		"source": "stone-circle (2).png",
		"texture": "stone",
        "damage": 90,
		"shape": "circle"
	},
	{
		"source": "stone-rectangle (1).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	},
	{
		"source": "stone-rectangle (2).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	},
	{
		"source": "stone-rectangle (3).png",
		"texture": "stone",
        "damage": 90,
		"shape": "rectangle"
	}
]



var textures = [
            {
                "name": "wood",
                "density": 50,
                "friction": 90,
                "restitution": 0.2,
                "particleSource": "img/wood-slice.png"
            },{
                "name": "stone",
                "density": 90,
                "friction": 120,
                "restitution": 0.3,
                "particleSource": "img/stone-slice.png"
            },{
                "name": "glass",
                "density": 20,
                "friction": 40,
                "restitution": 0.1,
                "particleSource": "img/glass-slice.png"
            },{
                "name": "pig",
                "density": 50,
                "friction": 90,
                "restitution": 0.2,
                "particleSource": "img/pig-slice.png"
            }
]

function getTexture(name){
    var i
    for(i = 0; i < textures.length; i++)
        if(textures[i].name === name)
            return textures[i];
    return null;
}


/// Deprased; not referenced
function createObject(data){
    var objectData = getTexture(data.texture)
    if(objectData === null)
        return;

    var component = Qt.createComponent(Qt.resolvedUrl("BoxEntity.qml"))

    var object = component.createObject(worldItem, {
                                            "source": drop.source.source,
                                            "x": dropShadow.x,
                                            "y": dropShadow.y,
                                            "density": objectData.density,
                                            "friction": objectData.friction,
                                            "restitution": objectData.restitution,
                                            damage: 999999
                                        });

    __serializer.objects.push({
                                  "data": drop.source.objectData,
                                  "obj": object
                              })

    object.selected = Qt.binding(function(){
        return object === itemEditor.target
    })
    object.onClicked.connect(function(){
        itemEditor.target = object
    })
}
