package game;

import flixel.FlxSprite;

import flixel.util.FlxTimer;
import flixel.util.FlxSignal;

import core.Assets;
import core.Paths;

class GasterBlaster extends Atk
{
    public var timestamp:Float;

    public var shootTimestamp:Float;

    public var shootTimer:FlxTimer;

    public var onShoot:FlxSignal;

    public var endTimestamp:Float;

    public var endTimer:FlxTimer;

    public var onEnd:FlxSignal;

    public var startX:Float;

    public var startY:Float;

    public var midX:Float;

    public var midY:Float;

    public var returnX:Float;

    public var returnY:Float;

    public var startRotation:Float;

    public var midRotation:Float;

    public var returnRotation:Float;

    public var speed:Float;

    public var blaster:FlxSprite;

    public var beam:FlxSprite;

    public function new(soul:Soul, shootTimestamp:Float, endTimestamp:Float, startX:Float, startY:Float, midX:Float, midY:Float, returnX:Float, returnY:Float, startRotation:Float, midRotation:Float, returnRotation:Float, scaleX:Float, scaleY:Float, speed:Float):Void
    {
        super(soul);

        timestamp = 0.0;

        this.shootTimestamp = shootTimestamp;

        onShoot = new FlxSignal();

        this.endTimestamp = endTimestamp;

        onEnd = new FlxSignal();

        this.startX = startX;

        this.startY = startY;

        this.midX = midX;

        this.midY = midY;

        this.returnX = returnX;

        this.returnY = returnY;

        this.startRotation = startRotation;

        this.midRotation = midRotation;

        this.returnRotation = returnRotation;

        this.speed = speed;

        blaster = new FlxSprite(startX, startY, Assets.getGraphic(Paths.png("assets/images/game/GasterBlaster/blasterClosed")));

        blaster.active = false;

        blaster.angle = startRotation;

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
            onShoot.dispatch();

            blaster.loadGraphic(Assets.getGraphic(Paths.png("assets/images/game/GasterBlaster/blasterOpen")));

            blaster.updateHitbox();

            beam.visible = true;

            beam.angle = blaster.angle;

            beam.setPosition(blaster.getMidpoint().x - beam.width * 0.5, blaster.getMidpoint().y - beam.height * 0.5);
        });

        endTimer = FlxTimer.wait(endTimestamp, onEnd.dispatch);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        timestamp += elapsed;
        
        if (timestamp >= shootTimestamp)
        {
            blaster.alpha = 0.0 + (blaster.alpha - 0.0) * Math.exp(-speed * elapsed);

            blaster.setPosition(returnX + (blaster.x - returnX) * Math.exp(-speed * elapsed), returnY + (blaster.y - returnY) * Math.exp(-speed * elapsed));

            beam.alpha = 0.0 + (beam.alpha - 0.0) * Math.exp(-speed * 2.0 * elapsed);
        }
        else
        {
            blaster.setPosition(midX + (blaster.x - midX) * Math.exp(-speed * elapsed), midY + (blaster.y - midY) * Math.exp(-speed * elapsed));

            blaster.angle = midRotation + (blaster.angle - midRotation) * Math.exp(-speed * elapsed);
        }
    }

    override function destroy():Void
    {
        super.destroy();

        shootTimer.cancel();

        endTimer.cancel();
    }
}