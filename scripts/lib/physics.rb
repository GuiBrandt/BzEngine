=begin
	
	physics.rb
	
	Arquivo com as defini��es usadas para manipula��o de f�sica no jogo

=end

#==============================================================================
# Space
#------------------------------------------------------------------------------
# Classe usada para representar o espa�o onde os objetos do jogo est�o
#==============================================================================
class Space
	attr_reader :cptr
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize
		@cptr = cpSpaceNew()
	end
	#--------------------------------------------------------------------------
	# Cria um espa�o a partir de um ponteiro
	#--------------------------------------------------------------------------
	def self.from_cptr cptr
		s = Space.allocate
		s.instance_variable_set :@cptr, cptr
		return s
	end
	#--------------------------------------------------------------------------
	# Obt�m o n�mero de itera��es por passo do espa�o
	#--------------------------------------------------------------------------
	def iterations
		return cpSpaceGetIterations self.cptr
	end
	#--------------------------------------------------------------------------
	# Define o n�mero de itera��es por passo do espa�o
	#--------------------------------------------------------------------------
	def iterations=(n)
		cpSpaceSetIterations self.cptr, n
	end
	#--------------------------------------------------------------------------
	# Obt�m a gravidade do espa�o
	#--------------------------------------------------------------------------
	def gravity
		return Vec2.from_struct cpSpaceGetGravity(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define a gravidade do espa�o
	#--------------------------------------------------------------------------
	def gravity=(g)
		cpSpaceSetGravity(self.cptr, g.struct.cptr)
	end
	#--------------------------------------------------------------------------
	# Libera o objeto da mem�ria
	#--------------------------------------------------------------------------
	def dispose
		cpSpaceFree(self.cptr)
	end
end
#==============================================================================
# Vec2
#------------------------------------------------------------------------------
# Classe usada para representar um vetor bidimensional
#==============================================================================
class Vec2
	attr_reader :struct
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize x, y
		@struct = CPVect.new
		@struct[:x]	= x.to_f
		@struct[:y] = y.to_f
	end
	#--------------------------------------------------------------------------
	# Cria um vetor a partir de uma struct CPVect
	#--------------------------------------------------------------------------
	def self.from_struct struct
		msgbox DL::CPtr.new(struct)
		struct = CPVect.new DL::CPtr.new(struct).to_s(CPVect.size)		
		v = Vec2.allocate
		v.instance_variable_set :@struct, struct.dup
		return v
	end
	#--------------------------------------------------------------------------
	# Getters
	#--------------------------------------------------------------------------
	def x; @struct[:x]; end
	def y; @struct[:y]; end
	#--------------------------------------------------------------------------
	# Verifica igualdade entre vetores
	#--------------------------------------------------------------------------
	def ==(other)
		return false unless other.is_a? Vec2
		return self.x == other.x && self.y == other.y
	end
	#--------------------------------------------------------------------------
	# Soma dois vetores
	#--------------------------------------------------------------------------
	def +(other)
		return Vec2.new(self.x + other.x, self.y + other.y)
	end
	#--------------------------------------------------------------------------
	# Subtrai dois vetores
	#--------------------------------------------------------------------------
	def -(other)
		return Vec2.new(self.x - other.x, self.y - other.y)
	end
	#--------------------------------------------------------------------------
	# Negativa o vetor
	#--------------------------------------------------------------------------
	def -@
		return Vec2.new(-self.x, -self.y)
	end
	#--------------------------------------------------------------------------
	# Multiplica o vetor por um n�mero
	#--------------------------------------------------------------------------
	def *(scale)
		return Vec2.new(self.x * scale, self.y * scale)
	end
	#--------------------------------------------------------------------------
	# Divide o vetor por um n�mero
	#--------------------------------------------------------------------------
	def /(scale)
		return Vec2.new(self.x / scale, self.y / scale)
	end
	#--------------------------------------------------------------------------
	# Produto ponto do vetor
	#--------------------------------------------------------------------------
	def dot(other)
		return self.x * other.x + self.y * other.y
	end
	#--------------------------------------------------------------------------
	# Produto cruz do vetor
	#--------------------------------------------------------------------------
	def cross(other)
		return self.x * other.y - self.y * other.x
	end
	#--------------------------------------------------------------------------
	# Obt�m um vetor perpendicular a este
	#--------------------------------------------------------------------------
	def perp
		return Vec2.new(-self.y, self.x)
	end
	#--------------------------------------------------------------------------
	# Obt�m um vetor perpendicular a este (na outra dire��o)
	#--------------------------------------------------------------------------
	def rperp
		return Vec2.new(self.y, -self.x)
	end
	#--------------------------------------------------------------------------
	# Obt�m a proje��o deste vetor em outro vetor
	#--------------------------------------------------------------------------
	def project(other)
		return other * self.dot(other) / other.dot(other)
	end
	#--------------------------------------------------------------------------
	# Obt�m o �ngulo do vetor
	#--------------------------------------------------------------------------
	def to_angle
		return Math.atan2(self.y, self.x)
	end
	#--------------------------------------------------------------------------
	# Rotaciona o vetor pelo �ngulo especificado
	#--------------------------------------------------------------------------
	def rotate a
		other = Vec2.for_angle a
		
		return Vec2.new(
			self.x * other.x - self.y * other.y,
			self.x * other.y + self.y * other.x
		)
	end
	#--------------------------------------------------------------------------
	# Obt�m a largura do vetor ao quadrado (mais r�pido que s� obter a largura)
	#--------------------------------------------------------------------------
	def lengthsq
		return self.dot(self)
	end
	#--------------------------------------------------------------------------
	# Obt�m a largura do vetor
	#--------------------------------------------------------------------------
	def length
		return Math.sqrt(self.lengthsq)
	end
	#--------------------------------------------------------------------------
	# Normaliza o vetor
	#--------------------------------------------------------------------------
	def normalize
		len = self.length
		return Vec2::ZERO if len == 0
		return self / len
	end
	#--------------------------------------------------------------------------
	# Limita o vetor em tamanho
	#--------------------------------------------------------------------------
	def clamp len
		if len.is_a? Numeric
			return self.lengthsq > len*len ? self.normalize * len : self
		else
			return Vec2.new(
				self.x.clamp(len.l, len.r), 
				self.y.clamp(len.b, len.t)
			)
		end
	end
	#--------------------------------------------------------------------------
	# Obt�m a dist�ncia entre este vetor e outro
	#--------------------------------------------------------------------------
	def distance other
		return (self - other).length
	end
	#--------------------------------------------------------------------------
	# Obt�m a dist�ncia entre este vetor e outro ao quadrado (mais r�pido)
	#--------------------------------------------------------------------------
	def distancesq other
		return (self - other).lengthsq
	end
	#--------------------------------------------------------------------------
	# Verifica se este vetor est� pr�ximo de outro
	#--------------------------------------------------------------------------
	def near other, dist
		return self.distance(other) < dist*dist
	end
	#--------------------------------------------------------------------------
	# Interpola linearmente entre dois vetores
	#--------------------------------------------------------------------------
	def self.lerp v1, v2, t
		return Float.lerp(v1, v2, t)
	end
	#--------------------------------------------------------------------------
	# Interpola linearmente entre dois vetores
	#--------------------------------------------------------------------------
	def self.lerpconst v1, v2, d
		return v1 + (v2 - v1).clamp(d)
	end
	#--------------------------------------------------------------------------
	# Interpola linearmente em esfera entre dois vetores
	#--------------------------------------------------------------------------
	def self.slerp v1, v2, t
		dot = v1.normalize.dot(v2.normalize)
		omega = Math.acos dot.clamp(-1.0, 1.0)
		
		if omega < 1e-3
			return Vec2.lerp(v1, v2, t)
		else
			denom = 1.0 / Math.sin(omega)
			return v1 * Math.sin((1.0 - t)* omega) * denom + 
					v2 * Math.sin(t * omega) * denom
		end
	end
	#--------------------------------------------------------------------------
	# Interpola linearmente em esfera entre dois vetores
	#--------------------------------------------------------------------------
	def self.slerpconst v1, v2, a
		dot = v1.normalize.dot(v2.normalize)
		omega = Math.acos dot.clamp(-1.0, 1.0)
		
		return Vec2.slerp(v1, v2, [a, omega].min / omega)
	end
	#--------------------------------------------------------------------------
	# Obt�m um vetor para um �ngulo
	#--------------------------------------------------------------------------
	def self.for_angle a
		return Vec2.new(Math.cos(a), Math.sin(a))
	end
	#--------------------------------------------------------------------------
	# Constante para o vetor zero
	#--------------------------------------------------------------------------
	ZERO = Vec2.new(0, 0)
end
s = Space.new
s.gravity = Vec2.new(0, 0)
msgbox s.gravity.struct
s.gravity = Vec2.new(97, 0)
msgbox s.gravity.struct
#==============================================================================
# Matrix2x2
#------------------------------------------------------------------------------
# Classe usada para representar uma matriz 2x2 no formato
#	a b
#	c d
#==============================================================================
class Matrix2x2
	attr_reader :struct
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize a, b, c, d
		@struct = CPMat2x2.new
		@struct[:a] = a
		@struct[:b] = b
		@struct[:c] = c
		@struct[:d] = d
	end
	#--------------------------------------------------------------------------
	# Cria uma matrix a partir de uma struct CPMat2x2
	#--------------------------------------------------------------------------
	def self.from_struct struct
		m = Matrix2x2.allocate
		m.instance_variable_set :@struct, struct.dup
		
		return m
	end
	#--------------------------------------------------------------------------
	# Getters
	#--------------------------------------------------------------------------
	def a; @struct[:a]; end
	def b; @struct[:b]; end
	def c; @struct[:c]; end
	def d; @struct[:d]; end
	#--------------------------------------------------------------------------
	# Multiplica��o
	#--------------------------------------------------------------------------
	def *(other)
		if other.is_a? Matrix2x2
			return Matrix2x2.new(
				a * other.a + b * other.c, a * other.b + b * other.d,
				c * other.a + d * other.c, c * other.b + d * other.d
			)
		elsif other.is_a? Vec2
			return Vec2.new(
				a * other.x + b * other.y, 
				c * other.x + d * other.y
			)
		elsif other.is_a? Numeric
			return Matrix2x2.new(
				a * other, b * other,
				c * other, d * other
			)
		end
		
		return nil
	end
end
#==============================================================================
# BoundingBox
#------------------------------------------------------------------------------
# Classe usada para representar uma AABB (Axis Aligned Bounding Box)
#==============================================================================
class BoundingBox
	attr_reader :struct
	#--------------------------------------------------------------------------
	# Construtor
	# => 	l: Posi��o do lado esquerdo da caixa
	# =>	b: Posi��o do fundo da caixa
	# =>	r: Posi��o do lado direito da caixa
	# => 	t: Posi��o do topo da caixa
	#--------------------------------------------------------------------------
	def initialize l, b, r, t
		@struct = CPBB.new
		@struct[:l] = l
		@struct[:b] = b
		@struct[:r] = r
		@struct[:t] = t
	end
	#--------------------------------------------------------------------------
	# Cria uma caixa a partir de uma struct CPBB
	#--------------------------------------------------------------------------
	def self.from_struct struct
		bb = BoundingBox.allocate
		bb.instance_variable_set :@struct, struct.dup
		
		return bb
	end
	#--------------------------------------------------------------------------
	# Getters
	#--------------------------------------------------------------------------
	def l; @struct[:l]; end
	def b; @struct[:b]; end
	def r; @struct[:r]; end
	def t; @struct[:t]; end
	#--------------------------------------------------------------------------
	# Construtor
	# =>	c: 	Vec2 para o centro da caixa
	# =>	hw: Metade da largura da caixa
	# =>	hh: Metade da altura da caixa
	#--------------------------------------------------------------------------
	def self.new_for_extents c, hw, hh
		return BoundingBox.new c.x - hw, c.y - hh, c.x + hw, c.y + hh
	end
	#--------------------------------------------------------------------------
	# Construtor
	# =>	c: Vec2 para o centro da caixa
	# =>	r: Raio
	#--------------------------------------------------------------------------
	def self.new_for_circle c, r
		return BoundingBox.new_for_extents c, r, r
	end
	#--------------------------------------------------------------------------
	# Verifica se a caixa intersecta com outra 
	#--------------------------------------------------------------------------
	def intersects? other
		return self.l <= other.r &&
			   other.l <= self.r &&
			   self.b <= other.t &&
			   other.b <= self.t
	end
	#--------------------------------------------------------------------------
	# Verifica se a caixa cont�m outra ou um vetor
	#--------------------------------------------------------------------------
	def contains? other
		if other.is_a? BoundingBox
			return self.l <= other.l &&
				   self.r >= other.r &&
				   self.b <= other.b &&
				   self.t >= other.t
		else
			return self.l <= other.x &&
				   self.r >= other.x &&
				   self.b <= other.y &&
				   self.t >= other.y
		end
	end
	#--------------------------------------------------------------------------
	# Combina duas caixas
	#--------------------------------------------------------------------------
	def merge other
		return BoundingBox.new(
			[self.l, other.l].min,
			[self.b, other.b].min,
			[self.r, other.r].max,
			[self.t, other.t].max,
		)
	end
	#--------------------------------------------------------------------------
	# Expande uma caixa at� que ela contenha um vetor
	#--------------------------------------------------------------------------
	def expand v
		return BoundingBox.new(
			[self.l, v.x].min,
			[self.b, v.y].min,
			[self.r, v.x].max,
			[self.t, v.y].max
		)
	end
	#--------------------------------------------------------------------------
	# Retorna o vetor para o centro da caixa
	#--------------------------------------------------------------------------
	def center
		return Vec2.lerp(Vec2.new(l, b), Vec2.new(r, t), 0.5)
	end
	#--------------------------------------------------------------------------
	# Retorna a �rea da caixa
	#--------------------------------------------------------------------------
	def area
		return (self.r - self.l) * (self.t - self.b)
	end
	#--------------------------------------------------------------------------
	# Retorna a �rea de uma combina��o com outra caixa
	#--------------------------------------------------------------------------
	def merged_area other
		([self.r, other.r].max - [self.l, other.l].min) * 
		([self.t, other.t].max - [self.b, other.b].min)
	end
	#--------------------------------------------------------------------------
	# Obt�m a fra��o do segmento de A a B que a caixa intersecta, se n�o 
	# intersectar, retorna Float::INFINITY (1.0/0.0)
	#--------------------------------------------------------------------------
	def segment_query a, b
		idx = 1.0 / (b.x - a.x)
		tx1 = (self.l == a.x ? -Float::INFINITY : (self.l - a.x) * idx)
		tx2 = (self.r == a.x ? Float::INFINITY : (self.r - a.x) * idx)
		txmin = [tx1, tx2].min
		txmax = [tx1, tx2].max
		
		idy = 1.0 / (b.y - a.y)
		ty1 = (self.l == a.y ? -Float::INFINITY : (self.l - a.y) * idy)
		ty2 = (self.r == a.y ? Float::INFINITY : (self.r - a.y) * idy)
		tymin = [ty1, ty2].min
		tymax = [ty1, ty2].max
		
		if tymin <= txmax && txmin <= tymax
			min = [txmin, tymin].max
			max = [txmax, tymax].min
			
			[min, 0.0].max if 0 <= max && min <= 1
		end
		
		return Float::INFINITY
	end
	#--------------------------------------------------------------------------
	# Verifica se a caixa intersecta um segmento de reta de A a B
	#--------------------------------------------------------------------------
	def intersects_segment? a, b
		return self.segment_query(a, b) != Float::INFINITY
	end
	#--------------------------------------------------------------------------
	# Prende um vetor � caixa
	#--------------------------------------------------------------------------
	def wrap v
		dx = (self.r - self.l).abs
		modx = (v.x - self.l) % dx
		x = modx > 0 ? modx : modx + dx
		
		dy = (self.t - self.b).abs
		mody = (v.y - self.b) % dy
		
		return Vec2.new(x + self.l, y + self.b)
	end
	#--------------------------------------------------------------------------
	# Move a caixa
	#--------------------------------------------------------------------------
	def offset v
		return BoundingBox.new(
			self.l + v.x,
			self.b + v.y,
			self.r + v.x,
			self.t + v.y
		)
	end
end
#==============================================================================
# Body
#------------------------------------------------------------------------------
# Classe usada para representar um corpo
#==============================================================================
class Body
	attr_reader :cptr
	#--------------------------------------------------------------------------
	# Cria um corpo a partir de um ponteiro
	#--------------------------------------------------------------------------
	def self.from_cptr cptr		
		type = cpBodyGetType(cptr)
		
		case type
		when 0
			body = DynamicBody.allocate
		when 1
			body = KinematicBody.allocate
		when 2
			body = StaticBody.allocate
		end
		
		body.instance_variable_set :@cptr, cptr
		
		return body
	end
	#--------------------------------------------------------------------------
	# Obt�m o tipo do corpo
	#--------------------------------------------------------------------------
	def type
		return :abstract
	end
	#--------------------------------------------------------------------------
	# Altera o tipo do objeto
	#--------------------------------------------------------------------------
	def type=(t)
		cpBodySetType(self.cptr, Body::TYPES.index(t))
	end
	#--------------------------------------------------------------------------
	# Obt�m o espa�o onde o corpo est�
	#--------------------------------------------------------------------------
	def space
		return Space.from_cptr(cpBodyGetSpace(self.cptr))
	end
	#--------------------------------------------------------------------------
	# Obt�m a massa do corpo
	#--------------------------------------------------------------------------
	def mass
		return cpBodyGetMass(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define a massa do corpo
	#--------------------------------------------------------------------------
	def mass=(m)
		cpBodySetMass(self.cptr, m.to_f)
	end
	#--------------------------------------------------------------------------
	# Obt�m o momento inercial do objeto
	#--------------------------------------------------------------------------
	def moment
		return cpBodyGetMoment(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define o momento inercial do objeto
	#--------------------------------------------------------------------------
	def moment=(i)
		cpBodySetMoment(self.cptr, i.to_f)
	end
	#--------------------------------------------------------------------------
	# Obt�m a posi��o do corpo como um Vec2
	#--------------------------------------------------------------------------
	def position
		vec = CPVect.new(cpBodyGetPosition(self.cptr))
		return Vec2.from_struct vec
	end
	#--------------------------------------------------------------------------
	# Define a posi��o do corpo
	#--------------------------------------------------------------------------
	def position=(vec)
		cpBodySetPosition(self.cptr, vec.struct)
	end
	#--------------------------------------------------------------------------
	# Obt�m o centro de gravidade do corpo
	#--------------------------------------------------------------------------
	def center_of_gravity
		vec = CPVect.new(cpBodyGetCenterOfGravity(self.cptr))
		return Vec2.from_struct vec
	end
	#--------------------------------------------------------------------------
	# Define o centro de gravidade do corpo
	#--------------------------------------------------------------------------
	def center_of_gravity=(vec)
		cpBodySetCenterOfGravity(self.cptr, vec.struct)
	end
	#--------------------------------------------------------------------------
	# Obt�m a velocidade do corpo
	#--------------------------------------------------------------------------
	def velocity
		vec = CPVect.new(cpBodyGetVelocity(self.cptr))
		return Vec2.from_struct vec
	end
	#--------------------------------------------------------------------------
	# Define a velocidade do corpo
	#--------------------------------------------------------------------------
	def velocity=(vec)
		cpBodySetVelocity(self.cptr, vec.struct)
	end
	#--------------------------------------------------------------------------
	# Obt�m a for�a do corpo
	#--------------------------------------------------------------------------
	def force
		vec = CPVect.new(cpBodyGetForce(self.cptr))
		return Vec2.from_struct vec
	end
	#--------------------------------------------------------------------------
	# Define a for�a do corpo
	#--------------------------------------------------------------------------
	def force=(vec)
		cpBodySetForce(self.cptr, vec.struct)
	end
	#--------------------------------------------------------------------------
	# Obt�m o �ngulo do objeto
	#--------------------------------------------------------------------------
	def angle
		return cpBodyGetAngle(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define o �ngulo do objeto
	#--------------------------------------------------------------------------
	def angle=(a)
		cpBodySetAngle(self.cptr, a.to_f)
	end
	#--------------------------------------------------------------------------
	# Obt�m a velocidade angular do objeto
	#--------------------------------------------------------------------------
	def angular_velocity
		return cpBodyGetAngularVelocity(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define a velocidade angular do objeto
	#--------------------------------------------------------------------------
	def angular_velocity=(v)
		cpBodySetAngularVelocity(self.cptr, v.to_f)
	end
	#--------------------------------------------------------------------------
	# Obt�m o torque do objeto
	#--------------------------------------------------------------------------
	def torque
		return cpBodyGetTorque(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define o torque do objeto
	#--------------------------------------------------------------------------
	def torque=(t)
		cpBodySetTorque(self.cptr, t.to_f)
	end
	#--------------------------------------------------------------------------
	# Obt�m o vetor de rota��o do objeto
	#--------------------------------------------------------------------------
	def rotation
		vec = CPVect.new(cpBodyGetRotation(self.cptr))
		return Vec2.from_struct vec
	end
	#--------------------------------------------------------------------------
	# Obt�m os dados do usu�rio
	#--------------------------------------------------------------------------
	def user_data
		return DL::Cptr.new(cpBodyGetUserData(self.cptr)).to_value
	end
	#--------------------------------------------------------------------------
	# Define os dados do usu�rio
	#--------------------------------------------------------------------------
	def user_data=(val)
		cpBodySetUserData(self.cptr, val.cptr)
	end
	#--------------------------------------------------------------------------
	# Converte coordenadas locais em globais
	#--------------------------------------------------------------------------
	def local_to_world vec
		res = cpBodyLocalToWorld(self.cptr, vec.struct)
		return Vec2.from_struct res
	end
	#--------------------------------------------------------------------------
	# Converte coordenadas globais em locais
	#--------------------------------------------------------------------------
	def world_to_local vec
		res = cpBodyWorldToLocal(self.cptr, vec.struct)
		return Vec2.from_struct res
	end
	#--------------------------------------------------------------------------
	# Obt�m a velocidade absoluta do corpo no ponto global dado
	#--------------------------------------------------------------------------
	def velocity_at_world_point vec
		res = cpBodyVelocityAtWorldPoint(self.cptr, vec.struct)
		return Vec2.from_struct res
	end
	#--------------------------------------------------------------------------
	# Obt�m a velocidade absoluta do cropo no ponto local dado
	#--------------------------------------------------------------------------
	def velocity_at_point vec
		res = cpBodyVelocityAtLocalPoint(self.cptr, vec.struct)
		return Vec2.from_struct res
	end
	#--------------------------------------------------------------------------
	# Aplica uma for�a ao corpo em um ponto global
	#--------------------------------------------------------------------------
	def apply_force_at_world_point force, point
		cpApplyForceAtWorldPoint(self.cptr, force.struct, point.struct)
	end
	#--------------------------------------------------------------------------
	# Aplica uma for�a ao corpo em um ponto local
	#--------------------------------------------------------------------------
	def apply_force_at_point force, point
		cpApplyForceAtLocalPoint(self.cptr, force.struct, point.struct)
	end
	#--------------------------------------------------------------------------
	# Aplica um impulso ao corpo em um ponto global
	#--------------------------------------------------------------------------
	def apply_impulse_at_world_point impulse, point
		cpApplyImpulseAtWorldPoint(self.cptr, impulse.struct, point.struct)
	end
	#--------------------------------------------------------------------------
	# Aplica um impulso ao corpo em um ponto local
	#--------------------------------------------------------------------------
	def apply_impulse_at_point impulse, point
		cpApplyImpulseAtLocalPoint(self.cptr, impulse.struct, point.struct)
	end
	#--------------------------------------------------------------------------
	# Verifica se o corpo est� dormindo
	#--------------------------------------------------------------------------
	def sleeping?
		return !cpBodyIsSleeping(self.cptr).zero?
	end
	#--------------------------------------------------------------------------
	# Ativa o corpo
	#--------------------------------------------------------------------------
	def activate
		cpBodyActivate(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Desativa o corpo
	#--------------------------------------------------------------------------
	def sleep
		cpBodySleep(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Ativa corpos inativos tocando o corpo est�tico
	#--------------------------------------------------------------------------
	def activate_static filter = null
		cpBodyActivateStatic(self.cptr, filter.cptr || 0)
	end
	#--------------------------------------------------------------------------
	# Desativa o corpo em grupo com outro
	#--------------------------------------------------------------------------
	def sleep_with_group group = nil		
		cpBodySleepWithGroup(self.cptr, group.cptr || 0)
	end
	#--------------------------------------------------------------------------
	# Libera o corpo da mem�ria
	#--------------------------------------------------------------------------
	def dispose
		cpBodyFree(cptr)
	end
	#--------------------------------------------------------------------------
	# Calcula o momento de in�rcia para um c�rculo
	#--------------------------------------------------------------------------
	def self.moment_for_circle m, r1, r2, offset
		return cpMomentForCircle m.to_f, r1.to_f, r2.to_f, offset.struct
	end
	#--------------------------------------------------------------------------
	# Calcula o momento de in�rcia para um segmento de reta
	#--------------------------------------------------------------------------
	def self.moment_for_segment m, a, b, radius
		return cpMomentForSegment m.to_f, a.struct, b.struct, radius.to_f
	end
	#--------------------------------------------------------------------------
	# Calcula o momento de in�rcia para um pol�gono
	#--------------------------------------------------------------------------
	def self.moment_for_poly m, verts, offset, radius
		n = verts.size
		verts = verts.map{|vec| vec.struct}.join
		return cpMomentForSegment m.to_f, n, verts.cptr, offset.struct, radius.to_f
	end
	#--------------------------------------------------------------------------
	# Calcula a �rea de um c�rculo
	#--------------------------------------------------------------------------
	def self.area_for_circle r1, r2
		return cpAreaForCircle r1.to_f, r2.to_f
	end
	#--------------------------------------------------------------------------
	# Calcula a �rea de um segmento de reta (wtf?)
	#--------------------------------------------------------------------------
	def self.area_for_segment a, b, r
		return cpAreaForSegment a.struct, b.struct, r.to_f
	end
	#--------------------------------------------------------------------------
	# Calcula a �rea de um pol�gono
	#--------------------------------------------------------------------------
	def self.area_for_poly verts, r
		n = verts.size
		verts = verts.map{|vec| vec.struct}.join
		return cpAreaForPoly(n, verts.cptr, r.to_f).abs
	end
end
#==============================================================================
# DynamicBody
#------------------------------------------------------------------------------
# Classe usada para representar corpos din�micos
#==============================================================================
class DynamicBody < Body
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize m, i
		@cptr = cpBodyNew m.to_f, i.to_f
	end
	#--------------------------------------------------------------------------
	# Obt�m o tipo do corpo
	#--------------------------------------------------------------------------
	def type
		return :dynamic
	end
end
#==============================================================================
# KinematicBody
#------------------------------------------------------------------------------
# Classe usada para representar corpos cinem�ticos
#==============================================================================
class KinematicBody < Body
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize
		@cptr = cpBodyNewKinematic
	end
	#--------------------------------------------------------------------------
	# Obt�m o tipo do corpo
	#--------------------------------------------------------------------------
	def type
		return :kinematic
	end
end
#==============================================================================
# StaticBody
#------------------------------------------------------------------------------
# Classe usada para representar corpos est�ticos
#==============================================================================
class StaticBody < Body
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize
		@cptr = cpBodyNewStatic
	end
	#--------------------------------------------------------------------------
	# Obt�m o tipo do corpo
	#--------------------------------------------------------------------------
	def type
		return :static
	end
end
#==============================================================================
# Shape
#------------------------------------------------------------------------------
# Classe usada para representar as formas dos corpos
#==============================================================================
class Shape
	#==========================================================================
	# Filter
	#--------------------------------------------------------------------------
	# Estrutura usada para filtro de colis�o
	#==========================================================================
	Filter = CStruct.create({
		group: 		DL::SIZEOF_INT,
		categories: DL::SIZEOF_INT,
		mask:		DL::SIZEOF_INT
	})

	attr_reader :cptr
	#--------------------------------------------------------------------------
	# Obt�m o corpo relacionado � forma
	#--------------------------------------------------------------------------
	def body
		return Body.from_cptr cpShapeGetBody(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define o corpo ao qual a forma est� relacionada
	#--------------------------------------------------------------------------
	def body=(body)
		cpShapeSetBody self.cptr, body.cptr
	end
	#--------------------------------------------------------------------------
	# A BoundingBox relacionada � forma
	#--------------------------------------------------------------------------
	def bounding_box
		return BoundingBox.from_struct cpShapeGetBB(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Verifica se a forma � um sensor
	#--------------------------------------------------------------------------
	def sensor?
		return !cpShapeGetSensor(self.cptr).zero?
	end
	#--------------------------------------------------------------------------
	# Define se a forma � um sensor
	#--------------------------------------------------------------------------
	def sensor=(b)
		cpShapeSetSensor self.cptr, b ? 1 : 0
	end
	#--------------------------------------------------------------------------
	# Obt�m a elasticidade da forma
	#--------------------------------------------------------------------------
	def elasticity
		return cpShapeGetElasticity(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define a elasticidade da forma
	#--------------------------------------------------------------------------
	def elasticity=(e)
		cpShapeSetElasticity self.cptr, e.to_f
	end
	#--------------------------------------------------------------------------
	# Obt�m o coeficiente de fric��o da forma
	#--------------------------------------------------------------------------
	def friction
		return cpShapeGetFriction(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define o coeficiente de fric��o da forma
	#--------------------------------------------------------------------------
	def elasticity=(e)
		cpShapeSetFriction self.cptr, e.to_f
	end
	#--------------------------------------------------------------------------
	# Obt�m a velocidade superficial da forma
	#--------------------------------------------------------------------------
	def surface_velocity
		return Vec2.from_struct cpShapeGetSurfaceVelocity(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define a velocidade superficial da forma
	#--------------------------------------------------------------------------
	def surface_velocity=(v)
		cpShapeSetSurfaceVelocity(self.cptr, v.struct)
	end
	#--------------------------------------------------------------------------
	# Obt�m o tipo de colis�o da forma
	#--------------------------------------------------------------------------
	def collision_type
		return cpShapeGetCollisionType(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define o tipo de colis�o da forma
	#--------------------------------------------------------------------------
	def collision_type=(t)
		cpShapeSetCollisionType(self.cptr, t)
	end
	#--------------------------------------------------------------------------
	# Obt�m o filtro da forma
	#--------------------------------------------------------------------------
	def filter
		return cpShapeGetFilter(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define o tipo da forma
	#--------------------------------------------------------------------------
	def filter=(filter)
		return cpShapeSetFilter(self.cptr, filter.struct)
	end
	#--------------------------------------------------------------------------
	# Obt�m o Space associado � forma
	#--------------------------------------------------------------------------
	def space
		return Space.from_cptr cpShapeGetSpace(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Obt�m os dados do usu�rio
	#--------------------------------------------------------------------------
	def user_data
		return DL::Cptr.new(cpShapeGetUserData(self.cptr)).to_value
	end
	#--------------------------------------------------------------------------
	# Define os dados do usu�rio
	#--------------------------------------------------------------------------
	def user_data=(val)
		cpShapeSetUserData(self.cptr, val.cptr)
	end
	#--------------------------------------------------------------------------
	# Libera a forma da mem�ria
	#--------------------------------------------------------------------------
	def dispose
		cpShapeFree(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Sincroniza a forma com o corpo associado
	#--------------------------------------------------------------------------
	def cache_bounding_box
		return BoundingBox.from_struct cpShapeCacheBB(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Atualiza a forma
	#--------------------------------------------------------------------------
	def update pos, rot
		return BoundingBox.from_struct cpShapeUpdate(self.cptr, pos.struct, rot.struct)
	end
end
#==============================================================================
# CircleShape
#------------------------------------------------------------------------------
# Classe usada para representar formas circulares
#==============================================================================
class CircleShape < Shape
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize body, radius, offset
		@cptr = cpCircleShapeNew body.cptr, radius.to_f, offset.struct
	end
	#--------------------------------------------------------------------------
	# Obt�m o raio da forma
	#--------------------------------------------------------------------------
	def radius
		return cpCircleShapeGetRadius(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Obt�m o offset da forma
	#--------------------------------------------------------------------------
	def offset
		return Vec2.from_struct cpCircleShapeGetOffset(self.cptr)
	end
end
#==============================================================================
# SegmentShape
#------------------------------------------------------------------------------
# Classe usada para representar formas de um segmento de A a B
#==============================================================================
class SegmentShape < Shape
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize body, a, b, radius
		@cptr = cpCircleShapeNew body.cptr, a.struct, b.struct, radius.to_f
	end
	#--------------------------------------------------------------------------
	# Obt�m o ponto A da forma
	#--------------------------------------------------------------------------
	def a
		return Vec2.from_struct cpSegmentShapeGetA(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Obt�m o ponto B da forma
	#--------------------------------------------------------------------------
	def b
		return Vec2.from_struct cpSegmentShapeGetB(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Obt�m o normal da forma
	#--------------------------------------------------------------------------
	def normal
		return Vec2.from_struct cpSegmentShapeGetNormal(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Obt�m o raio da forma
	#--------------------------------------------------------------------------
	def radius
		return cpSegmentShapeGetRadius(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Define os vizinhos da forma, isso liga uma forma �s pontas de outras
	#--------------------------------------------------------------------------
	def set_neighbors prev, nxt
		cpSegmentShapeSetNeighbors(self.cptr, prev.struct, nxt.struct)
	end
end
#==============================================================================
# PolyShape
#------------------------------------------------------------------------------
# Classe usada para representar formas de pol�gonos
#==============================================================================
class PolyShape < Shape
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize body, verts, transform, radius
		n = verts.size
		verts = verts.map{|vec| vec.struct}.join
		
		@cptr = cpPolyShapeNew body.cptr, n, verts.cptr, transform, radius.to_f
	end
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def self.new_raw body, verts, radius
		n = verts.size
		verts = verts.map{|vec| vec.struct}.join
		
		shape = PolyShape.allocate
		shape.instance_variable_set(
			:@cptr, 
			cpPolyShapeNewRaw(body.cptr, n, verts.cptr, transform, radius.to_f)
		)
		
		return shape
	end
	#--------------------------------------------------------------------------
	# Obt�m o n�mero de v�rtices do pol�gono
	#--------------------------------------------------------------------------
	def num_verts
		return cpPolyShapeGetNumVerts(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Obt�m um v�rtice do pol�gono como um Vec2
	#--------------------------------------------------------------------------
	def vert(index)
		return Vec2.from_struct cpPolyShapeGetVert(self.cptr, index)
	end
	#--------------------------------------------------------------------------
	# Obt�m o raio do pol�gono
	#--------------------------------------------------------------------------
	def radius
		return cpPolyShapeGetRadius(self.cptr)
	end
	#--------------------------------------------------------------------------
	# Obt�m o centr�ide para uma lista de v�rtices
	#--------------------------------------------------------------------------
	def self.centroid(verts)
		n = verts.size
		verts = verts.map{|vec| vec.struct}.join
	
		return Vec2.from_struct cpCentroidForPoly(n, verts.cptr) 
	end
	#--------------------------------------------------------------------------
	# Calcula o convex hull (?) de uma lista de v�rtices
	#--------------------------------------------------------------------------
	def self.convex_hull(verts, tol = 0.0)
		result = "\0" * verts.size * CPVect.size
		first = "\0" * SIZEOF_INT
		
		n = verts.size
		verts = verts.map{|vec| vec.struct}.join
		
		cpConvexHull n, verts.cptr, result.cptr, first.cptr, tol.to_f
		
		result = result.scan(/.{#{CPVect.size}}/).map do |s| 
			Vec2.from_struct CPVect.new(s)
		end
		
		first = first.unpack("L").first
		
		yield first
		return result
	end
end
#==============================================================================
# BoxShape
#------------------------------------------------------------------------------
# Classe especial de PolyShape para caixas
#==============================================================================
class BoxShape < PolyShape
	#--------------------------------------------------------------------------
	# Construtor
	#--------------------------------------------------------------------------
	def initialize body, *args
		if args.size == 3
			args = args.map {|n| n.to_f}
			@cptr = cpBoxShapeNew(body.cptr, *args)
		elsif args.size == 2
			@cptr = cpBoxShapeNew(body.cptr, args[0].struct, args[1].to_f)
		else
			raise ArgumentError.new
		end
	end
end