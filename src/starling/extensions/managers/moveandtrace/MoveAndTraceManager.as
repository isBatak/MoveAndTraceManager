/**
 * Created by martinbjeld on 8/1/14.
 */
package starling.extensions.managers.moveandtrace {
	import flash.system.System;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MoveAndTraceManager {
		
		// SINGLETON VARS
		
		private static var _instance:MoveAndTraceManager;
		private static var _allowInstantiation:Boolean;
		
		public static function getInstance():MoveAndTraceManager {
			if (!_instance) {
				_allowInstantiation = true;
				_instance = new MoveAndTraceManager();
				_allowInstantiation = false;
			}
			return _instance;
		}
		
		public function MoveAndTraceManager() {
			if (!_allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
			
			trace(" ****************************************************** ");
			trace(" ***** MoveAndTraceManager Initialized. ");
			trace(" ***** REMEMBER TO REMOVE ALL USAGE!!!  ");
			trace(" ****************************************************** ");
			
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, onTouch);
			_list = new <DisplayObject>[];
		}
		private var _curTarget:DisplayObject;
		private var _list:Vector.<DisplayObject>
		
		public function add(starlingDisplayObject:DisplayObject):void {
			_list.push(starlingDisplayObject);
		}
		
		// CLASS MEMBERS
		
		private function onTouch(event:TouchEvent):void {
			var t:Touch = event.getTouch(Starling.current.stage, TouchPhase.ENDED);
			if (!t) return;
			
			var touchObject:DisplayObject = event.target as DisplayObject;
			
			if (touchObject.name == null && event.shiftKey)
				touchObject.visible = false;
			
			for each(var obj:DisplayObject in _list) {
				if (obj.name == touchObject.name) {
					_curTarget = obj;
				}
			}
		}
		
		// ========================================================================================
		// API
		// ========================================================================================
		
		private function onKeyDown(event:KeyboardEvent):void {
			
			if (!_curTarget)
				return;
			
			var amount:int = event.shiftKey ? 10 : 1;
			
			switch (event.keyCode) {
				
				case Keyboard.E:
				{
					_curTarget.touchable = false;
					break;
				}
				case Keyboard.LEFT:
				{
					_curTarget.x -= amount;
					break;
				}
				case Keyboard.RIGHT:
				{
					_curTarget.x += amount;
					break;
				}
				case Keyboard.UP:
				{
					_curTarget.y -= amount;
					break;
				}
				case Keyboard.DOWN:
				{
					_curTarget.y += amount;
					break;
				}
			}
			
			trace("-- " + _curTarget.name + " --");
			trace("x: " + _curTarget.x);
			trace("y: " + _curTarget.y);
			
			var str:String = _curTarget.name + ".x = " + _curTarget.x + ";\n";
			str += _curTarget.name + ".y = " + _curTarget.y + ";\n";
			System.setClipboard(str);
			
		}
	}
}