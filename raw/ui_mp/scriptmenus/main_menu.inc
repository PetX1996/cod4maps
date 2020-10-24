PANEL_STATIC(MENU_X, MENU_Y, MENU_W, MENU_H, COLOR_BG_TRANSPARENT, 1)

#undef CHOICE_X
#undef CHOICE_Y
#undef CHOICE_W
#undef CHOICE_H
#undef CHOICE_BTN_SIZE
#undef CHOICE_SEP_SIZE
#undef CHOICE_SEP_0
#undef CHOICE_SEP_1
#undef CHOICE_SEP_2
#undef CHOICE_SEP_3
#undef CHOICE_SELECTOR

#define BTN_COUNT 8
#define SEP_COUNT 4

#define CHOICE_X MENU_X
#define CHOICE_Y MENU_Y
#define CHOICE_W MENU_W
#define CHOICE_H MENU_H

#define CHOICE_BTN_SIZE 20
#define CHOICE_SEP_SIZE ((MENU_H - (CHOICE_BTN_SIZE * BTN_COUNT)) / SEP_COUNT)

#define CHOICE_SEP_0 1
#define CHOICE_SEP_1 3
#define CHOICE_SEP_2 4
#define CHOICE_SEP_3 6

#define CHOICE_SELECTOR DvarInt("ui_mainSel")

#define MENU_BTN(btnId, i, t, onClick, bVis) \
	CHOICE_BTN_STATIC(btnId, i, t, FONTSCALE_18, ITEM_ALIGN_MIDDLE_CENTER, setDvar ui_mainSel i; onClick, ;, ;, bVis)

MENU_BTN("0", 0, "Play", scriptMenuResponse "joinAny"; close self;, 1)
MENU_BTN("1", 1, "Spectate", scriptMenuResponse "joinSpectators"; close self;, 1)

MENU_BTN("2", 2, "Rank", close self; open "rank";, 1)

// ======================================================================================================================================= //
#define CH_TYPE_STAGE0 0
#define CH_TYPE_STAGE1 1
#define CH_TYPE_STAGE2 2
#define CH_TYPE_STAGE3 3
#define CH_TYPE_STAGE4 4
#define CH_TYPE_STAGE5 5
#define CH_TYPE_STAGE6 6
#define CH_TYPE_STAGE7 7
#define CH_TYPE_STAGE8 8
#define CH_TYPE_STAGE9 9

#define CH_TYPE_JUMPER 10
#define CH_TYPE_ACTIVATOR 11
#define CH_TYPE_BONUS 12
#define CH_TYPE_MAP 13
#define CH_TYPE_SIZE 4

#define OPEN_CHALLENGES_CURSTAGE execNow "statGetInDvar 2349 ui_primary_attachment_slot; setFromDvar ui_chType ui_primary_attachment_slot"; setDvar ui_mainSel 3; close self; open "challenges";

#define OPEN_CHALLENGES_STAGE(i) 	setDvar ui_chType i; setDvar ui_mainSel 3; close self; open "challenges";
		
#define OPEN_CHALLENGES_JUMPER 		setDvar ui_chType CH_TYPE_JUMPER; setDvar ui_mainSel 3; close self; open "challenges";
#define OPEN_CHALLENGES_ACTIVATOR 	setDvar ui_chType CH_TYPE_ACTIVATOR; setDvar ui_mainSel 3; close self; open "challenges";
#define OPEN_CHALLENGES_OTHER 		setDvar ui_chType CH_TYPE_OTHER; setDvar ui_mainSel 3; close self; open "challenges";
#define OPEN_CHALLENGES_BONUS 		setDvar ui_chType CH_TYPE_BONUS; setDvar ui_mainSel 3; close self; open "challenges";
#define OPEN_CHALLENGES_MAP 		setDvar ui_chType CH_TYPE_MAP; setDvar ui_mainSel 3; close self; open "challenges";

MENU_BTN("3", 3, "Challenges", OPEN_CHALLENGES_CURSTAGE, 1)
// ======================================================================================================================================= //

MENU_BTN("4", 4, "Info", close self; open "info";, 1)

MENU_BTN("5", 5, "Controls", close self; open main_controls;, 1)
MENU_BTN("6", 6, "Options", close self; open main_options; execnow "set ui_allow_graphic_change 0";, 1)

MENU_BTN("7", 7, "Quit", open popup_leavegame;, 1)