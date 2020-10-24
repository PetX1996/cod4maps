// "ui_vicVis" // visible?

// "ui_vicM" // who kills who
// "ui_vicRC" // current round
// "ui_vicRM" // maximal round
// "ui_vicD" // duration

/*
// "ui_vicBR" + i + "N" // name of best record
// "ui_vicBR" + i + "V" // value of best record
// "ui_vicWR" + i + "N" // name of worst record
// "ui_vicWR" + i + "V" // value of worst record
*/

// "ui_vicCHC // count
// "ui_vicCH" + i + "T" // title
// "ui_vicCH" + i + "D" // description
// "ui_vicCH" + i + "L" // last count
// "ui_vicCH" + i + "I" // inc count
// "ui_vicCH" + i + "M" // max count

// ui_vicXPL // Last
// ui_vicXPI // Inc
// ui_vicXPM // Max
// ui_vicXPE // lEft

// "ui_vicS" // song name

#undef SPACE_WINDOWS
#define SPACE_WINDOWS 10

#undef SPACE_INNER
#define SPACE_INNER 5

#define ROUND_W 610
#define ROUND_H 40

#define STATS_W 610
#define STATS_H 260

#define SONG_W 610
#define SONG_H 20

#define ALL_W ROUND_W
#define ALL_H (ROUND_H + SPACE_WINDOWS + STATS_H + SPACE_WINDOWS + SONG_H)
#define ALL_X ((640 - ALL_W) * 0.5)
#define ALL_Y ((480 - ALL_H) * 0.5)

#define ROUND_X ALL_X
#define ROUND_Y ALL_Y

#define STATS_X ALL_X
#define STATS_Y (ROUND_Y + ROUND_H + SPACE_WINDOWS)

#define SONG_X ALL_X
#define SONG_Y (STATS_Y + STATS_H + SPACE_WINDOWS)

// ============================================================================= //
// ROUND
#define ROUND_STATUS_X ROUND_X
#define ROUND_STATUS_Y ROUND_Y
#define ROUND_STATUS_W ROUND_W
#define ROUND_STATUS_H (ROUND_H * 0.5)

#define ROUND_ROUNDS_X ROUND_X
#define ROUND_ROUNDS_Y (ROUND_STATUS_Y + ROUND_STATUS_H)
#define ROUND_ROUNDS_W ROUND_W
#define ROUND_ROUNDS_H (ROUND_H * 0.5)

//PANEL_STATIC(ROUND_X, ROUND_Y, ROUND_W, ROUND_H, COLOR_BG_TRANSPARENT, 1)

//PANEL_STATIC(ROUND_STATUS_X, ROUND_STATUS_Y, ROUND_STATUS_W, ROUND_STATUS_H, COLOR_BG_TRANSPARENT, 1)
PANEL_STATIC(ROUND_ROUNDS_X, ROUND_ROUNDS_Y, ROUND_ROUNDS_W, ROUND_ROUNDS_H, COLOR_BG_TRANSPARENT, 1)
//#define TIMEPROGRESS_FRAC (1 - (((Milliseconds() - DvarInt("ui_vicOpenTime")) / 1000) / DvarInt("ui_vicTime")))
//PANEL_DYNAMIC_W(ROUND_STATUS_X, ROUND_STATUS_Y, (ROUND_STATUS_W * TIMEPROGRESS_FRAC), ROUND_STATUS_H, COLOR_FG_HIGHLIGHT, 1)
TEXT_DYNAMIC(ROUND_STATUS_X, ROUND_STATUS_Y, ROUND_STATUS_W, ROUND_STATUS_H, DvarString("ui_vicM"), FONTSCALE_20, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, 1)

TEXT_DYNAMIC(ROUND_ROUNDS_X, ROUND_ROUNDS_Y, ROUND_ROUNDS_W, ROUND_ROUNDS_H, "Round " + DvarInt("ui_vicRC") + " of " + DvarInt("ui_vicRM"), FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, 1)
TEXT_DYNAMIC(ROUND_ROUNDS_X, ROUND_ROUNDS_Y, ROUND_ROUNDS_W, ROUND_ROUNDS_H, "Duration " + SecondsAsCountdown(DvarInt("ui_vicD")), FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_RIGHT textAlignX -4, 1)


// ============================================================================= //
// CHALLENGES

#define PROGRESS_X ITEMS_X
#define PROGRESS_W ITEMS_W
#define PROGRESS_H 20

// ITEM LIST
#define ITEMS_X (STATS_X + SPACE_INNER)
#define ITEMS_Y (STATS_Y + SPACE_INNER)
#define ITEMS_W (STATS_W - (SPACE_INNER * 2))

#define ITEMS_COUNT DvarInt("ui_vicCHC")
#define ITEM_BAR_H 10.5
#define ITEM_DES_H 10
#define ITEM_W ITEMS_W
#define ITEM_H (ITEM_BAR_H + ITEM_DES_H)

#define ITEMS_DYN_H ((ITEM_H * ITEMS_COUNT) + (SPACE_INNER * (ITEMS_COUNT - 1)))
#define STATS_DYN_H (ITEMS_DYN_H + PROGRESS_H + (SPACE_INNER * 3))

#define ITEM_GETY(i) (ITEMS_Y + (ITEM_H * i) + (SPACE_INNER * i))
#define ITEM_VIS(i) (i < DvarInt("ui_vicCHC"))


#define PROGRESS_DYN_Y (ITEMS_Y + ITEMS_DYN_H + SPACE_INNER)


PANEL_DYNAMIC_H(STATS_X, STATS_Y, STATS_W, STATS_DYN_H, COLOR_BG_TRANSPARENT, 1)

#define ITEM(i) \
	PANEL_STATIC(ITEMS_X, ITEM_GETY(i), ITEM_W, ITEM_H, \
		COLOR_BG_TRANSPARENT, ITEM_VIS(i)) \
	PANEL_STATIC(ITEMS_X, ITEM_GETY(i), ITEM_W, ITEM_BAR_H, \
		COLOR_BG_TRANSPARENT, ITEM_VIS(i)) \
	PANEL_DYNAMIC_W(ITEMS_X, ITEM_GETY(i), (ITEM_W * (DvarInt("ui_vicCH" + i + "L") / DvarInt("ui_vicCH" + i + "M"))), ITEM_BAR_H, \
		COLOR_FG_PROGRESSBAR, ITEM_VIS(i))\
	PANEL_DYNAMIC_XW((ITEMS_X + (ITEM_W * (DvarInt("ui_vicCH" + i + "L") / DvarInt("ui_vicCH" + i + "M")))), ITEM_GETY(i), (ITEM_W * (DvarInt("ui_vicCH" + i + "I") / DvarInt("ui_vicCH" + i + "M"))), ITEM_BAR_H, \
		COLOR_FG_PROGRESSBAR_INC, ITEM_VIS(i)) \
	TEXT_DYNAMIC(ITEMS_X, ITEM_GETY(i), ITEM_W, ITEM_BAR_H, \
		DvarString("ui_vicCH" + i + "T"), FONTSCALE_10, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 2, ITEM_VIS(i)) \
	TEXT_DYNAMIC(ITEMS_X, ITEM_GETY(i), ITEM_W, ITEM_BAR_H, \
		DvarString("ui_vicCH" + i + "L") + "^2+" + DvarString("ui_vicCH" + i + "I") + "^7/" + DvarString("ui_vicCH" + i + "M"), FONTSCALE_10, COLOR_WHITE, ITEM_ALIGN_MIDDLE_RIGHT textAlignX -2, ITEM_VIS(i)) \
	TEXT_DYNAMIC(ITEMS_X, (ITEM_GETY(i) + ITEM_BAR_H), ITEM_W, ITEM_DES_H, \
		DvarString("ui_vicCH" + i + "D"), FONTSCALE_10, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 2, ITEM_VIS(i)) \
		
ITEM(0)
ITEM(1)
ITEM(2)
ITEM(3)
ITEM(4)
ITEM(5)
ITEM(6)
ITEM(7)
ITEM(8)
//ITEM(9)

// ========================================================================================================= //
// PROGRESS

// PLAYER STATS
#define RANKS_MAXRANK 100
#define RANKS_HORIZONTAL 10
#define RANKS_VERTICAL 10

//#define CUR_RANKID DvarInt("ui_r")
#define CUR_RANKID Stat(TableLookUp("mp/playerStatsTable.csv", 1, "RANK", 0))
#define CUR_RANKXP Stat(TableLookUp("mp/playerStatsTable.csv", 1, "RANKXP", 0))

#define CUR_MINXP Stat(TableLookUp("mp/playerStatsTable.csv", 1, "MINXP", 0))
#define CUR_MAXXP Stat(TableLookUp("mp/playerStatsTable.csv", 1, "MAXXP", 0))

#define CUR_NEXTXP (CUR_MAXXP - CUR_MINXP)
#define CUR_LEFTXP Stat(TableLookUp("mp/playerStatsTable.csv", 1, "LEFTXP", 0))

#define CUR_CHCUR Stat(TableLookUp("mp/playerStatsTable.csv", 1, "CHCUR", 0))
#define CUR_CHMAX Stat(TableLookUp("mp/playerStatsTable.csv", 1, "CHMAX", 0))

#define CUR_PRESTIGE Stat(TableLookUp("mp/playerStatsTable.csv", 1, "PLEVEL", 0))

#define CUR_ISRANKFREEZED (CUR_RANKID % 10 == 9)
#define CUR_ISXPCOLLECTING (CUR_LEFTXP != 0)
#define CUR_ISCHWAITING (CUR_LEFTXP == 0)



PANEL_DYNAMIC_Y(PROGRESS_X, PROGRESS_DYN_Y, PROGRESS_W, PROGRESS_H, COLOR_BG_TRANSPARENT, 1)

PANEL_DYNAMIC_W(PROGRESS_X, 0, (PROGRESS_W * (DvarInt("ui_vicXPL") / DvarInt("ui_vicXPM"))), PROGRESS_H, 
	COLOR_FG_PROGRESSBAR exp rect Y(PROGRESS_DYN_Y), (CUR_RANKID != RANKS_MAXRANK))
PANEL_DYNAMIC_XW((PROGRESS_X + (PROGRESS_W * (DvarInt("ui_vicXPL") / DvarInt("ui_vicXPM")))), 0, (PROGRESS_W * (DvarInt("ui_vicXPI") / DvarInt("ui_vicXPM"))), PROGRESS_H, 
	COLOR_FG_PROGRESSBAR_INC exp rect Y(PROGRESS_DYN_Y), (CUR_RANKID != RANKS_MAXRANK))
//PANEL_STATIC(PROGRESS_X, PROGRESS_Y, PROGRESS_W, PROGRESS_H, 
	//COLOR_FG_HIGHLIGHT, CUR_RANKID == RANKS_MAXRANK && CUR_ISRANKFREEZED == 0)

TEXT_DYNAMIC(PROGRESS_X, 0, PROGRESS_W, PROGRESS_H, 
	"LVL: " + TableLookUp("mp/rankTable.csv", 0, CUR_RANKID, 13), FONTSCALE_14, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 5 exp rect Y(PROGRESS_DYN_Y), 1)
TEXT_DYNAMIC(PROGRESS_X, 0, PROGRESS_W, PROGRESS_H, 
	"Left: " + DvarString("ui_vicXPE") + " XP", FONTSCALE_14, COLOR_WHITE, ITEM_ALIGN_MIDDLE_CENTER exp rect Y(PROGRESS_DYN_Y), (CUR_RANKID != RANKS_MAXRANK && CUR_LEFTXP > 0))
TEXT_DYNAMIC(PROGRESS_X, 0, PROGRESS_W, PROGRESS_H, 
	DvarString("ui_vicXPL") + "^2+" + DvarString("ui_vicXPI") + "^7/" + DvarString("ui_vicXPM") + " XP", FONTSCALE_14, COLOR_WHITE, ITEM_ALIGN_MIDDLE_RIGHT textAlignX -5 exp rect Y(PROGRESS_DYN_Y), 1)


// ============================================================================= //
// STATS
/*#define STATS_BEST_X STATS_X
#define STATS_BEST_Y STATS_Y
#define STATS_BEST_W ((STATS_W - SPACE_WINDOWS) * 0.5)
#define STATS_BEST_H STATS_H

#define STATS_BEST_TITLE_X STATS_BEST_X
#define STATS_BEST_TITLE_Y STATS_BEST_Y
#define STATS_BEST_TITLE_W STATS_BEST_W
#define STATS_BEST_TITLE_H 20

#define STATS_BEST_STATS_X STATS_BEST_X
#define STATS_BEST_STATS_Y (STATS_BEST_Y + STATS_BEST_TITLE_H)
#define STATS_BEST_STATS_W STATS_BEST_W
#define STATS_BEST_STATS_H (STATS_BEST_H - STATS_BEST_TITLE_H)

PANEL_STATIC(STATS_BEST_X, STATS_BEST_Y, STATS_BEST_W, STATS_BEST_H, COLOR_BG_TRANSPARENT, 1)
PANEL_STATIC(STATS_BEST_TITLE_X, STATS_BEST_TITLE_Y, STATS_BEST_TITLE_W, STATS_BEST_TITLE_H, COLOR_FG_HIGHLIGHT, 1)
TEXT_STATIC(STATS_BEST_TITLE_X, STATS_BEST_TITLE_Y, STATS_BEST_TITLE_W, STATS_BEST_TITLE_H, 
	"The Best", FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, 1)

#define STATS_BEST_STAT_W STATS_BEST_STATS_W
#define STATS_BEST_STAT_H 14.5
#define STATS_BEST_STAT_GETX(i) (STATS_BEST_STATS_X)
#define STATS_BEST_STAT_GETY(i) (STATS_BEST_STATS_Y + (STATS_BEST_STAT_H * i))

#define STATS_BEST_STAT(i) \
	TEXT_DYNAMIC(STATS_BEST_STAT_GETX(i), STATS_BEST_STAT_GETY(i), STATS_BEST_STAT_W, STATS_BEST_STAT_H, \
		DvarString("ui_vicBR" + i + "N"), FONTSCALE_12, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 2, 1) \
	TEXT_DYNAMIC(STATS_BEST_STAT_GETX(i), STATS_BEST_STAT_GETY(i), STATS_BEST_STAT_W, STATS_BEST_STAT_H, \
		DvarString("ui_vicBR" + i + "V"), FONTSCALE_12, COLOR_WHITE, ITEM_ALIGN_MIDDLE_RIGHT textAlignX -2, 1) \	
	
STATS_BEST_STAT(0)
STATS_BEST_STAT(1)
STATS_BEST_STAT(2)
STATS_BEST_STAT(3)
STATS_BEST_STAT(4)
STATS_BEST_STAT(5)
STATS_BEST_STAT(6)
STATS_BEST_STAT(7)
STATS_BEST_STAT(8)
STATS_BEST_STAT(9)
STATS_BEST_STAT(10)
STATS_BEST_STAT(11)
STATS_BEST_STAT(12)

#define STATS_WORST_X (STATS_BEST_X + STATS_BEST_W + SPACE_WINDOWS)
#define STATS_WORST_Y STATS_Y
#define STATS_WORST_W ((STATS_W - SPACE_WINDOWS) * 0.5)
#define STATS_WORST_H STATS_H

#define STATS_WORST_TITLE_X STATS_WORST_X
#define STATS_WORST_TITLE_Y STATS_WORST_Y
#define STATS_WORST_TITLE_W STATS_WORST_W
#define STATS_WORST_TITLE_H 20

#define STATS_WORST_STATS_X STATS_WORST_X
#define STATS_WORST_STATS_Y (STATS_WORST_Y + STATS_WORST_TITLE_H)
#define STATS_WORST_STATS_W STATS_WORST_W
#define STATS_WORST_STATS_H (STATS_WORST_H - STATS_WORST_TITLE_H)

PANEL_STATIC(STATS_WORST_X, STATS_WORST_Y, STATS_WORST_W, STATS_WORST_H, COLOR_BG_TRANSPARENT, 1)
PANEL_STATIC(STATS_WORST_TITLE_X, STATS_WORST_TITLE_Y, STATS_WORST_TITLE_W, STATS_WORST_TITLE_H, COLOR_FG_HIGHLIGHT, 1)
TEXT_STATIC(STATS_WORST_TITLE_X, STATS_WORST_TITLE_Y, STATS_WORST_TITLE_W, STATS_WORST_TITLE_H, 
	"The Worst", FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, 1)

#define STATS_WORST_STAT_W STATS_WORST_STATS_W
#define STATS_WORST_STAT_H 14.5
#define STATS_WORST_STAT_GETX(i) (STATS_WORST_STATS_X)
#define STATS_WORST_STAT_GETY(i) (STATS_WORST_STATS_Y + (STATS_WORST_STAT_H * i))

#define STATS_WORST_STAT(i) \
	TEXT_DYNAMIC(STATS_WORST_STAT_GETX(i), STATS_WORST_STAT_GETY(i), STATS_WORST_STAT_W, STATS_WORST_STAT_H, \
		DvarString("ui_vicWR" + i + "N"), FONTSCALE_12, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 2, 1) \
	TEXT_DYNAMIC(STATS_WORST_STAT_GETX(i), STATS_WORST_STAT_GETY(i), STATS_WORST_STAT_W, STATS_WORST_STAT_H, \
		DvarString("ui_vicWR" + i + "V"), FONTSCALE_12, COLOR_WHITE, ITEM_ALIGN_MIDDLE_RIGHT textAlignX -2, 1) \	
	
STATS_WORST_STAT(0)
STATS_WORST_STAT(1)
STATS_WORST_STAT(2)
STATS_WORST_STAT(3)
STATS_WORST_STAT(4)
STATS_WORST_STAT(5)
STATS_WORST_STAT(6)
STATS_WORST_STAT(7)
STATS_WORST_STAT(8)
STATS_WORST_STAT(9)
STATS_WORST_STAT(10)
STATS_WORST_STAT(11)
STATS_WORST_STAT(12)
*/
// ============================================================================= //
// SONG
#define SONG_DYN_Y (STATS_Y + STATS_DYN_H + SPACE_WINDOWS)

#define SONG_ICON_H SONG_H
#define SONG_ICON_W SONG_ICON_H
#define SONG_ICON_X SONG_X
#define SONG_ICON_Y SONG_DYN_Y

PANEL_DYNAMIC_Y(SONG_X, SONG_DYN_Y, SONG_W, SONG_H, COLOR_BG_TRANSPARENT, DvarString("ui_vicS") != "")
SHADER_STATIC(SONG_ICON_X, 0, SONG_ICON_W, SONG_ICON_H, "voice_on", COLOR_WHITE exp rect Y(SONG_DYN_Y), DvarString("ui_vicS") != "")
TEXT_DYNAMIC((SONG_X + SONG_ICON_W), 0, (SONG_W - SONG_ICON_W), SONG_H, 
	DvarString("ui_vicS"), FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4 exp rect Y(SONG_DYN_Y), 1)
