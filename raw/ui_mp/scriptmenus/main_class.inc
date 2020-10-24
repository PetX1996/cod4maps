// "ui_teamTeam"
// "ui_teamC0T0"
// "ui_teamC0T1"
// "ui_teamC0T2"
// "ui_teamC0T3"
// "ui_teamC0T4"
// "ui_teamC0T5"
// "ui_teamC1T0"
// "ui_teamC1T1"
// "ui_teamC1T2"
// "ui_teamC1T3"
// "ui_teamC1T4"
// "ui_teamC1T5"

#define ALLIES_BODY Body
#define ALLIES_WEAPON Weapon
#define ALLIES_INVA Perk
#define ALLIES_INVB Spray
#define ALLIES_INVC Trail
#define ALLIES_INVD InvD

#define AXIS_BODY Body
#define AXIS_WEAPON Weapon
#define AXIS_INVA Perk
#define AXIS_INVB InvB
#define AXIS_INVC InvC
#define AXIS_INVD InvD

#define OPEN_ALLIES_BODY 	setDvar ui_classType ALLIES_BODY; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_allies";
#define OPEN_ALLIES_WEAPON 	setDvar ui_classType ALLIES_WEAPON; setDvar ui_classCount 0; setDvar ui_classIsWide 1; close self; open "class_allies";
#define OPEN_ALLIES_INVA 	setDvar ui_classType ALLIES_INVA; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_allies";
#define OPEN_ALLIES_INVB 	setDvar ui_classType ALLIES_INVB; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_allies";
#define OPEN_ALLIES_INVC 	setDvar ui_classType ALLIES_INVC; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_allies";
#define OPEN_ALLIES_INVD 	setDvar ui_classType ALLIES_INVD; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_allies";

#define OPEN_AXIS_BODY 		setDvar ui_classType AXIS_BODY; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_axis";
#define OPEN_AXIS_WEAPON 	setDvar ui_classType AXIS_WEAPON; setDvar ui_classCount 0; setDvar ui_classIsWide 1; close self; open "class_axis";
#define OPEN_AXIS_INVA 		setDvar ui_classType AXIS_INVA; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_axis";
#define OPEN_AXIS_INVB 		setDvar ui_classType AXIS_INVB; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_axis";
#define OPEN_AXIS_INVC 		setDvar ui_classType AXIS_INVC; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_axis";
#define OPEN_AXIS_INVD 		setDvar ui_classType AXIS_INVD; setDvar ui_classCount 0; setDvar ui_classIsWide 0; close self; open "class_axis";

#define IS_OPENED_ALLIES 	MenuIsOpen("class_allies")
#define IS_OPENED_AXIS 		MenuIsOpen("class_axis")

#define CLASS_TEAM_CURRENT 	DvarInt("ui_teamTeam")
#define CLASS_TEAM_JUMPER 0
#define CLASS_TEAM_ACTIVATOR 1

PANEL_STATIC(CLASS_X, CLASS_Y, CLASS_W, CLASS_H, COLOR_BG_TRANSPARENT, 1)

// == TAB ==
#define CLASS_TAB_X CLASS_X
#define CLASS_TAB_Y CLASS_Y
#define CLASS_TAB_W CLASS_W
#define CLASS_TAB_H 20

#undef TAB_X
#undef TAB_Y
#undef TAB_W
#undef TAB_H
#undef TAB_BTN_SIZE
#undef TAB_SELECTOR

#define TAB_X CLASS_TAB_X
#define TAB_Y CLASS_TAB_Y
#define TAB_W CLASS_TAB_W
#define TAB_H CLASS_TAB_H
#define TAB_BTN_SIZE (CLASS_TAB_W * 0.5)
#define TAB_SELECTOR CLASS_TEAM_CURRENT

TAB_BTN_STATIC("20", 0, "Jumper", FONTSCALE_16, ITEM_ALIGN_MIDDLE_CENTER, setDvar ui_teamTeam CLASS_TEAM_JUMPER;, ;, ;, 1)
TAB_BTN_STATIC("21", 1, "Activator", FONTSCALE_16, ITEM_ALIGN_MIDDLE_CENTER, setDvar ui_teamTeam CLASS_TEAM_ACTIVATOR;, ;, ;, 1)

// == JUMPER ==
#define CLASS_J_BODY_X (CLASS_X + SPACE_INNER)
#define CLASS_J_BODY_Y (CLASS_TAB_Y + CLASS_TAB_H + SPACE_INNER)
#define CLASS_J_BODY_W (CLASS_W - (SPACE_INNER + SPACE_INNER))
#define CLASS_J_BODY_H CLASS_J_BODY_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_J_BODY_X, CLASS_J_BODY_Y, CLASS_J_BODY_W, CLASS_J_BODY_H, DvarString("ui_teamC0T0"),
	OPEN_ALLIES_BODY, ;, ;, (IS_OPENED_ALLIES && DvarString("ui_classType") == ALLIES_BODY), (CLASS_TEAM_CURRENT == CLASS_TEAM_JUMPER && DvarString("ui_teamC0T0") != ""))

#define CLASS_J_WEAPON_X (CLASS_X + SPACE_INNER)
#define CLASS_J_WEAPON_Y (CLASS_J_BODY_Y + CLASS_J_BODY_H + SPACE_INNER)
#define CLASS_J_WEAPON_W (CLASS_W - (SPACE_INNER + SPACE_INNER))
#define CLASS_J_WEAPON_H (CLASS_J_WEAPON_W * 0.5)

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_J_WEAPON_X, CLASS_J_WEAPON_Y, CLASS_J_WEAPON_W, CLASS_J_WEAPON_H, DvarString("ui_teamC0T1"),
	OPEN_ALLIES_WEAPON, ;, ;, (IS_OPENED_ALLIES && DvarString("ui_classType") == ALLIES_WEAPON), (CLASS_TEAM_CURRENT == CLASS_TEAM_JUMPER && DvarString("ui_teamC0T1") != ""))

#define CLASS_J_INVA_X (CLASS_X + SPACE_INNER)
#define CLASS_J_INVA_Y (CLASS_J_WEAPON_Y + CLASS_J_WEAPON_H + SPACE_INNER)
#define CLASS_J_INVA_W ((CLASS_W - (SPACE_INNER * 3)) * 0.5)
#define CLASS_J_INVA_H CLASS_J_INVA_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_J_INVA_X, CLASS_J_INVA_Y, CLASS_J_INVA_W, CLASS_J_INVA_H, DvarString("ui_teamC0T2"),
	OPEN_ALLIES_INVA, ;, ;, (IS_OPENED_ALLIES && DvarString("ui_classType") == ALLIES_INVA), (CLASS_TEAM_CURRENT == CLASS_TEAM_JUMPER && DvarString("ui_teamC0T2") != ""))

#define CLASS_J_INVB_X (CLASS_J_INVA_X + CLASS_J_INVA_W + SPACE_INNER)
#define CLASS_J_INVB_Y CLASS_J_INVA_Y
#define CLASS_J_INVB_W CLASS_J_INVA_W
#define CLASS_J_INVB_H CLASS_J_INVB_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_J_INVB_X, CLASS_J_INVB_Y, CLASS_J_INVB_W, CLASS_J_INVB_H, DvarString("ui_teamC0T3"),
	OPEN_ALLIES_INVB, ;, ;, (IS_OPENED_ALLIES && DvarString("ui_classType") == ALLIES_INVB), (CLASS_TEAM_CURRENT == CLASS_TEAM_JUMPER && DvarString("ui_teamC0T3") != ""))

#define CLASS_J_INVC_X (CLASS_X + SPACE_INNER)
#define CLASS_J_INVC_Y (CLASS_J_INVA_Y + CLASS_J_INVA_H + SPACE_INNER)
#define CLASS_J_INVC_W CLASS_J_INVA_W
#define CLASS_J_INVC_H CLASS_J_INVC_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_J_INVC_X, CLASS_J_INVC_Y, CLASS_J_INVC_W, CLASS_J_INVC_H, DvarString("ui_teamC0T4"),
	OPEN_ALLIES_INVC, ;, ;, (IS_OPENED_ALLIES && DvarString("ui_classType") == ALLIES_INVC), (CLASS_TEAM_CURRENT == CLASS_TEAM_JUMPER && DvarString("ui_teamC0T4") != ""))

#define CLASS_J_INVD_X (CLASS_J_INVC_X + CLASS_J_INVC_W + SPACE_INNER)
#define CLASS_J_INVD_Y CLASS_J_INVC_Y
#define CLASS_J_INVD_W CLASS_J_INVC_W
#define CLASS_J_INVD_H CLASS_J_INVD_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_J_INVD_X, CLASS_J_INVD_Y, CLASS_J_INVD_W, CLASS_J_INVD_H, DvarString("ui_teamC0T5"),
	OPEN_ALLIES_INVD, ;, ;, (IS_OPENED_ALLIES && DvarString("ui_classType") == ALLIES_INVD), (CLASS_TEAM_CURRENT == CLASS_TEAM_JUMPER && DvarString("ui_teamC0T5") != ""))


// == ACTIVATOR ==
#define CLASS_A_BODY_X (CLASS_X + SPACE_INNER)
#define CLASS_A_BODY_Y (CLASS_TAB_Y + CLASS_TAB_H + SPACE_INNER)
#define CLASS_A_BODY_W (CLASS_W - (SPACE_INNER + SPACE_INNER))
#define CLASS_A_BODY_H CLASS_A_BODY_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_A_BODY_X, CLASS_A_BODY_Y, CLASS_A_BODY_W, CLASS_A_BODY_H, DvarString("ui_teamC1T0"),
	OPEN_AXIS_BODY, ;, ;, (IS_OPENED_AXIS && DvarString("ui_classType") == AXIS_BODY), (CLASS_TEAM_CURRENT == CLASS_TEAM_ACTIVATOR && DvarString("ui_teamC1T0") != ""))

#define CLASS_A_WEAPON_X (CLASS_X + SPACE_INNER)
#define CLASS_A_WEAPON_Y (CLASS_A_BODY_Y + CLASS_A_BODY_H + SPACE_INNER)
#define CLASS_A_WEAPON_W (CLASS_W - (SPACE_INNER + SPACE_INNER))
#define CLASS_A_WEAPON_H (CLASS_A_WEAPON_W * 0.5)

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_A_WEAPON_X, CLASS_A_WEAPON_Y, CLASS_A_WEAPON_W, CLASS_A_WEAPON_H, DvarString("ui_teamC1T1"),
	OPEN_AXIS_WEAPON, ;, ;, (IS_OPENED_AXIS && DvarString("ui_classType") == AXIS_WEAPON), (CLASS_TEAM_CURRENT == CLASS_TEAM_ACTIVATOR && DvarString("ui_teamC1T1") != ""))

#define CLASS_A_INVA_X (CLASS_X + SPACE_INNER)
#define CLASS_A_INVA_Y (CLASS_A_WEAPON_Y + CLASS_A_WEAPON_H + SPACE_INNER)
#define CLASS_A_INVA_W ((CLASS_W - (SPACE_INNER * 3)) * 0.5)
#define CLASS_A_INVA_H CLASS_A_INVA_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_A_INVA_X, CLASS_A_INVA_Y, CLASS_A_INVA_W, CLASS_A_INVA_H, DvarString("ui_teamC1T2"),
	OPEN_AXIS_INVA, ;, ;, (IS_OPENED_AXIS && DvarString("ui_classType") == AXIS_INVA), (CLASS_TEAM_CURRENT == CLASS_TEAM_ACTIVATOR && DvarString("ui_teamC1T2") != ""))

#define CLASS_A_INVB_X (CLASS_A_INVA_X + CLASS_A_INVA_W + SPACE_INNER)
#define CLASS_A_INVB_Y CLASS_A_INVA_Y
#define CLASS_A_INVB_W CLASS_A_INVA_W
#define CLASS_A_INVB_H CLASS_A_INVB_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_A_INVB_X, CLASS_A_INVB_Y, CLASS_A_INVB_W, CLASS_A_INVB_H, DvarString("ui_teamC1T3"),
	OPEN_AXIS_INVB, ;, ;, (IS_OPENED_AXIS && DvarString("ui_classType") == AXIS_INVB), (CLASS_TEAM_CURRENT == CLASS_TEAM_ACTIVATOR && DvarString("ui_teamC1T3") != ""))

#define CLASS_A_INVC_X (CLASS_X + SPACE_INNER)
#define CLASS_A_INVC_Y (CLASS_A_INVA_Y + CLASS_A_INVA_H + SPACE_INNER)
#define CLASS_A_INVC_W CLASS_A_INVA_W
#define CLASS_A_INVC_H CLASS_A_INVC_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_A_INVC_X, CLASS_A_INVC_Y, CLASS_A_INVC_W, CLASS_A_INVC_H, DvarString("ui_teamC1T4"),
	OPEN_AXIS_INVC, ;, ;, (IS_OPENED_AXIS && DvarString("ui_classType") == AXIS_INVC), (CLASS_TEAM_CURRENT == CLASS_TEAM_ACTIVATOR && DvarString("ui_teamC1T4") != ""))

#define CLASS_A_INVD_X (CLASS_A_INVC_X + CLASS_A_INVC_W + SPACE_INNER)
#define CLASS_A_INVD_Y CLASS_A_INVC_Y
#define CLASS_A_INVD_W CLASS_A_INVC_W
#define CLASS_A_INVD_H CLASS_A_INVD_W

SHADER_DYNAMIC_BTN_SELECTABLE(CLASS_A_INVD_X, CLASS_A_INVD_Y, CLASS_A_INVD_W, CLASS_A_INVD_H, DvarString("ui_teamC1T5"),
	OPEN_AXIS_INVD, ;, ;, (IS_OPENED_AXIS && DvarString("ui_classType") == AXIS_INVD), (CLASS_TEAM_CURRENT == CLASS_TEAM_ACTIVATOR && DvarString("ui_teamC1T5") != ""))
