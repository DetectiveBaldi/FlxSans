package game;

import flixel.FlxSprite;

import flixel.group.FlxGroup;

import flixel.math.FlxMath;

import flixel.util.FlxCollision;
import flixel.util.FlxTimer;

import core.Assets;
import core.Paths;

class GasterBlaster extends FlxGroup
{
    public var soul:Soul;

    public var timestamp:Float;

    public var shootTimestamp:Float;

    public var shootTimer:FlxTimer;

    public var onShoot:(blaster:GasterBlaster)->Void;

    public var endTimestamp:Float;

    public var endTimer:FlxTimer;

    public var onEnd:(blaster:GasterBlaster)->Void;

    public var fromX:Float;

    public var fromY:Float;

    public var toX:Float;

    public var toY:Float;

    public var fromAngle:Float;

    public var toAngle:Float;

    public var speed:Float;

    public var blaster:FlxSprite;

    public var beam:FlxSprite;

    public function new(soul:Soul, shootTimestamp:Float, endTimestamp:Float, onShoot:(blaster:GasterBlaster)->Void, onEnd:(blaster:GasterBlaster)->Void, fromX:Float = 0.0, fromY:Float = 0.0, toX:Float, toY:Float, fromAngle:Float, toAngle:Float, scaleX:Float, scaleY:Float, speed:Float):Void
    {
        super();

        this.soul = soul;

        timestamp = 0.0;

        this.shootTimestamp = shootTimestamp;

        this.onShoot = onShoot;

        this.endTimestamp = endTimestamp;

        this.onEnd = onEnd;

        this.fromX = fromX;

        this.fromY = fromY;

        this.toX = toX;

        this.toY = toY;

        this.fromAngle = fromAngle;

        this.toAngle = toAngle;

        this.speed = speed;

        blaster = new FlxSprite(fromX, fromY, Assets.getGraphic(Paths.png("assets/images/game/GasterBlaster/blasterClosed")));

        blaster.active = false;

        blaster.angle = fromAngle;

        blaster.scale.set(scaleX, scaleY);

        blaster.updateHitbox();

        add(blaster);

        beam = new FlxSprite(0.0, 0.0, Assets.getGraphic(Paths.png("assets/images/game/GasterBlaster/blasterBeam")));

        beam.active = false;

        beam.visible = false;

        beam.flipX = true;

        beam.scale.set(scaleX * 2.0, scaleY * 2.0);

        beam.updateHitbox();

        insert(0, beam);

        shootTimer = FlxTimer.wait(shootTimestamp, () ->
        {
            if (onShoot != null)
                onShoot(this);

            blaster.loadGraphic(Assets.getGraphic(Paths.png("assets/images/game/GasterBlaster/blasterOpen")));

            blaster.updateHitbox();

            beam.visible = true;

            beam.angle = blaster.angle;

            beam.setPosition(blaster.getMidpoint().x - beam.width * 0.5, blaster.getMidpoint().y - beam.height * 0.5);
        });

        endTimer = FlxTimer.wait(endTimestamp, () ->
        {
            if (onEnd != null)
                onEnd(this);
        });
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        timestamp += elapsed;
        
        if (timestamp >= shootTimestamp)
        {
            blaster.alpha = 0.0 + (blaster.alpha - 0.0) * Math.exp(-speed * elapsed);

            blaster.setPosition(fromX + (blaster.x - fromX) * Math.exp(-speed * elapsed), fromY + (blaster.y - fromY) * Math.exp(-speed * elapsed));

            beam.alpha = 0.0 + (beam.alpha - 0.0) * Math.exp(-speed * 2.0 * elapsed);
        }
        else
        {
            blaster.setPosition(toX + (blaster.x - toX) * Math.exp(-speed * elapsed), toY + (blaster.y - toY) * Math.exp(-speed * elapsed));

            blaster.angle = toAngle + (blaster.angle - toAngle) * Math.exp(-speed * elapsed);
        }
    }

    override function destroy():Void
    {
        super.destroy();

        shootTimer.cancel();

        endTimer.cancel();
    }
}