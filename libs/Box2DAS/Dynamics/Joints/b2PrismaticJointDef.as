package Box2DAS.Dynamics.Joints {

	import Box2DAS.Common.V2;
	import Box2DAS.Common.b2Vec2;
	import Box2DAS.Dynamics.b2Body;
	import Box2DAS.Dynamics.b2World;

	import flash.events.IEventDispatcher;
	
	/// Prismatic joint definition. This requires defining a line of
	/// motion using an axis and an anchor point. The definition uses local
	/// anchor points and a local axis so that the initial configuration
	/// can violate the constraint slightly. The joint translation is zero
	/// when the local anchor points coincide in world space. Using local
	/// anchors and a local axis helps when saving and loading a game.
	public class b2PrismaticJointDef extends b2JointDef {

		public override function create(w:b2World, ed:IEventDispatcher = null):b2Joint {
			return new b2PrismaticJoint(w, this, ed);
		}
				
		public function b2PrismaticJointDef() {
			_ptr = lib.b2PrismaticJointDef_new();
			localAnchorA = new b2Vec2(_ptr + 20);
			localAnchorB = new b2Vec2(_ptr + 28);
			localAxis1 = new b2Vec2(_ptr + 36);
		}
		
		public override function destroy():void {
			lib.b2PrismaticJointDef_delete(_ptr);
			super.destroy();
		}
		
		/// Initialize the bodies, anchors, axis, and reference angle using the world
		/// anchor and world axis.
		/// void Initialize(b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor, const b2Vec2& axis);
		public function Initialize(b1:b2Body, b2:b2Body, anchor:V2, axis:V2):void {
			bodyA = b1;
			bodyB = b2;
			localAnchorA.v2 = bodyA.GetLocalPoint(anchor);
			localAnchorB.v2 = bodyB.GetLocalPoint(anchor);
			localAxis1.v2 = bodyA.GetLocalVector(axis);
			referenceAngle = bodyB.GetAngle() - bodyA.GetAngle();
		}
		
		/// The local anchor point relative to bodyA's origin.
		public var localAnchorA:b2Vec2;

		/// The local anchor point relative to bodyB's origin.
		public var localAnchorB:b2Vec2;

		/// The local translation axis in bodyA.
		public var localAxis1:b2Vec2;
		
		/// The constrained angle between the bodies: bodyB_angle - bodyA_angle.
		public function get referenceAngle():Number { return mem._mrf(_ptr + 44); }
		public function set referenceAngle(v:Number):void { mem._mwf(_ptr + 44, v); }

		/// Enable/disable the joint limit.
		public function get enableLimit():Boolean { return mem._mru8(_ptr + 48) == 1; }
		public function set enableLimit(v:Boolean):void { mem._mw8(_ptr + 48, v ? 1 : 0); }

		/// The lower translation limit, usually in meters.
		public function get lowerTranslation():Number { return mem._mrf(_ptr + 52); }
		public function set lowerTranslation(v:Number):void { mem._mwf(_ptr + 52, v); }

		/// The upper translation limit, usually in meters.
		public function get upperTranslation():Number { return mem._mrf(_ptr + 56); }
		public function set upperTranslation(v:Number):void { mem._mwf(_ptr + 56, v); }

		/// Enable/disable the joint motor.
		public function get enableMotor():Boolean { return mem._mru8(_ptr + 60) == 1; }
		public function set enableMotor(v:Boolean):void { mem._mw8(_ptr + 60, v ? 1 : 0); }

		/// The maximum motor torque, usually in N-m.
		public function get maxMotorForce():Number { return mem._mrf(_ptr + 64); }
		public function set maxMotorForce(v:Number):void { mem._mwf(_ptr + 64, v); }

		/// The desired motor speed in radians per second.
		public function get motorSpeed():Number { return mem._mrf(_ptr + 68); }
		public function set motorSpeed(v:Number):void { mem._mwf(_ptr + 68, v); }
	
	}
}