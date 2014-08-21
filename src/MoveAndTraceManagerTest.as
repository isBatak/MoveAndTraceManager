package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(width="320", height="480", frameRate="30")]
	public class MoveAndTraceManagerTest extends Sprite
	{
		protected var _starling:Starling;
		
		public function MoveAndTraceManagerTest()
		{
			// Init stage.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 60;
			
			// No flash.display mouse interactivity.
			mouseEnabled = mouseChildren = false;
			
			// Init Starling.
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = false;
			_starling = new Starling( Game, stage, null, null, "auto", "auto" );
			_starling.enableErrorChecking = false;
			//_starling.showStats = true;
			//_starling.simulateMultitouch = true;
			_starling.start();

			// Update Starling view port on stage resizes.
			stage.addEventListener( Event.RESIZE, onStageResize, false, int.MAX_VALUE, true );
			stage.addEventListener( Event.DEACTIVATE, onStageDeactivate, false, 0, true );
		}
		
		private function onStageResize( event:Event ):void {
			if( stage.stageWidth < 256 || stage.stageHeight < 256 ) return;
			_starling.stage.stageWidth = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
			const viewPort:Rectangle = _starling.viewPort;
			viewPort.width = stage.stageWidth;
			viewPort.height = stage.stageHeight;
			try {
				_starling.viewPort = viewPort;
			}
			catch( e:Error ) {
				trace(e);
			}
		}
		
		private function onStageDeactivate( event:Event ):void {
			_starling.stop();
			stage.addEventListener( Event.ACTIVATE, onStageActivate, false, 0, true );
		}
		
		private function onStageActivate( event:Event ):void {
			stage.removeEventListener( Event.ACTIVATE, onStageActivate );
			_starling.start();
			_starling.stage.stageHeight = stage.stageHeight;
			const viewPort:Rectangle = _starling.viewPort;
			viewPort.width = stage.stageWidth;
			viewPort.height = stage.stageHeight;
			try {
				_starling.viewPort = viewPort;
			}
			catch( error:Error ) {
			}
		}
	}
}
