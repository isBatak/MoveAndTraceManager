package
{
	import feathers.controls.Button;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.extensions.managers.moveandtrace.MoveAndTraceManager;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			new MetalWorksDesktopTheme();
			
			var q1:Button = new Button();
			q1.label = "Feathers Button";
			q1.name = "q1";
			
			var q2:Quad = new Quad(100, 100, 0xff0000);
			q2.name = "q2";
			
			addChild(q1);
			addChild(q2);
			
			MoveAndTraceManager.getInstance().add( q1 );
			MoveAndTraceManager.getInstance().add( q2 );
			
		}
	}
}