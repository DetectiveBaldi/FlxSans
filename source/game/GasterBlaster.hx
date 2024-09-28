package game;

import flixel.FlxSprite;

import flixel.group.FlxContainer;

import flixel.math.FlxMath;

import core.AssetMan;
import core.Paths;

class GasterBlaster extends FlxContainer
{
    public var timestamp:Float;

    public var shootTimestamp:Float;

    public var endTimestamp:Float;

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

    public function new(shootTimestamp:Float, endTimestamp:Float, onEnd:(blaster:GasterBlaster)->Void, fromX:Float = 0.0, fromY:Float = 0.0, toX:Float, toY:Float, fromAngle:Float, toAngle:Float, scaleX:Float, scaleY:Float, speed:Float):Void
    {
        super();

        timestamp = 0.0;

        this.shootTimestamp = shootTimestamp;

        this.endTimestamp = endTimestamp;

        this.onEnd = onEnd;

        this.fromX = fromX;

        this.fromY = fromY;

        this.toX = toX;

        this.toY = toY;

        this.fromAngle = fromAngle;

        this.toAngle = toAngle;

        this.speed = speed;

        blaster = new FlxSprite(fromX, fromY, AssetMan.graphic(Paths.png("assets/images/blasterClosed")));

        blaster.angle = fromAngle;

        blaster.scale.set(scaleX, scaleY);

        blaster.updateHitbox();

        add(blaster);

        beam = new FlxSprite(0.0, 0.0, AssetMan.graphic(Paths.png("assets/images/blasterBeam")));

        beam.visible = false;

        beam.flipX = true;

        beam.scale.set(scaleX * 2.0, scaleY * 2.0);

        beam.updateHitbox();

        insert(0, beam);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        timestamp += elapsed;
        
        if (timestamp >= shootTimestamp)
        {
            blaster.loadGraphic(AssetMan.graphic(Paths.png("assets/images/blasterOpen")));

            blaster.updateHitbox();

            beam.visible = true;

            blaster.alpha = FlxMath.lerp(blaster.alpha, 0.0, speed * elapsed);
            
            blaster.x = FlxMath.lerp(blaster.x, fromX, speed * elapsed);

            blaster.y = FlxMath.lerp(blaster.y, fromY, speed * elapsed);

            beam.alpha = FlxMath.lerp(beam.alpha, 0.0, speed * elapsed);

            beam.angle = blaster.angle;

            beam.setPosition(blaster.getMidpoint().x - beam.width * 0.5, blaster.getMidpoint().y - beam.height * 0.5);
        }
        else
        {
            blaster.setPosition(FlxMath.lerp(blaster.x, toX, speed * elapsed), FlxMath.lerp(blaster.y, toY, speed * elapsed));

            blaster.angle = FlxMath.lerp(blaster.angle, toAngle, speed * elapsed);
        }

        if (timestamp >= endTimestamp)
        {
            if (onEnd != null)
                onEnd(this);
        }
    }
}