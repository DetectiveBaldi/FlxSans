package game;

import flixel.FlxG;

import flixel.math.FlxAngle;
import flixel.math.FlxPoint;

import flixel.sound.FlxSound;

import core.Assets;
import core.Paths;

class GasterWheel extends Atk
{
    public var cycleCount:Int;

    public var currentBlaster:Int;

    public var spawnInterval:Float;

    public var spawnTimestamp:Float;

    public var origin:FlxPoint;

    public var fromOffset:Float;

    public var toOffset:Float;

    public var scaleX:Float;

    public var scaleY:Float;

    public var angleOffset:Float;

    public var clockwise:Bool;

    public var prep:FlxSound;

    public var shot:FlxSound;

    public function new(soul:Soul, cycleCount:Int, spawnInterval:Float, origin:FlxPoint, fromOffset:Float, toOffset:Float, scaleX:Float, scaleY:Float, angleOffset:Float, clockwise:Bool):Void
    {
        super(soul);

        this.cycleCount = cycleCount;

        currentBlaster = 0;

        this.spawnInterval = spawnInterval;

        spawnTimestamp = 0.0;

        this.origin = origin;

        this.fromOffset = fromOffset;

        this.toOffset = toOffset;

        this.scaleX = scaleX;

        this.scaleY = scaleY;

        this.angleOffset = angleOffset + 180;

        this.clockwise = clockwise;

        prep = FlxG.sound.load(Assets.getSound(Paths.wav("assets/sounds/game/GasterBlaster/prep"), false), 0.5);

        shot = FlxG.sound.load(Assets.getSound(Paths.wav("assets/sounds/game/GasterBlaster/shot"), false), 0.5);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        spawnTimestamp += elapsed;

        if (spawnTimestamp >= spawnInterval)
            addGaster();
    }

    override function destroy():Void
    {
        super.destroy();

        origin.put();

        prep.destroy();

        shot.destroy();
    }

    public function addGaster():GasterBlaster
    {
        var posCalc:Float = ((currentBlaster / cycleCount) * Math.PI * 2.0 + angleOffset * FlxAngle.TO_RAD) * (clockwise ? 1.0 : -1.0);

        var startX:Float = origin.x + fromOffset * Math.cos(posCalc);

        var startY:Float = origin.y + fromOffset * Math.sin(posCalc);

        var midX:Float = origin.x + toOffset * Math.cos(posCalc);

        var midY:Float = origin.y + toOffset * Math.sin(posCalc);

        var angle:Float = Math.atan2(origin.y - startY, origin.x - startX) * FlxAngle.TO_DEG;

        var blaster:GasterBlaster = new GasterBlaster(soul, 1.5, 3.5, startX, startY, midX, midY, startX, startY, angle, angle, angle, scaleX, scaleY, 5.0);

        blaster.onShoot.addOnce(() ->
        {
            if (shot.playing)
                shot.time = 0.0;
            else
                shot.play();
        });

        blaster.onEnd.addOnce(() -> remove(blaster, true).destroy());

        add(blaster);

        currentBlaster++;

        spawnTimestamp = 0.0;

        if (prep.playing)
            prep.time = 0.0;
        else
            prep.play();

        return blaster;
    }
}