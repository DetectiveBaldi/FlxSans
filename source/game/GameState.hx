package game;

import flixel.FlxG;
import flixel.FlxState;

import flixel.math.FlxPoint;

class GameState extends FlxState
{
    public var gasterWheel:GasterWheel;

    override function create():Void
    {
        super.create();

        FlxG.camera.zoom = 0.35;

        gasterWheel = new GasterWheel(32, 0.05, FlxPoint.get((FlxG.width - 640.0) * 0.5, (FlxG.height - 320.0) * 0.5), 1920.0, 1080.0, 0.0, false);

        add(gasterWheel);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
            FlxG.resetState();
    }
}