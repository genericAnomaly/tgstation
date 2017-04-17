
//Ruin of the Space Walrus

/area/ruin/walrus
	name = "Holy Icee"
	icon_state = "blue"
	ambientsounds = list('sound/ambience/ambicha1.ogg','sound/ambience/ambicha2.ogg','sound/ambience/ambicha3.ogg','sound/ambience/ambicha4.ogg')

/datum/map_template/ruin/space/walrus
	id = "walrus"
	suffix = "AdventureCode/walrus.dmm"
	name = "Holy Icee"
	description = "A place where an aspect of the space walrus dwells."

/obj/structure/statue/space_walrus
	name = "Space Walrus statue"
	desc = "A mysterious entity. You feel hunger and whimsy."
	icon = 'icons/AdventureCode/obj/statue.dmi'
	icon_state = "spacewalrus"
	material_drop_type = /obj/item/weapon/ore/bluespace_crystal
	light_range = 5
	light_color = LIGHT_COLOR_BLUE
	var/giftcount = 5

/obj/structure/statue/space_walrus/attackby(obj/item/weapon/W, mob/living/user, params)
	if(istype(W,/obj/item/weapon/reagent_containers/food))
		if(!user.drop_item())
			to_chat(user, "<span class='warning'>The [W.name] is stuck to your hand, you cannot offer it to the [src.name]!</span>")
			return

		user.visible_message("[user] offers the [W.name] to the [name].", "<span class='notice'>You offer the [W.name] to the [name].</span>")
		qdel(W)
		to_chat(user, "<i>You hear a voice in your head... <b>Arf, arf, arf...</i></b>")
		var/gift = new /obj/item/weapon/a_gift
		user.put_in_hands(gift)
		giftcount--
		if(giftcount <= 0)
			visible_message("The statue, satisfied, departs from this plane.")
			deconstruct(TRUE)
	else
		if(user.reagents)
			user.reagents.add_reagent("frostoil", 30)
		return ..()