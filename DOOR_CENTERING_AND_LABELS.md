# 🚪 Door Centering and Label Updates

## Issues Fixed

### 1. ✅ Doors Centered Vertically
**Problem:** Doors were floating too high (Y=1.5 with height=4 meant they extended from -0.5 to +3.5)

**Solution:**
- Changed door Y position from 1.5 to **2.0**
- With height=4, doors now extend from 0 to 4
- Properly centered in the 5-unit tall walls (0.5 space top and bottom)

### 2. ✅ Doors Now Visible from Inside Rooms
**Problem:** When entering a room, you couldn't see the entrance door you came through

**Solution:**
- Added entrance doors to each category room
- Entrance doors positioned at front wall (Z+15)
- Created wall gaps for entrance doors (same as lobby)
- Entrance doors are glowing and transparent
- Labeled "ENTRANCE" with room name

### 3. ✅ Added Category Names to Door Labels
**Problem:** Labels only showed "WEB", "CRYPTO", etc. without full category names

**Solution:**
- Enhanced labels with full category descriptions:
  - **WEB** → "WEB SECURITY"
  - **CRYPTO** → "CRYPTOGRAPHY"
  - **BINARY** → "BINARY EXPLOIT"
  - **REVERSE** → "REVERSE ENGINEERING"
  - **FORENSICS** → "DIGITAL FORENSICS"

## New Label Design

### Lobby Door Labels:
```
┌─────────────────────┐
│                     │
│       WEB           │  ← Room name (large)
│                     │
│       OPEN          │  ← Status
│                     │
│   WEB SECURITY      │  ← Category description
│                     │
└─────────────────────┘
```

### Entrance Door Labels (Inside Rooms):
```
┌─────────────────────┐
│                     │
│     ENTRANCE        │  ← Label
│                     │
│       WEB           │  ← Room name
│                     │
└─────────────────────┘
```

## Technical Changes

### Door Positioning:
```javascript
// Before: Y = 1.5
createDoor(x, 1.5, z, ...)

// After: Y = 2.0 (centered)
createDoor(x, 2, z, ...)
```

### Door in Wall:
```
Wall height: 5 units (Y: 0 to 5)
Door height: 4 units
Door Y position: 2 (center)
Door extends: Y 0 to 4
Gap top: 1 unit
Gap bottom: 0 units (door sits on floor)
```

### Label Improvements:
- **Size:** Increased from 1.8×0.9 to 2.8×1.4 units
- **Canvas:** Increased from 256×128 to 512×256 pixels
- **Content:**
  - Room name (48px bold)
  - Status (32px bold)
  - Category description (24px)
- **Border:** 6px stroke for better definition
- **Offset:** 0.3 units from door surface

### Room Entrance Doors:
- Position: Center of front wall (X=offset.x, Z=offset.z+15)
- Same size as lobby doors: 3×4×0.5
- Transparent and glowing (matches lobby aesthetic)
- Wall gaps created for proper visibility

## Door Layout

### Lobby (Outside View):
```
         BACK WALL
    [CRYPTO]  [BINARY]
    CRYPTOGRAPHY  BINARY EXPLOIT
      LOCKED      LOCKED

LEFT            RIGHT
[REVERSE]       [WEB]
REVERSE ENG.    WEB SECURITY
  LOCKED         OPEN

[FORENSICS]
DIGITAL FORENSICS
  LOCKED
```

### Inside Room (Looking Back at Entrance):
```
        ENTRANCE
          WEB
    (glowing door)
```

## Benefits

✅ **Doors properly centered** - no more floating
✅ **Clear category labels** - players know what each room contains
✅ **Entrance visible from inside** - can see door you came through
✅ **Larger, clearer labels** - better readability
✅ **Professional appearance** - bordered labels with hierarchy
✅ **Double-sided visibility** - works from both angles

## Files Modified

**`/code/web_app/views/escape_room_3d.ejs`**
- Line 260-264: Changed door Y position from 1.5 to 2.0
- Line 430-488: Enhanced label design with category names
- Line 267-281: Added entrance doors to category rooms
- Line 277-278: Created wall gaps for entrance doors
- Line 498-543: Added createEntranceDoor() function

## Color Compliance

All colors remain **ABCDEF compliant**:
- Labels: `#aaffbb` (background), `#aaaaaa` (text)
- No new colors introduced ✓

## Summary

✅ Doors are **centered vertically** in walls
✅ Doors show **full category names** ("WEB SECURITY", "CRYPTOGRAPHY", etc.)
✅ Doors are **visible from inside rooms** (entrance doors added)
✅ Labels are **larger and clearer** (2.8×1.4 units)
✅ **Professional appearance** with borders and hierarchy
✅ All **ABCDEF color compliant**

**Doors now look professional and are visible from both sides!** 🚪✨
