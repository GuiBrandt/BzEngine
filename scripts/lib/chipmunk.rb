=begin
	
	chipmunk.rb
	
	Arquivo com a importação do Chipmunk
	
=end
#==============================================================================
# Kernel
#------------------------------------------------------------------------------
# Módulo base, tudo que existe aqui existe no programa inteiro
#==============================================================================
module Kernel
	extend DLLImport
    include DL
	
	#--------------------------------------------------------------------------
	# Tipos e structs
	#--------------------------------------------------------------------------
	typedef :float, 	:cpFloat
	typedef :pointer, 	:cpDataPointer
	typedef :int, 		:cpHashValue
	typedef :int, 		:cpCollisionID
	typedef :char, 		:cpBool
	typedef :int, 		:cpCollisionType
	typedef :int,		:cpGroup
	typedef :int,		:cpBitmask
	typedef :int,		:cpTimestamp
	typedef :pointer, 	:cpVect
	typedef :pointer, 	:cpTransform
	typedef :pointer,	:cpMat2x2
	typedef :pointer,	:cpContactPointSet
	#==========================================================================
	# CPVect
	#--------------------------------------------------------------------------
	# Struct usada para vetores
	#==========================================================================
	CPVect = CStruct.create({
		x: SIZEOF_FLOAT,
		y: SIZEOF_FLOAT
	})
	#==========================================================================
	# CPTransform
	#--------------------------------------------------------------------------
	# Struct usada para transformações (q?)
	#==========================================================================
	CPTransform = CStruct.create({
		a: SIZEOF_FLOAT,
		b: SIZEOF_FLOAT,
		c: SIZEOF_FLOAT,
		d: SIZEOF_FLOAT,
		tx: SIZEOF_FLOAT,
		ty: SIZEOF_FLOAT
	})
	#==========================================================================
	# CPMat2x2
	#--------------------------------------------------------------------------
	# Struct usada para matrizes 2x2
	#==========================================================================
	CPMat2x2 = CStruct.create({
		a: SIZEOF_FLOAT,
		b: SIZEOF_FLOAT,
		c: SIZEOF_FLOAT,
		d: SIZEOF_FLOAT
	})
	#==========================================================================
	# CPContactPointSet_point
	#--------------------------------------------------------------------------
	# Struct usada para representar um ponto no CPContactPointSet
	#==========================================================================
	CPContactPointSet_point = CStruct.create({
		pointA: CPVect.size,
		pointB: CPVect.size,
		distance: SIZEOF_FLOAT
	})
	#==========================================================================
	# CPContactPointSet
	#--------------------------------------------------------------------------
	# Struct usada para uma lista de pontos de contato
	#==========================================================================
	CPContactPointSet = CStruct.create({
		count: SIZEOF_INT,
		normal: CPVect.size,
		point0: CPContactPointSet_point.size,
		point1: CPContactPointSet_point.size
	})
	#==========================================================================
	# CPBB
	#--------------------------------------------------------------------------
	# Struct usada para Axis Aligned Bounding Boxes
	#==========================================================================
	CPBB = CStruct.create({
		l: SIZEOF_FLOAT,
		b: SIZEOF_FLOAT,
		r: SIZEOF_FLOAT,
		t: SIZEOF_FLOAT
	})
	#==========================================================================
	# CPPointQueryInfo
	#--------------------------------------------------------------------------
	# Struct usada para informações de um ponto
	#==========================================================================
	CPPointQueryInfo = CStruct.create({
		shape: SIZEOF_VOIDP,
		point: CPVect.size,
		distance: SIZEOF_FLOAT,
		gradient: CPVect.size
	})
	#==========================================================================
	# CPSegmentQueryInfo
	#--------------------------------------------------------------------------
	# Struct para informações de segmentos
	#==========================================================================
	CPSegmentQueryInfo = CStruct.create({
		shape: SIZEOF_VOIDP,
		point: CPVect.size,
		normal: CPVect.size,
		alpha: SIZEOF_FLOAT
	})	
	#--------------------------------------------------------------------------
	# Funções
	#--------------------------------------------------------------------------
	with_dll('chipmunk-7.0.1.dll') do
		import :cpMessage, :void
		import :cpMomentForCircle, :cpFloat
		import :cpAreaForCircle, :cpFloat
		import :cpMomentForSegment, :cpFloat
		import :cpAreaForSegment, :cpFloat
		import :cpMomentForPoly, :cpFloat
		import :cpAreaForPoly, :cpFloat
		import :cpCentroidForPoly, :cpVect
		import :cpMomentForBox, :cpFloat
		import :cpMomentForBox2, :cpFloat
		import :cpConvexHull, :int
		import :cpCircleShapeSetRadius, :void
		import :cpCircleShapeSetOffset, :void
		import :cpSegmentShapeSetEndpoints, :void
		import :cpSegmentShapeSetRadius, :void
		import :cpPolyShapeSetVerts, :void
		import :cpPolyShapeSetVertsRaw, :void
		import :cpPolyShapeSetRadius, :void
		import :cpArbiterGetRestitution, :cpFloat
		import :cpArbiterSetRestitution, :void
		import :cpArbiterGetFriction, :cpFloat
		import :cpArbiterSetFriction, :void
		import :cpArbiterGetSurfaceVelocity, :cpVect
		import :cpArbiterSetSurfaceVelocity, :void
		import :cpArbiterGetUserData, :cpDataPointer
		import :cpArbiterSetUserData, :void
		import :cpArbiterTotalImpulse, :cpVect
		import :cpArbiterTotalKE, :cpFloat
		import :cpArbiterIgnore, :cpBool
		import :cpArbiterGetShapes, :void
		import :cpArbiterGetBodies, :void
		import :cpArbiterGetContactPointSet, :cpContactPointSet
		import :cpArbiterSetContactPointSet, :void
		import :cpArbiterIsFirstContact, :cpBool
		import :cpArbiterIsRemoval, :cpBool
		import :cpArbiterGetCount, :int
		import :cpArbiterGetNormal, :cpVect
		import :cpArbiterGetPointA, :cpVect
		import :cpArbiterGetPointB, :cpVect
		import :cpArbiterGetDepth, :cpFloat
		import :cpArbiterCallWildcardBeginA, :cpBool
		import :cpArbiterCallWildcardBeginB, :cpBool
		import :cpArbiterCallWildcardPreSolveA, :cpBool
		import :cpArbiterCallWildcardPreSolveB, :cpBool
		import :cpArbiterCallWildcardPostSolveA, :void
		import :cpArbiterCallWildcardPostSolveB, :void
		import :cpArbiterCallWildcardSeparateA, :void
		import :cpArbiterCallWildcardSeparateB, :void
		import :cpBodyAlloc, :pointer
		import :cpBodyInit, :pointer
		import :cpBodyNew, :pointer
		import :cpBodyNewKinematic, :pointer
		import :cpBodyNewStatic, :pointer
		import :cpBodyDestroy, :void
		import :cpBodyFree, :void
		import :cpBodyActivate, :void
		import :cpBodyActivateStatic, :void
		import :cpBodySleep, :void
		import :cpBodySleepWithGroup, :void
		import :cpBodyIsSleeping, :cpBool
		import :cpBodyGetType, :cpBodyType
		import :cpBodySetType, :void
		import :cpBodyGetSpace, :pointer
		import :cpBodyGetMass, :cpFloat
		import :cpBodySetMass, :void
		import :cpBodyGetMoment, :cpFloat
		import :cpBodySetMoment, :void
		import :cpBodyGetPosition, :cpVect
		import :cpBodySetPosition, :void
		import :cpBodyGetCenterOfGravity, :cpVect
		import :cpBodySetCenterOfGravity, :void
		import :cpBodyGetVelocity, :cpVect
		import :cpBodySetVelocity, :void
		import :cpBodyGetForce, :cpVect
		import :cpBodySetForce, :void
		import :cpBodyGetAngle, :cpFloat
		import :cpBodySetAngle, :void
		import :cpBodyGetAngularVelocity, :cpFloat
		import :cpBodySetAngularVelocity, :void
		import :cpBodyGetTorque, :cpFloat
		import :cpBodySetTorque, :void
		import :cpBodyGetRotation, :cpVect
		import :cpBodyGetUserData, :cpDataPointer
		import :cpBodySetUserData, :void
		import :cpBodySetVelocityUpdateFunc, :void
		import :cpBodySetPositionUpdateFunc, :void
		import :cpBodyUpdateVelocity, :void
		import :cpBodyUpdatePosition, :void
		import :cpBodyLocalToWorld, :cpVect
		import :cpBodyWorldToLocal, :cpVect
		import :cpBodyApplyForceAtWorldPoint, :void
		import :cpBodyApplyForceAtLocalPoint, :void
		import :cpBodyApplyImpulseAtWorldPoint, :void
		import :cpBodyApplyImpulseAtLocalPoint, :void
		import :cpBodyGetVelocityAtWorldPoint, :cpVect
		import :cpBodyGetVelocityAtLocalPoint, :cpVect
		import :cpBodyKineticEnergy, :cpFloat
		import :cpBodyEachShape, :void
		import :cpBodyEachConstraint, :void
		import :cpBodyEachArbiter, :void
		import :cpConstraintDestroy, :void
		import :cpConstraintFree, :void
		import :cpConstraintGetSpace, :pointer
		import :cpConstraintGetBodyA, :pointer
		import :cpConstraintGetBodyB, :pointer
		import :cpConstraintGetMaxForce, :cpFloat
		import :cpConstraintSetMaxForce, :void
		import :cpConstraintGetErrorBias, :cpFloat
		import :cpConstraintSetErrorBias, :void
		import :cpConstraintGetMaxBias, :cpFloat
		import :cpConstraintSetMaxBias, :void
		import :cpConstraintGetCollideBodies, :cpBool
		import :cpConstraintSetCollideBodies, :void
		import :cpConstraintGetPreSolveFunc, :pointer
		import :cpConstraintSetPreSolveFunc, :void
		import :cpConstraintGetPostSolveFunc, :pointer
		import :cpConstraintSetPostSolveFunc, :void
		import :cpConstraintGetUserData, :cpDataPointer
		import :cpConstraintSetUserData, :void
		import :cpConstraintGetImpulse, :cpFloat
		import :cpConstraintIsDampedRotarySpring, :cpBool
		import :cpDampedRotarySpringAlloc, :pointer
		import :cpDampedRotarySpringInit, :pointer
		import :cpDampedRotarySpringNew, :pointer
		import :cpDampedRotarySpringGetRestAngle, :cpFloat
		import :cpDampedRotarySpringSetRestAngle, :void
		import :cpDampedRotarySpringGetStiffness, :cpFloat
		import :cpDampedRotarySpringSetStiffness, :void
		import :cpDampedRotarySpringGetDamping, :cpFloat
		import :cpDampedRotarySpringSetDamping, :void
		import :cpDampedRotarySpringGetSpringTorqueFunc, :pointer
		import :cpDampedRotarySpringSetSpringTorqueFunc, :void
		import :cpConstraintIsDampedSpring, :cpBool
		import :cpDampedSpringAlloc, :pointer
		import :cpDampedSpringInit, :pointer
		import :cpDampedSpringNew, :pointer
		import :cpDampedSpringGetAnchorA, :cpVect
		import :cpDampedSpringSetAnchorA, :void
		import :cpDampedSpringGetAnchorB, :cpVect
		import :cpDampedSpringSetAnchorB, :void
		import :cpDampedSpringGetRestLength, :cpFloat
		import :cpDampedSpringSetRestLength, :void
		import :cpDampedSpringGetStiffness, :cpFloat
		import :cpDampedSpringSetStiffness, :void
		import :cpDampedSpringGetDamping, :cpFloat
		import :cpDampedSpringSetDamping, :void
		import :cpDampedSpringGetSpringForceFunc, :pointer
		import :cpDampedSpringSetSpringForceFunc, :void
		import :cpConstraintIsGearJoint, :cpBool
		import :cpGearJointAlloc, :pointer
		import :cpGearJointInit, :pointer
		import :cpGearJointNew, :pointer
		import :cpGearJointGetPhase, :cpFloat
		import :cpGearJointSetPhase, :void
		import :cpGearJointGetRatio, :cpFloat
		import :cpGearJointSetRatio, :void
		import :cpConstraintIsGrooveJoint, :cpBool
		import :cpGrooveJointAlloc, :pointer
		import :cpGrooveJointInit, :pointer
		import :cpGrooveJointNew, :pointer
		import :cpGrooveJointGetGrooveA, :cpVect
		import :cpGrooveJointSetGrooveA, :void
		import :cpGrooveJointGetGrooveB, :cpVect
		import :cpGrooveJointSetGrooveB, :void
		import :cpGrooveJointGetAnchorB, :cpVect
		import :cpGrooveJointSetAnchorB, :void
		import :cpMarchSoft, :void
		import :cpMarchHard, :void
		import :cpConstraintIsPinJoint, :cpBool
		import :cpPinJointAlloc, :pointer
		import :cpPinJointInit, :pointer
		import :cpPinJointNew, :pointer
		import :cpPinJointGetAnchorA, :cpVect
		import :cpPinJointSetAnchorA, :void
		import :cpPinJointGetAnchorB, :cpVect
		import :cpPinJointSetAnchorB, :void
		import :cpPinJointGetDist, :cpFloat
		import :cpPinJointSetDist, :void
		import :cpConstraintIsPivotJoint, :cpBool
		import :cpPivotJointAlloc, :pointer
		import :cpPivotJointInit, :pointer
		import :cpPivotJointNew, :pointer
		import :cpPivotJointNew2, :pointer
		import :cpPivotJointGetAnchorA, :cpVect
		import :cpPivotJointSetAnchorA, :void
		import :cpPivotJointGetAnchorB, :cpVect
		import :cpPivotJointSetAnchorB, :void
		import :cpPolylineFree, :void
		import :cpPolylineIsClosed, :cpBool
		import :cpPolylineSetDestroy, :void
		import :cpPolylineSetCollectSegment, :void
		import :cpPolyShapeAlloc, :pointer
		import :cpPolyShapeInit, :pointer
		import :cpPolyShapeInitRaw, :pointer
		import :cpPolyShapeNew, :pointer
		import :cpPolyShapeNewRaw, :pointer
		import :cpBoxShapeInit, :pointer
		import :cpBoxShapeInit2, :pointer
		import :cpBoxShapeNew, :pointer
		import :cpBoxShapeNew2, :pointer
		import :cpPolyShapeGetCount, :int
		import :cpPolyShapeGetVert, :cpVect
		import :cpPolyShapeGetRadius, :cpFloat
		import :cpConstraintIsRatchetJoint, :cpBool
		import :cpRatchetJointAlloc, :pointer
		import :cpRatchetJointInit, :pointer
		import :cpRatchetJointNew, :pointer
		import :cpRatchetJointGetAngle, :cpFloat
		import :cpRatchetJointSetAngle, :void
		import :cpRatchetJointGetPhase, :cpFloat
		import :cpRatchetJointSetPhase, :void
		import :cpRatchetJointGetRatchet, :cpFloat
		import :cpRatchetJointSetRatchet, :void
		import :cpConstraintIsRotaryLimitJoint, :cpBool
		import :cpRotaryLimitJointAlloc, :pointer
		import :cpRotaryLimitJointInit, :pointer
		import :cpRotaryLimitJointNew, :pointer
		import :cpRotaryLimitJointGetMin, :cpFloat
		import :cpRotaryLimitJointSetMin, :void
		import :cpRotaryLimitJointGetMax, :cpFloat
		import :cpRotaryLimitJointSetMax, :void
		import :cpShapeDestroy, :void
		import :cpShapeFree, :void
		import :cpShapeCacheBB, :cpBB
		import :cpShapeUpdate, :cpBB
		import :cpShapePointQuery, :cpFloat
		import :cpShapeSegmentQuery, :cpBool
		import :cpShapesCollide, :cpContactPointSet
		import :cpShapeGetSpace, :pointer
		import :cpShapeGetBody, :pointer
		import :cpShapeSetBody, :void
		import :cpShapeSetMass, :void
		import :cpShapeGetDensity, :cpFloat
		import :cpShapeSetDensity, :void
		import :cpShapeGetMoment, :cpFloat
		import :cpShapeGetArea, :cpFloat
		import :cpShapeGetCenterOfGravity, :cpVect
		import :cpShapeGetBB, :cpBB
		import :cpShapeGetSensor, :cpBool
		import :cpShapeSetSensor, :void
		import :cpShapeGetElasticity, :cpFloat
		import :cpShapeSetElasticity, :void
		import :cpShapeGetFriction, :cpFloat
		import :cpShapeSetFriction, :void
		import :cpShapeGetSurfaceVelocity, :cpVect
		import :cpShapeSetSurfaceVelocity, :void
		import :cpShapeGetUserData, :cpDataPointer
		import :cpShapeSetUserData, :void
		import :cpShapeGetCollisionType, :cpCollisionType
		import :cpShapeSetCollisionType, :void
		import :cpShapeGetFilter, :cpShapeFilter
		import :cpShapeSetFilter, :void
		import :cpCircleShapeAlloc, :pointer
		import :cpCircleShapeInit, :pointer
		import :cpCircleShapeNew, :pointer
		import :cpCircleShapeGetOffset, :cpVect
		import :cpCircleShapeGetRadius, :cpFloat
		import :cpSegmentShapeAlloc, :pointer
		import :cpSegmentShapeInit, :pointer
		import :cpSegmentShapeNew, :pointer
		import :cpSegmentShapeSetNeighbors, :void
		import :cpSegmentShapeGetA, :cpVect
		import :cpSegmentShapeGetB, :cpVect
		import :cpSegmentShapeGetNormal, :cpVect
		import :cpSegmentShapeGetRadius, :cpFloat
		import :cpConstraintIsSimpleMotor, :cpBool
		import :cpSimpleMotorAlloc, :pointer
		import :cpSimpleMotorInit, :pointer
		import :cpSimpleMotorNew, :pointer
		import :cpSimpleMotorGetRate, :cpFloat
		import :cpSimpleMotorSetRate, :void
		import :cpConstraintIsSlideJoint, :cpBool
		import :cpSlideJointAlloc, :pointer
		import :cpSlideJointInit, :pointer
		import :cpSlideJointNew, :pointer
		import :cpSlideJointGetAnchorA, :cpVect
		import :cpSlideJointSetAnchorA, :void
		import :cpSlideJointGetAnchorB, :cpVect
		import :cpSlideJointSetAnchorB, :void
		import :cpSlideJointGetMin, :cpFloat
		import :cpSlideJointSetMin, :void
		import :cpSlideJointGetMax, :cpFloat
		import :cpSlideJointSetMax, :void
		import :cpSpaceAlloc, :pointer
		import :cpSpaceInit, :pointer
		import :cpSpaceNew, :pointer
		import :cpSpaceDestroy, :void
		import :cpSpaceFree, :void
		import :cpSpaceGetIterations, :int
		import :cpSpaceSetIterations, :void
		import :cpSpaceGetGravity, :cpVect
		import :cpSpaceSetGravity, :void
		import :cpSpaceGetDamping, :cpFloat
		import :cpSpaceSetDamping, :void
		import :cpSpaceGetIdleSpeedThreshold, :cpFloat
		import :cpSpaceSetIdleSpeedThreshold, :void
		import :cpSpaceGetSleepTimeThreshold, :cpFloat
		import :cpSpaceSetSleepTimeThreshold, :void
		import :cpSpaceGetCollisionSlop, :cpFloat
		import :cpSpaceSetCollisionSlop, :void
		import :cpSpaceGetCollisionBias, :cpFloat
		import :cpSpaceSetCollisionBias, :void
		import :cpSpaceGetCollisionPersistence, :cpTimestamp
		import :cpSpaceSetCollisionPersistence, :void
		import :cpSpaceGetUserData, :cpDataPointer
		import :cpSpaceSetUserData, :void
		import :cpSpaceGetStaticBody, :pointer
		import :cpSpaceGetCurrentTimeStep, :cpFloat
		import :cpSpaceIsLocked, :cpBool
		import :cpSpaceAddShape, :pointer
		import :cpSpaceAddBody, :pointer
		import :cpSpaceAddConstraint, :pointer
		import :cpSpaceRemoveShape, :void
		import :cpSpaceRemoveBody, :void
		import :cpSpaceRemoveConstraint, :void
		import :cpSpaceContainsShape, :cpBool
		import :cpSpaceContainsBody, :cpBool
		import :cpSpaceContainsConstraint, :cpBool
		import :cpSpaceAddPostStepCallback, :cpBool
		import :cpSpacePointQuery, :void
		import :cpSpaceSegmentQuery, :void
		import :cpSpaceBBQuery, :void
		import :cpSpaceShapeQuery, :cpBool
		import :cpSpaceEachBody, :void
		import :cpSpaceEachShape, :void
		import :cpSpaceEachConstraint, :void
		import :cpSpaceReindexStatic, :void
		import :cpSpaceReindexShape, :void
		import :cpSpaceReindexShapesForBody, :void
		import :cpSpaceUseSpatialHash, :void
		import :cpSpaceStep, :void
		import :cpSpaceDebugDraw, :void
		import :cpSpaceHashAlloc, :pointer
		import :cpSpaceHashInit, :pointer
		import :cpSpaceHashNew, :pointer
		import :cpSpaceHashResize, :void
		import :cpBBTreeAlloc, :pointer
		import :cpBBTreeInit, :pointer
		import :cpBBTreeNew, :pointer
		import :cpBBTreeOptimize, :void
		import :cpBBTreeSetVelocityFunc, :void
		import :cpSweep1DAlloc, :pointer
		import :cpSweep1DInit, :pointer
		import :cpSweep1DNew, :pointer
	end
end
#==============================================================================
# Numeric
#------------------------------------------------------------------------------
# Classe dos números
#==============================================================================
class Numeric
	#--------------------------------------------------------------------------
	# Limita um número entre outros dois
	#--------------------------------------------------------------------------
	def clamp min, max
		[[self, min].max, max].min
	end
end
#==============================================================================
# Float
#------------------------------------------------------------------------------
# Classe dos números de ponto flutuante
#==============================================================================
class Float
	#--------------------------------------------------------------------------
	# Interpola linearmente entre f1 e f2
	#--------------------------------------------------------------------------
	def self.lerp f1, f2, t
		f1 * (1.0 - self) + f2 * self
	end
	#--------------------------------------------------------------------------
	# Interpola linearmente entre f1 e f2
	#--------------------------------------------------------------------------
	def self.lerpconst f1, f2, d
		f1 + (f2 - f1).clamp(-d, d)
	end
	#--------------------------------------------------------------------------
	# Módulo
	#--------------------------------------------------------------------------
	def %(other)
		return self.modulo(other)
	end
end