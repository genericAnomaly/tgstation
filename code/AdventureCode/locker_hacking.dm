/obj/structure/closet/secure_closet
	var/panel = FALSE

/obj/structure/closet/secure_closet/attackby(obj/item/I, mob/user, params)
	if(opened)
		..()
		return
	else if(istype(I, /obj/item/weapon/screwdriver))
		add_fingerprint(user)
		panel = !panel
		update_icon()
		user.visible_message("[user.name] [panel ? "opens" : "closes"] the panel on the [src].")
		return
	else if(panel && istype(I, /obj/item/device/multitool))
		add_fingerprint(user)

		if(isliving(user))
			var/mob/living/L = user
			if(L.electrocute_act(10,src)) //if we are not electricity proof, return 
				do_sparks(5, TRUE, src)
				return

		playsound(loc, 'sound/machines/twobeep.ogg', 150, 1)
		user.visible_message("<span class='warning'>[user.name] begins [broken ? "repairing the broken lock" : "hacking the lock open"] on the [src].</span>")

		if(do_after(user, 100, target = src))
			broken = !broken
			playsound(src.loc, 'sound/effects/sparks4.ogg', 50, 1)
			do_sparks(5, TRUE, src)
			locked = FALSE // the locker will be unlocked regardless of it it's broken or not
			update_icon()
			user.visible_message("<span class='warning'>[user.name] has [broken ? "hacked open" : "repaired"] the [src]'s lock with the [I].</span>")
		return
	..()

/obj/structure/closet/secure_closet/can_open(mob/living/user)
	if(panel)
		return 0
	return ..()

/obj/structure/closet/secure_closet/can_close(mob/living/user)
	if(panel)
		return 0
	return ..()

/obj/structure/closet/secure_closet/togglelock(mob/living/user)
	if(panel)
		to_chat(user, "<span class='warning'>The [src]'s panel is open.</span>")
		return
	..()

/obj/structure/closet/secure_closet/update_icon()
	..()
	if(!opened && panel)
		cut_overlay("[locked ? "locked" : "unlocked"]") // kind of a hack
		add_overlay("[broken ? "hackingsparks" : "hacking"]")
