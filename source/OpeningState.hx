package;

import flixel.FlxG;
import flixel.FlxState;

import flixel.util.typeLimit.NextState;

import core.AssetMan;

import ui.PerfTracker;

import util.MathUtil;

class OpeningState extends FlxState
{
    public var nextState:NextState;

    public function new(nextState:NextState):Void
    {
        super();

        this.nextState = nextState;
    }

    override function create():Void
    {
        super.create();

        #if !html5
            FlxG.autoPause = false;
        #end

        FlxG.fixedTimestep = false;

        FlxG.updateFramerate = MathUtil.maxInt(FlxG.stage.window.displayMode.refreshRate, 144);

        FlxG.drawFramerate = MathUtil.maxInt(FlxG.stage.window.displayMode.refreshRate, 144);

        FlxG.mouse.visible = false;

        AssetMan.init();

        var perfTracker:PerfTracker = new PerfTracker(10.0, 5.0);
        
        FlxG.game.addChild(perfTracker);

        FlxG.switchState(nextState);
    }
}