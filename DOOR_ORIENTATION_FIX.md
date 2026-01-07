# 🚪 Door Orientation Fix

## Problem
Doors were perpendicular to walls (sticking through them) instead of being parallel and embedded in the walls.

## Solution

### Changes Made:

1. **Added Door Orientation Parameter**
   - Doors now have `orientation` parameter: `'vertical'` or `'horizontal'`
   - Vertical: for left/right walls (rotated 90°)
   - Horizontal: for front/back walls (default rotation)

2. **Door Rotation**
   - Vertical doors: `rotation.y = Math.PI / 2` (90 degrees)
   - Horizontal doors: `rotation.y = 0` (default)

3. **Double-Sided Materials**
   - Added `side: THREE.DoubleSide` to door materials
   - Added `side: THREE.DoubleSide` to door label materials
   - Added `side: THREE.DoubleSide` to exit door materials
   - Doors and labels now visible from both inside and outside

4. **Improved Door Geometry**
   - Changed door depth from 0.3 to 0.2 units (thinner)
   - Better fits within wall thickness (0.5 units)

5. **Label Positioning**
   - Labels now positioned correctly based on door orientation
   - Vertical doors: label positioned on X axis, rotated 90°
   - Horizontal doors: label positioned on Z axis
   - Labels offset by 0.15 units from door surface

## Door Layout in Lobby

```
              BACK WALL (-15z)
         [CRYPTO]    [BINARY]
              |          |

LEFT WALL     LOBBY      RIGHT WALL
(-15x)                   (+15x)
[REVERSE]                [WEB]
[FORENSICS]              (OPEN)

              FRONT WALL (+15z)
```

### Door Positions:
- **Web Room** (Right wall): X=+15, vertical orientation
- **Crypto Room** (Back wall): Z=-15, horizontal orientation
- **Binary Room** (Back wall): Z=-15, horizontal orientation
- **Reverse Room** (Left wall): X=-15, vertical orientation
- **Forensics Room** (Left wall): X=-15, vertical orientation

## Technical Details

### Door Creation:
```javascript
createDoor(x, y, z, roomName, isOpen, color, unlocksAfter, orientation)
```

### Orientation Values:
- `'vertical'` - For left/right walls (X=±15)
- `'horizontal'` - For front/back walls (Z=±15)

### Material Properties:
```javascript
new THREE.MeshStandardMaterial({
    color: isOpen ? color : 0xabcdef,
    emissive: isOpen ? color : 0xaaaaaa,
    emissiveIntensity: isOpen ? 0.3 : 0,
    transparent: isOpen,
    opacity: isOpen ? 0.3 : 1,
    side: THREE.DoubleSide // KEY CHANGE
})
```

## Benefits

✅ Doors are now parallel to walls (not perpendicular)
✅ Doors visible from both lobby and inside rooms
✅ Labels visible from both sides
✅ Proper embedding in wall geometry
✅ No more doors sticking through walls
✅ Better visual appearance
✅ Exit doors also have double-sided visibility

## Testing

### From Lobby:
1. Start in lobby
2. Look at walls - doors should be flat against walls
3. Walk up to each door
4. Should see door labels clearly

### From Inside Room:
1. Enter Web room
2. Turn around
3. Should see the same door from inside
4. Door should be visible in the wall
5. Can see exit door at back (also double-sided)

## Files Modified

**`/code/web_app/views/escape_room_3d.ejs`**
- Line 247-251: Added orientation parameter to door creation calls
- Line 389-415: Updated createDoor() function with rotation logic
- Line 417-449: Updated addDoorLabel() with orientation handling
- Line 397: Added `side: THREE.DoubleSide` to door material
- Line 434: Added `side: THREE.DoubleSide` to label material
- Line 460: Added `side: THREE.DoubleSide` to exit door material
- Line 483: Added `side: THREE.DoubleSide` to exit door label
- Line 958-963: Updated updateDoorLabel() to pass orientation

## Summary

Doors are now:
- **Parallel** to walls (not perpendicular)
- **Embedded** in the wall surface
- **Visible** from both sides (lobby and room interior)
- **Properly rotated** based on which wall they're on
- **Double-sided** for correct rendering

All colors remain **ABCDEF compliant**! ✓
