local vector = {
  add = function( self, o )
    return vector.new(
      self.x + o.x,
      self.y + o.y,
      self.z + o.z
    )
  end,
  sub = function( self, o )
    return vector.new(
      self.x - o.x,
      self.y - o.y,
      self.z - o.z
    )
  end,
  mul = function( self, m )
    return vector.new(
      self.x * m,
      self.y * m,
      self.z * m
    )
  end,
  dot = function( self, o )
    return self.x*o.x + self.y*o.y + self.z*o.z
  end,
  cross = function( self, o )
    return vector.new(
      self.y*o.z - self.z*o.y,
      self.z*o.x - self.x*o.z,
      self.x*o.y - self.y*o.x
    )
  end,
  length = function( self )
    return math.sqrt( self.x*self.x + self.y*self.y + self.z*self.z )
  end,
  normalize = function( self )
    return self:mul( 1 / self:length() )
  end,
  cross = function( self, o)
    return new(
      self.y * o.z - self.z * o.y,
      self.z * o.x - self.x * o.z,
      self.x * o.y - self.y * o.x
    )
  end,
  rotateY = function( self, theta )
    local theta = theta/180 * math.pi
    local c, s = math.cos(theta), math.sin(theta)
    return new(
      math.floor( self.x * c + self.z * s + 0.5 ),
      math.floor( self.y + 0.5 ),
      math.floor( self.z * c - self.x * s + 0.5 )
    )
  end,
  theta = function( self, o )
    return math.acos( self:dot(o) / ( self:length() * o:length() ) )
  end,
  round = function( self )
    return vector.new(
      math.floor( self.x + 0.5 ),
      math.floor( self.y + 0.5 ),
      math.floor( self.z + 0.5 )
    )
  end,
  tostring = function( self )
    return self.x..","..self.y..","..self.z
  end,
}

local vmetatable = {
  __index = vector,
  __add = vector.add,
  __sub = vector.sub,
  __mul = vector.mul,
  __unm = function( v ) return v:mul(-1) end,
  __tostring = vector.tostring,
}

function new( x, y, z )
  local v = {
    x = x or 0,
    y = y or 0,
    z = z or 0
  }
  setmetatable( v, vmetatable )
  return v
end
