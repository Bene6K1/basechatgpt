function RenderRectangle(X, Y, Width, Height, R, G, B, A)
  local X, Y, Width, Height =
    (tonumber(X) or 0) / 1920,
    (tonumber(Y) or 0) / 1080,
    (tonumber(Width) or 0) / 1920,
    (tonumber(Height) or 0) / 1080
  DrawRect(
    X + Width * 0.5,
    Y + Height * 0.5,
    Width,
    Height,
    tonumber(R) or 255,
    tonumber(G) or 255,
    tonumber(B) or 255,
    tonumber(A) or 255
  )
end

function RenderRoundedRectangle(X, Y, Width, Height, R, G, B, A, Radius)
  Radius = Radius or 8
  local x = math.floor((tonumber(X) or 0) + 0.5)
  local y = math.floor((tonumber(Y) or 0) + 0.5)
  local w = math.floor((tonumber(Width) or 0) + 0.5)
  local h = math.floor((tonumber(Height) or 0) + 0.5)

  local r = tonumber(R) or 255
  local g = tonumber(G) or 255
  local b = tonumber(B) or 255
  local a = tonumber(A) or 255

  local rad = math.max(0, math.floor((tonumber(Radius) or 0) + 0.5))
  rad = math.min(rad, math.floor(math.min(w, h) / 2))

  -- Main center rectangle
  RenderRectangle(x + rad, y, w - (rad * 2), h, r, g, b, a)

  -- Left and right side rectangles
  RenderRectangle(x, y + rad, rad, h - (rad * 2), r, g, b, a)
  RenderRectangle(x + w - rad, y + rad, rad, h - (rad * 2), r, g, b, a)

  -- Draw rounded corners using multiple small rectangles
  -- More segments = smoother corners (important for small UI like 20x20 checkbox)
  local segments = math.max(18, math.min(32, math.floor(rad * 2.6)))
  for i = 0, segments do
    local angle = (i / segments) * (math.pi / 2)
    local xOffset = math.cos(angle) * rad
    local yOffset = math.sin(angle) * rad
    local size = math.max(1.0, (rad / segments) * 3.0)

    -- Top-left corner
    DrawRect(
      (x + rad - xOffset + size / 2) / 1920,
      (y + rad - yOffset + size / 2) / 1080,
      size / 1920,
      size / 1080,
      r,
      g,
      b,
      a
    )

    -- Top-right corner
    DrawRect(
      (x + w - rad + yOffset + size / 2) / 1920,
      (y + rad - xOffset + size / 2) / 1080,
      size / 1920,
      size / 1080,
      r,
      g,
      b,
      a
    )

    -- Bottom-left corner
    DrawRect(
      (x + rad - yOffset + size / 2) / 1920,
      (y + h - rad + xOffset + size / 2) / 1080,
      size / 1920,
      size / 1080,
      r,
      g,
      b,
      a
    )

    -- Bottom-right corner
    DrawRect(
      (x + w - rad + xOffset + size / 2) / 1920,
      (y + h - rad + yOffset + size / 2) / 1080,
      size / 1920,
      size / 1080,
      r,
      g,
      b,
      a
    )
  end
end

function RenderBorderRectangle(X, Y, Width, Height, R, G, B, A, BorderThickness)
  local x = math.floor((tonumber(X) or 0) + 0.5)
  local y = math.floor((tonumber(Y) or 0) + 0.5)
  local w = math.floor((tonumber(Width) or 0) + 0.5)
  local h = math.floor((tonumber(Height) or 0) + 0.5)

  local t = math.floor((tonumber(BorderThickness) or 2) + 0.5)
  if t < 1 then t = 1 end

  if w <= 0 or h <= 0 then
    return
  end
  if (t * 2) > w then t = math.floor(w / 2) end
  if (t * 2) > h then t = math.floor(h / 2) end
  if t < 1 then
    return
  end

  local r = tonumber(R) or 255
  local g = tonumber(G) or 255
  local b = tonumber(B) or 255
  local a = tonumber(A) or 255

  -- Top border
  RenderRectangle(x, y, w, t, r, g, b, a)
  -- Bottom border
  RenderRectangle(x, y + h - t, w, t, r, g, b, a)
  -- Left border
  RenderRectangle(x, y, t, h, r, g, b, a)
  -- Right border
  RenderRectangle(x + w - t, y, t, h, r, g, b, a)
end

function RenderRoundedBorderRectangle(X, Y, Width, Height, BorderR, BorderG, BorderB, BorderA, BackgroundR, BackgroundG, BackgroundB, BackgroundA, BorderThickness, Radius)
  BorderThickness = BorderThickness or 2
  Radius = Radius or 8

  local w = tonumber(Width) or 0
  local h = tonumber(Height) or 0
  local t = tonumber(BorderThickness) or 2

  if w <= 0 or h <= 0 or t <= 0 then
    return
  end

  -- Outer (border)
  RenderRoundedRectangle(X, Y, w, h, BorderR, BorderG, BorderB, BorderA, Radius)

  -- Inner (background)
  local innerW = w - (t * 2)
  local innerH = h - (t * 2)
  if innerW <= 0 or innerH <= 0 then
    return
  end
  RenderRoundedRectangle(X + t, Y + t, innerW, innerH, BackgroundR, BackgroundG, BackgroundB, BackgroundA, math.max(0, Radius - t))
end

function RenderRoundedOutlineRectangle(X, Y, Width, Height, R, G, B, A, BorderThickness, Radius)
  BorderThickness = BorderThickness or 2
  Radius = Radius or 8

  local w = tonumber(Width) or 0
  local h = tonumber(Height) or 0
  local t = tonumber(BorderThickness) or 2
  local r = tonumber(R) or 255
  local g = tonumber(G) or 255
  local b = tonumber(B) or 255
  local a = tonumber(A) or 255

  if w <= 0 or h <= 0 or t <= 0 then
    return
  end

  local rad = math.max(0, tonumber(Radius) or 0)
  rad = math.min(rad, math.floor(math.min(w, h) / 2))

  -- Sides
  RenderRectangle(X + rad, Y, w - (rad * 2), t, r, g, b, a) -- top
  RenderRectangle(X + rad, Y + h - t, w - (rad * 2), t, r, g, b, a) -- bottom
  RenderRectangle(X, Y + rad, t, h - (rad * 2), r, g, b, a) -- left
  RenderRectangle(X + w - t, Y + rad, t, h - (rad * 2), r, g, b, a) -- right

  -- Rounded corners (approximate with small squares along the arc)
  local radInt = math.floor(rad + 0.5)
  local segments = math.max(18, math.min(48, math.floor(radInt * 1.6)))
  local size = math.max(1.0, math.floor(t + 0.5))
  for i = 0, segments do
    local angle = (i / segments) * (math.pi / 2)
    local xOffset = math.cos(angle) * rad
    local yOffset = math.sin(angle) * rad

    -- top-left
    RenderRectangle(X + rad - xOffset, Y + rad - yOffset, size, size, r, g, b, a)
    -- top-right
    RenderRectangle(X + w - rad + xOffset - size, Y + rad - yOffset, size, size, r, g, b, a)
    -- bottom-left
    RenderRectangle(X + rad - xOffset, Y + h - rad + yOffset - size, size, size, r, g, b, a)
    -- bottom-right
    RenderRectangle(X + w - rad + xOffset - size, Y + h - rad + yOffset - size, size, size, r, g, b, a)
  end
end
