package game;

import flixel.FlxG;
import flixel.FlxState;

import flixel.math.FlxPoint;

import flixel.util.FlxColor;

import ui.BorderedBox;

class GameState extends FlxState
{
    public var borderedBox:BorderedBox;

    public var soul:Soul;

    public var gasterWheel:GasterWheel;

    override function create():Void
    {
        super.create();

        FlxG.camera.bgColor = FlxColor.GRAY;

        borderedBox = new BorderedBox(0.0, 0.0, 240.0, 240.0, 16.0, 16.0, 5.0);

        borderedBox.setSize(240.0, 240.0, 24.0, 24.0);

        borderedBox.screenCenter();

        add(borderedBox);

        soul = new Soul();

        soul.borderedBox = borderedBox;

        soul.mode = BLUE;

        soul.screenCenter();

        add(soul);

        gasterWheel = new GasterWheel(soul, 32, 0.05, FlxPoint.get((FlxG.width - 176.0) * 0.5, (FlxG.height - 128.0) * 0.5), 480.0, 320.0, 2.75, 2.0, 180, false);

        gasterWheel.prep.pitch = 1.2;

        add(gasterWheel);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE)
        {
            soul.mode = soul.mode == RED ? BLUE : RED;

            if (soul.bell.playing)
                soul.bell.time = 0.0;
            else
                soul.bell.play(true);
        }

        if (FlxG.keys.justPressed.TAB)
        {
            if (soul.mode == BLUE)
            {
                soul.angle = (soul.angle + 90.0) % 360.0;

                if (soul.bell.playing)
                    soul.bell.time = 0.0;
                else
                    soul.bell.play(true);

                soul.flip();
            }
        }

        if (FlxG.keys.justPressed.ESCAPE)
            FlxG.resetState();
    }
}