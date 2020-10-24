// "onOpen,"typeIndex
// "classPrev"
// "classNext"
// "classItem,"sI

// "ui_classType"
// "ui_classIsPrev"
// "ui_classIsNext"
// "ui_classIsWide"
// "ui_classCount"
// "ui_classItem" + sI + "M"
// "ui_classItem" + sI + "T0"
// "ui_classItem" + sI + "T1"
// "ui_classItem" + sI + "T2"
// "ui_classItem" + sI + "D"

// "ui_classHgl"

// CENTER WINDOW
PANEL_STATIC(CENTER_X, CENTER_Y, CENTER_W, CENTER_H, COLOR_BG_TRANSPARENT, 1)

// CENTER BAR
PANEL_STATIC(CENTER_BAR_X, CENTER_BAR_Y, CENTER_BAR_W, CENTER_BAR_H, COLOR_FG_HIGHLIGHT, 1)
TEXT_DYNAMIC(CENTER_BAR_X, CENTER_BAR_Y, CENTER_BAR_W, CENTER_BAR_H, DvarString("ui_classType"), FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, DvarString("ui_classItem" + DvarInt("ui_classHgl") + "D") == "")
TEXT_DYNAMIC(CENTER_BAR_X, CENTER_BAR_Y, CENTER_BAR_W, CENTER_BAR_H, DvarString("ui_classItem" + DvarInt("ui_classHgl") + "D"), FONTSCALE_16, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX 4, DvarString("ui_classItem" + DvarInt("ui_classHgl") + "D") != "")

CENTER_BAR_ARROWS(setDvar ui_classCount 0; scriptMenuResponse "classPrev";, setDvar ui_classCount 0; scriptMenuResponse "classNext";, DvarBool("ui_classIsPrev"), DvarBool("ui_classIsNext"))

// ================================================================================== //
// ASPECT RATION 1:1
#define BLOCK_VIS (!DvarBool("ui_classIsWide"))
#define ITEM_VIS(sI) (BLOCK_VIS && Int(sI) < DvarInt("ui_classCount"))

#define ITEMS_H_COUNT 4
#define ITEMS_V_COUNT 3

#define ITEMS_W (CENTER_WORKSPACE_W - (SPACE_INNER * 2))

#define ITEM_W ((ITEMS_W - (SPACE_INNER * (ITEMS_H_COUNT - 1))) / ITEMS_H_COUNT)
#define ITEM_H ITEM_W

#define ITEMS_H ((ITEM_H * ITEMS_V_COUNT) + (SPACE_INNER * (ITEMS_V_COUNT - 1)))

#define ITEMS_X (CENTER_WORKSPACE_X + SPACE_INNER)
#define ITEMS_Y (CENTER_WORKSPACE_Y + SPACE_INNER)

#define GET_ITEM_X(iH)	(ITEMS_X + (ITEM_W * iH) + (SPACE_INNER * iH))
#define GET_ITEM_Y(iV)	(ITEMS_Y + (ITEM_H * iV) + (SPACE_INNER * iV))

#define ITEM_LINE_H 10

#define ITEM(sI, iH, iV) \
	SHADER_STATIC(GET_ITEM_X(iH), GET_ITEM_Y(iV), ITEM_W, ITEM_H, \
		"weapon_attachment_m203", COLOR_SHADER_OFF, (ITEM_VIS(sI) && DvarString("ui_classItem" + sI + "M") == "")) \
	TEXT_DYNAMIC(GET_ITEM_X(iH), ((GET_ITEM_Y(iV) + ITEM_H) - (ITEM_LINE_H * 3)), ITEM_W, ITEM_LINE_H, \
		DvarString("ui_classItem" + sI + "T2"), FONTSCALE_10, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX ITEM_ALIGN_X_MASK, (ITEM_VIS(sI) && DvarString("ui_classItem" + sI + "M") == "")) \
	TEXT_DYNAMIC(GET_ITEM_X(iH), ((GET_ITEM_Y(iV) + ITEM_H) - (ITEM_LINE_H * 2)), ITEM_W, ITEM_LINE_H, \
		DvarString("ui_classItem" + sI + "T1"), FONTSCALE_10, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX ITEM_ALIGN_X_MASK, (ITEM_VIS(sI) && DvarString("ui_classItem" + sI + "M") == "")) \
	TEXT_DYNAMIC(GET_ITEM_X(iH), ((GET_ITEM_Y(iV) + ITEM_H) - (ITEM_LINE_H * 1)), ITEM_W, ITEM_LINE_H, \
		DvarString("ui_classItem" + sI + "T0"), FONTSCALE_10, COLOR_WHITE, ITEM_ALIGN_MIDDLE_LEFT textAlignX ITEM_ALIGN_X_MASK, (ITEM_VIS(sI) && DvarString("ui_classItem" + sI + "M") == "")) \
	SHADER_DYNAMIC_BTN(GET_ITEM_X(iH), GET_ITEM_Y(iV), ITEM_W, ITEM_H, \
		DvarString("ui_classItem" + sI + "M"), scriptMenuResponse "classItem,"sI, setDvar ui_classHgl sI;, setDvar ui_classHgl 999;, (ITEM_VIS(sI) && DvarString("ui_classItem" + sI + "M") != "")) \

ITEM("0", 0, 0) 
ITEM("1", 1, 0)
ITEM("2", 2, 0)
ITEM("3", 3, 0)
ITEM("4", 0, 1)
ITEM("5", 1, 1)
ITEM("6", 2, 1)
ITEM("7", 3, 1)
ITEM("8", 0, 2)
ITEM("9", 1, 2)
ITEM("10", 2, 2)
ITEM("11", 3, 2)

// ================================================================================== //
// ASPECT RATION 2:1
#undef BLOCK_VIS
#define BLOCK_VIS (DvarBool("ui_classIsWide"))

#undef ITEMS_H_COUNT
#define ITEMS_H_COUNT 3
#undef ITEMS_V_COUNT
#define ITEMS_V_COUNT 4

#undef ITEM_H
#define ITEM_H (ITEM_W * 0.5)

ITEM("0", 0, 0)
ITEM("1", 1, 0)
ITEM("2", 2, 0)
ITEM("3", 0, 1)
ITEM("4", 1, 1)
ITEM("5", 2, 1)
ITEM("6", 0, 2)
ITEM("7", 1, 2)
ITEM("8", 2, 2)
ITEM("9", 0, 3)
ITEM("10", 1, 3)
ITEM("11", 2, 3)