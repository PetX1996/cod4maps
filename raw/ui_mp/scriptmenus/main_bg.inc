// ui_mainS // song name
// ui_mainVer

#define SPACE_WINDOWS 10
#define SPACE_INNER 5

#define MENU_W 120
#define MENU_H 290

#define CENTER_W 360
#define CENTER_H MENU_H

#define CLASS_W 110
#define CLASS_H MENU_H

#define MENU_X ((640 - (MENU_W + SPACE_WINDOWS + CENTER_W + SPACE_WINDOWS + CLASS_W)) * 0.5)
#define MENU_Y ((480 - MENU_H) * 0.5)

#define CENTER_X (MENU_X + MENU_W + SPACE_WINDOWS)
#define CENTER_Y MENU_Y

#define CLASS_X (CENTER_X + CENTER_W + SPACE_WINDOWS)
#define CLASS_Y	MENU_Y


#define CENTER_LOGO_H (CENTER_Y * 0.8)
#define CENTER_LOGO_W (CENTER_W * 0.6)
#define CENTER_LOGO_X (CENTER_X + ((CENTER_W - CENTER_LOGO_W) * 0.5))
#define CENTER_LOGO_Y ((CENTER_Y - CENTER_LOGO_H) * 0.5)
SHADER_STATIC(CENTER_LOGO_X, CENTER_LOGO_Y, CENTER_LOGO_W, CENTER_LOGO_H, "ui_logodr", COLOR_WHITE, 1)

#define CENTER_VER_W CENTER_W
#define CENTER_VER_H 14
#define CENTER_VER_X CENTER_X
#define CENTER_VER_Y (480 - CENTER_VER_H)
TEXT_DYNAMIC(CENTER_VER_X, CENTER_VER_Y, CENTER_VER_W, CENTER_VER_H, 
	DvarString("ui_mainVer"), FONTSCALE_14, 1 1 1 0.3, ITEM_ALIGN_MIDDLE_CENTER, 1)
	
TEXT_STATIC(CENTER_VER_X, (CENTER_VER_Y - CENTER_VER_H), CENTER_VER_W, CENTER_VER_H, 
	"WwW.Deathrun2.CoM", FONTSCALE_14, 1 1 1 0.3, ITEM_ALIGN_MIDDLE_CENTER, 1)
	
// CENTER BAR
#define CENTER_BAR_X CENTER_X
#define CENTER_BAR_Y CENTER_Y
#define CENTER_BAR_W CENTER_W
#define CENTER_BAR_H 20

#define CENTER_BAR_STATIC(titleText) \
	PANEL_STATIC(CENTER_BAR_X, CENTER_BAR_Y, CENTER_BAR_W, CENTER_BAR_H, COLOR_FG_HIGHLIGHT, 1) \
	TEXT_STATIC(CENTER_BAR_X, CENTER_BAR_Y, CENTER_BAR_W, CENTER_BAR_H, titleText, FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, 1) \

#define CENTER_BAR_DYNAMIC(titleText) \
	PANEL_STATIC(CENTER_BAR_X, CENTER_BAR_Y, CENTER_BAR_W, CENTER_BAR_H, COLOR_FG_HIGHLIGHT, 1) \
	TEXT_DYNAMIC(CENTER_BAR_X, CENTER_BAR_Y, CENTER_BAR_W, CENTER_BAR_H, titleText, FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, 1) \	
	
// CENTER ARROWS
#define CENTER_BAR_ARROW_W (CENTER_BAR_H - (SPACE_INNER * 2))
#define CENTER_BAR_ARROW_H CENTER_BAR_ARROW_W

#define CENTER_BAR_ARROWS_W ((CENTER_BAR_ARROW_W * 2) + SPACE_INNER)
#define CENTER_BAR_ARROWS_H CENTER_BAR_ARROW_H
#define CENTER_BAR_ARROWS_X ((CENTER_BAR_X + CENTER_BAR_W) - CENTER_BAR_ARROWS_W - SPACE_INNER)
#define CENTER_BAR_ARROWS_Y (CENTER_BAR_Y + SPACE_INNER)

#define CENTER_BAR_ARROWS(actionPrev, actionNext, visPrev, visNext) \
	SHADER_STATIC_BTN(CENTER_BAR_ARROWS_X, CENTER_BAR_ARROWS_Y, CENTER_BAR_ARROW_W, CENTER_BAR_ARROW_H, "ui_scrollbar_arrow_left", actionPrev, ;, ;, visPrev) \
	SHADER_STATIC_BTN((CENTER_BAR_ARROWS_X + SPACE_INNER + CENTER_BAR_ARROW_W), CENTER_BAR_ARROWS_Y, CENTER_BAR_ARROW_W, CENTER_BAR_ARROW_H, "ui_scrollbar_arrow_right", actionNext, ;, ;, visNext) \


// WORKSPACE
#define CENTER_WORKSPACE_X CENTER_X
#define CENTER_WORKSPACE_Y (CENTER_Y + CENTER_BAR_H)
#define CENTER_WORKSPACE_W CENTER_W
#define CENTER_WORKSPACE_H (CENTER_H - CENTER_BAR_H)

// ============================================================================= //
// SONG
#define CENTER_SONG_W CENTER_W
#define CENTER_SONG_H 20
#define CENTER_SONG_X CENTER_X
#define CENTER_SONG_Y (CENTER_Y + CENTER_H + SPACE_WINDOWS)

#define CENTER_SONG_ICON_H CENTER_SONG_H
#define CENTER_SONG_ICON_W CENTER_SONG_ICON_H
#define CENTER_SONG_ICON_X CENTER_SONG_X
#define CENTER_SONG_ICON_Y CENTER_SONG_Y

PANEL_STATIC(CENTER_SONG_X, CENTER_SONG_Y, CENTER_SONG_W, CENTER_SONG_H, COLOR_BG_TRANSPARENT, DvarString("ui_mainS") != "")
SHADER_STATIC(CENTER_SONG_ICON_X, CENTER_SONG_ICON_Y, CENTER_SONG_ICON_W, CENTER_SONG_ICON_H, "voice_on", COLOR_WHITE, DvarString("ui_mainS") != "")
TEXT_DYNAMIC((CENTER_SONG_X + CENTER_SONG_ICON_W), CENTER_SONG_Y, (CENTER_SONG_W - CENTER_SONG_ICON_W), CENTER_SONG_H, 
	DvarString("ui_mainS"), FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, 1)