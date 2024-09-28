package game;

import flixel.group.FlxContainer.FlxTypedContainer;

import flixel.math.FlxPoint;

class GasterWheel extends FlxTypedContainer<GasterBlaster>
{
    public var cycleCount:Int;

    public var currentBlaster:Int;

    public var spawnInterval:Float;

    public var spawnTimestamp:Float;

    public var origin:FlxPoint;

    public var fromOffset:Float;

    public var toOffset:Float;

    public var angleOffset:Float;

    public var clockwise:Bool;

    public function new(cycleCount:Int, spawnInterval:Float, origin:FlxPoint, fromOffset:Float, toOffset:Float, angleOffset:Float, clockwise:Bool):Void
    {
        super();

        this.cycleCount = cycleCount;

        currentBlaster = 0;

        this.spawnInterval = spawnInterval;

        spawnTimestamp = 0.0;

        this.origin = origin;

        this.fromOffset = fromOffset;

        this.toOffset = toOffset;

        this.angleOffset = angleOffset;

        this.clockwise = clockwise;
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        spawnTimestamp += elapsed;

        if (spawnTimestamp >= spawnInterval)
        {
            var fromX:Float = origin.x + fromOffset * Math.cos((currentBlaster / cycleCount) * Math.PI * 2.0 + angleOffset * Math.PI / 180.0 * (clockwise ? 1.0 : -1.0));

            var fromY:Float = origin.y + fromOffset * Math.sin((currentBlaster / cycleCount) * Math.PI * 2.0 + angleOffset * Math.PI / 180.0 * (clockwise ? 1.0 : -1.0));

            var toX:Float = origin.x + toOffset * Math.cos((currentBlaster / cycleCount) * Math.PI * 2.0 + angleOffset * Math.PI / 180.0 * (clockwise ? 1.0 : -1.0));

            var toY:Float = origin.y + toOffset * Math.sin((currentBlaster / cycleCount) * Math.PI * 2.0 + angleOffset * Math.PI / 180.0 * (clockwise ? 1.0 : -1.0));

            var angle:Float = Math.atan2(origin.y - fromY, origin.x - fromX) * 180.0 / Math.PI;

            var blaster:GasterBlaster = new GasterBlaster(1.5, 3.5, (blaster:GasterBlaster) -> remove(blaster, true).destroy(), fromX, fromY, toX, toY, angle, angle, 10.0, 5.0, 5.0);

            add(blaster);

            currentBlaster++;

            spawnTimestamp = 0.0;
        }
    }
}