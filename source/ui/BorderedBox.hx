package ui;

import flixel.FlxG;
import flixel.FlxSprite;

import flixel.group.FlxContainer.FlxTypedContainer;

import flixel.math.FlxRect;
import flixel.math.FlxMath;

import flixel.util.FlxAxes;

import core.AssetMan;
import core.Paths;

class BorderedBox extends FlxTypedContainer<FlxSprite>
{
    public var bounds:FlxRect;

    public var borderWidth:Float;

    public var borderHeight:Float;

    public var speed:Float;

    public var center:FlxSprite;

    public var border:FlxSprite;

    public function new(x:Float = 0.0, y:Float = 0.0, width:Float = 240.0, height:Float = 240.0, borderWidth:Float = 16.0, borderHeight:Float = 16.0, speed:Float = 5.0):Void
    {
        super();

        bounds = FlxRect.get(x, y, width, height);

        this.borderWidth = borderWidth;

        this.borderHeight = borderHeight;

        this.speed = speed;

        center = new FlxSprite(0.0, 0.0, AssetMan.graphic(Paths.png("assets/images/ui/borderedBox/center")));

        center.updateHitbox();

        add(center);

        border = new FlxSprite(0.0, 0.0, AssetMan.graphic(Paths.png("assets/images/ui/borderedBox/border")));

        border.updateHitbox();

        insert(0, border);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        center.setPosition(FlxMath.lerp(center.x, bounds.x + borderWidth * 0.5, speed * elapsed), FlxMath.lerp(center.y, bounds.y + borderHeight * 0.5, speed * elapsed));

        border.setPosition(FlxMath.lerp(border.x, bounds.x, speed * elapsed), FlxMath.lerp(border.y, bounds.y, speed * elapsed));

        center.scale.set(FlxMath.lerp(center.scale.x, bounds.width, speed * elapsed), FlxMath.lerp(center.scale.y, bounds.height, speed * elapsed));

        center.updateHitbox();

        border.scale.set(FlxMath.lerp(border.scale.x, bounds.width + borderWidth, speed * elapsed), FlxMath.lerp(border.scale.y, bounds.height + borderHeight, speed * elapsed));

        border.updateHitbox();
    }

    public function setPosition(x:Float = 0.0, y:Float = 0.0):Void
    {
        bounds.x = x;

        bounds.y = y;
    }

    public function screenCenter(axes:FlxAxes = XY):BorderedBox
    {
        if (axes.x)
            bounds.x = (FlxG.width - bounds.width - borderWidth) * 0.5;

        if (axes.y)
            bounds.y = (FlxG.height - bounds.width - borderHeight) * 0.5;

        return this;
    }

    public function setSize(width:Float = 240.0, height:Float = 240.0, borderWidth:Float = 16.0, borderHeight:Float = 16.0):Void
    {
        bounds.width = width;

        bounds.height = height;

        this.borderWidth = borderWidth;

        this.borderHeight = borderHeight;
    }
}