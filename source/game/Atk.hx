package game;

import flixel.group.FlxGroup;

import flixel.util.FlxSignal;

class Atk extends FlxGroup
{
    public var soul:Soul;

    public var onHit:FlxSignal;

    public function new(soul:Soul):Void
    {
        super();

        this.soul = soul;

        onHit = new FlxSignal();
    }
}