package game;

import flixel.FlxG;
import flixel.FlxState;

import flixel.math.FlxPoint;

import flixel.util.FlxColor;

import ui.BorderedBox;

class GameState extends FlxState
{
    public var borderedBox:BorderedBox;

    public var gasterWheel:GasterWheel;

    override function create():Void
    {
        super.create();

        FlxG.camera.bgColor = FlxColor.GRAY;

        borderedBox = new BorderedBox(0.0, 0.0, 240.0, 240.0, 16.0, 16.0, 5.0);

        borderedBox.screenCenter();

        add(borderedBox);

        gasterWheel = new GasterWheel(16, 0.1, FlxPoint.get((FlxG.width - 175.0) * 0.5, (FlxG.height - 112.0) * 0.5), 480.0, 320.0, 2.75, 1.75, 0.0, false);

        add(gasterWheel);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
            FlxG.resetState();
    }
}