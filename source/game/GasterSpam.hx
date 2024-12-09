package game;

import flixel.FlxG;

import flixel.math.FlxAngle;
import flixel.math.FlxMath;

import flixel.sound.FlxSound;

import core.Assets;
import core.Paths;

class GasterSpam extends Atk
{
    public var spawnInterval:Float;

    public var spawnTimestamp:Float;

    public var scaleX:Float;

    public var scaleY:Float;

    public var prep:FlxSound;

    public var shot:FlxSound;

    public function new(soul:Soul, spawnInterval:Float, scaleX:Float, scaleY:Float):Void
    {
        super(soul);

        this.spawnInterval = spawnInterval;

        this.scaleX = scaleX;

        this.scaleY = scaleY;

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

        prep.destroy();

        shot.destroy();
    }

    public function addGaster():GasterBlaster
    {
        spawnTimestamp = 0.0;

        var helperCalc:Float = 64.0 * scaleX;

        var _helperCalc:Float = 64.0 * scaleY;

        var __helperCalc:Float = soul.getMidpoint().x - helperCalc * 0.5;

        var ___helperCalc:Float = soul.getMidpoint().y - _helperCalc * 0.5;

        var ____helperCalc:Float = (Math.PI * 2.0 + FlxG.random.int(0, 360) * FlxAngle.TO_RAD);

        var startX:Float = FlxMath.bound(__helperCalc + FlxG.random.float(helperCalc, helperCalc * 2.0) * Math.cos(____helperCalc), 0.0, FlxG.width - helperCalc);

        var startY:Float = FlxMath.bound(___helperCalc + FlxG.random.float(_helperCalc, _helperCalc * 2.0) * Math.sin(____helperCalc), 0.0, FlxG.height - _helperCalc);

        var _____helperCalc:Float = Math.atan2(___helperCalc - startY, __helperCalc - startX);

        var midX:Float = startX;

        var midY:Float = startY;

        var returnX:Float = startX - Math.cos(_____helperCalc) * 240.0;

        var returnY:Float = startY - Math.sin(_____helperCalc) * 240.0;

        var angle:Float = _____helperCalc * FlxAngle.TO_DEG;

        var blaster:GasterBlaster = new GasterBlaster(soul, 1.5, 3.5, startX, startY, midX, midY, returnX, returnY, angle - FlxG.random.float(90.0, 180.0), angle, angle, scaleX, scaleY, 5.0);

        blaster.onShoot.addOnce(() -> 
        {
            if (shot.playing)
                shot.time = 0.0;
            else
                shot.play();
        });

        blaster.onEnd.addOnce(() -> remove(blaster, true).destroy());

        add(blaster);

        if (prep.playing)
            prep.time = 0.0;
        else
            prep.play();

        return blaster;
    }
}